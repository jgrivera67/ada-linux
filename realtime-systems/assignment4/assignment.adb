--
--  Copyright (c) 2021, German Rivera
--  All rights reserved.
--
--  Redistribution and use in source and binary forms, with or without
--  modification, are permitted provided that the following conditions are met:
--
--  * Redistributions of source code must retain the above copyright notice,
--    this list of conditions and the following disclaimer.
--
--  * Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
--  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
--  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
--  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
--  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
--  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
--  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
--  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
--  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
--  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
--  POSSIBILITY OF SUCH DAMAGE.
--
with Interfaces.C;
with System;
with pthread_h;
with syslog_h;
with stdlib_h;
with sched_h;
with sched_param_h;
with time_h;
with timespec_h;
with unistd_h;

package body Assignment is
   use Interfaces;
   use type C.int;
   use type C.long;
   use type C.unsigned;
   use type C.char_array;
   use type C.size_t;
   use type System.Address;

   NSEC_PER_SEC : constant := 1000000000;
   NSEC_PER_MSEC : constant := 1000000;

   Service1_Period_Ms : constant := 20;
   Service2_Period_Ms : constant := 100;
   Service3_Period_Ms : constant := 150;

   generic
      type Value_Type is (<>);
   function Generic_Value_to_C_Str (Value : Value_Type) return C.char_array;

   --  Convert scalar value to a C string without null terminator
   function Generic_Value_to_C_Str (Value : Value_Type) return C.char_array is
      C_Image_Str : constant c.char_array :=
         C.To_C (Value'Image, Append_Nul => False);
   begin
      return C_Image_Str (C_Image_Str'First + 1 .. C_Image_Str'Last);
   end Generic_Value_to_C_Str;

   function Value_to_C_Str is new Generic_Value_to_C_Str (Value_Type => C.int);

   function Value_to_C_Str is new Generic_Value_to_C_Str (Value_Type => C.long);

   --
   --  Set the priority of the main thread to the specified real-time
   --  priority, for the SCHED_FIFO scheduling policy
   --
   procedure Set_Main_Thread_Real_Time_Prio (Thread_Priority : C.int) is
      Pid : constant C.int := unistd_h.getpid;
      Sched_param : aliased sched_param_h.sched_param;
      C_Ret : C.int;
   begin
      C_Ret := sched_h.sched_getparam (Pid, Sched_param'Access);
      pragma Assert (C_Ret = 0);
      Sched_Param.sched_priority := Thread_Priority;

      --
      --  NOTE: `sched_setscheduler` will fail if the program is not run with sudo
      --
      C_Ret := sched_h.sched_setscheduler (Pid, sched_h.SCHED_FIFO,
                                           Sched_param'Access);
      pragma Assert (C_Ret = 0);
   end Set_Main_Thread_Real_Time_Prio;

   --
   --  Set the thread priority attribute for the given Thread attributes object,
   --  to the specified real-time priority, for the SCHED_FIFO scheduling policy
   --
   procedure Set_Real_Time_Thread_Attr (Thread_Attr : aliased out pthread_h.pthread_attr_t;
                                        Thread_Priority : C.int;
                                        Cpu_Id : C.int) is
      C_Ret : C.int;
      Sched_Param : aliased sched_param_h.sched_param;
      Cpu_Set : aliased pthread_h.cpu_set_t;
   begin
      C_Ret := pthread_h.pthread_attr_init (Thread_attr'Access);
      pragma Assert (C_Ret = 0);
      C_Ret := pthread_h.pthread_attr_setinheritsched (Thread_attr'Access, pthread_h.PTHREAD_EXPLICIT_SCHED);
      pragma Assert (C_Ret = 0);
      C_Ret := pthread_h.pthread_attr_setschedpolicy (Thread_attr'Access, sched_h.SCHED_FIFO);
      pragma Assert (C_Ret = 0);

      Sched_Param.sched_priority := Thread_Priority;
      C_Ret := pthread_h.pthread_attr_setschedparam(Thread_Attr'Access, Sched_Param'Access);
      pragma Assert (C_Ret = 0);

      Cpu_Set.cpu_mask (0) := C.unsigned_long (Shift_Left (Unsigned_32 (1), Integer (Cpu_Id)));
      C_Ret := pthread_h.pthread_attr_setaffinity_np (Thread_Attr'Access,
                                                      Cpu_Set'Size / System.Storage_Unit,
                                                      Cpu_Set'Access);
      pragma Assert (C_Ret = 0);
   end Set_Real_Time_Thread_Attr;

   --
   --  Compute ther next wakeup time given the last wakeup time and the wanted
   --  sleep time
   --
   function Calc_Next_Wakeup_Time (Time_Stamp : timespec_h.timespec;
                                   Sleep_Time_Ms : C.long)
      return timespec_h.timespec
      with Pre => Time_Stamp.tv_nsec < NSEC_PER_SEC and then
                  Sleep_Time_Ms > 0,
           Post => Calc_Next_Wakeup_Time'Result.tv_nsec < NSEC_PER_SEC
   is
      Secs_Increase : constant C.long :=
         (Time_Stamp.tv_nsec + (Sleep_Time_Ms * NSEC_PER_MSEC)) / NSEC_PER_SEC;
      Next_Time_Stamp : timespec_h.timespec;
   begin
      if Secs_Increase /= 0 then
         Next_Time_Stamp.tv_sec := Time_Stamp.tv_sec + Secs_Increase;
         Next_Time_Stamp.tv_nsec :=
            (Time_Stamp.tv_nsec + (Sleep_Time_Ms * NSEC_PER_MSEC)) mod NSEC_PER_SEC;
      else
         Next_Time_Stamp.tv_sec := Time_Stamp.tv_sec;
         Next_Time_Stamp.tv_nsec := Time_Stamp.tv_nsec + (Sleep_Time_Ms * NSEC_PER_MSEC);
      end if;

      return Next_Time_Stamp;
   end Calc_Next_Wakeup_Time;

   procedure Run_Assignment is
      function Service1_Thread_Func (arg : System.Address) return System.Address
        with Convention => C;

      function Service2_Thread_Func (arg : System.Address) return System.Address
        with Convention => C;

      function Service3_Thread_Func (arg : System.Address) return System.Address
        with Convention => C;

      --
      --  Child thread entry-point function for Service 1
      --
      function Service1_Thread_Func (arg : System.Address) return System.Address
      is
         Cpu_Id : constant C.int := sched_h.sched_getcpu;
         Cpu_Id_Str : constant C.char_array := Value_to_C_Str (Cpu_Id);
         Cnt : C.int:= 0;
         Current_Time : aliased timespec_h.timespec;
         Next_Wakeup_Time : aliased timespec_h.timespec;
         Remaining_Sleep_Time : aliased timespec_h.timespec;
         C_Ret : C.int;
      begin
         pragma Assert (arg = System.Null_Address);
         C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                        uu_tp => Current_Time'Access);
         pragma Assert (C_Ret = 0);

         Next_Wakeup_Time := Current_Time;
         loop
            Cnt := Cnt + 1;
            syslog_h.syslog (syslog_h.LOG_INFO,
                             "S1 50 Hz on core " & Cpu_Id_Str & " for release " &
                             Value_to_C_Str (Cnt) & " @ " &
                             Value_to_C_Str (Current_Time.tv_sec) & "s, " &
                             Value_to_C_Str (Current_Time.tv_nsec / NSEC_PER_MSEC) & "ms, " &
                             Value_to_C_Str (Current_Time.tv_nsec mod NSEC_PER_MSEC) & "ns" &
                             C.nul);

            Next_Wakeup_Time := Calc_Next_Wakeup_Time (Next_Wakeup_Time,
                                                       Service1_Period_Ms);

            --
            --  Check that we are not going to miss the next period:
            --  (or that we have not missed the current deadline)
            --
            C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                           uu_tp => Current_Time'Access);
            pragma Assert (C_Ret = 0);
            pragma Assert (Next_Wakeup_Time.tv_sec > Current_Time.tv_sec or else
                           (Next_Wakeup_Time.tv_sec = Current_Time.tv_sec and then
                            Next_Wakeup_Time.tv_nsec > Current_Time.tv_nsec));

            --
            --  Wait for next period:
            --
            C_Ret := time_h.clock_nanosleep (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                             uu_flags => time_h.TIMER_ABSTIME,
                                             uu_req => Next_Wakeup_Time'Access,
                                             uu_rem => Remaining_Sleep_Time'Access);
            pragma Assert (C_Ret = 0);

            --
            --  Check that we did not wake up too early:
            --
            C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                           uu_tp => Current_Time'Access);
            pragma Assert (C_Ret = 0);
            pragma Assert (Current_Time.tv_sec > Next_Wakeup_Time.tv_sec  or else
                           (Current_Time.tv_sec = Next_Wakeup_Time.tv_sec and then
                            Current_Time.tv_nsec >= Next_Wakeup_Time.tv_nsec));
         end loop;

         pragma warnings (off, "unreachable code");
         return System.Null_Address;
         pragma warnings (on, "unreachable code");
      end Service1_Thread_Func;

      --
      --  Child thread entry-point function for Service 2
      --
      function Service2_Thread_Func (arg : System.Address) return System.Address
      is
         Cpu_Id : constant C.int := sched_h.sched_getcpu;
         Cpu_Id_Str : constant C.char_array := Value_to_C_Str (Cpu_Id);
         Cnt : C.int:= 0;
         Current_Time : aliased timespec_h.timespec;
         Next_Wakeup_Time : aliased timespec_h.timespec;
         Remaining_Sleep_Time : aliased timespec_h.timespec;
         C_Ret : C.int;
      begin
         pragma Assert (arg = System.Null_Address);
         C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                        uu_tp => Current_Time'Access);
         pragma Assert (C_Ret = 0);

         Next_Wakeup_Time := Current_Time;
         loop
            Cnt := Cnt + 1;
            syslog_h.syslog (syslog_h.LOG_INFO,
                             "S2 10 Hz on core " & Cpu_Id_Str & " for release " &
                             Value_to_C_Str (Cnt) & " @ " &
                             Value_to_C_Str (Current_Time.tv_sec) & "s, " &
                             Value_to_C_Str (Current_Time.tv_nsec / NSEC_PER_MSEC) & "ms, " &
                             Value_to_C_Str (Current_Time.tv_nsec mod NSEC_PER_MSEC) & "ns" &
                             C.nul);

            Next_Wakeup_Time := Calc_Next_Wakeup_Time (Next_Wakeup_Time,
                                                       Service2_Period_Ms);

            --
            --  Check that we are not going to miss the next period:
            --  (or that we have not missed the current deadline)
            --
            C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                           uu_tp => Current_Time'Access);
            pragma Assert (C_Ret = 0);
            pragma Assert (Next_Wakeup_Time.tv_sec > Current_Time.tv_sec or else
                           (Next_Wakeup_Time.tv_sec = Current_Time.tv_sec and then
                            Next_Wakeup_Time.tv_nsec > Current_Time.tv_nsec));

            --
            --  Wait for next period:
            --
            C_Ret := time_h.clock_nanosleep (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                             uu_flags => time_h.TIMER_ABSTIME,
                                             uu_req => Next_Wakeup_Time'Access,
                                             uu_rem => Remaining_Sleep_Time'Access);
            pragma Assert (C_Ret = 0);

            --
            --  Check that we did not wake up too early:
            --
            C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                           uu_tp => Current_Time'Access);
            pragma Assert (C_Ret = 0);
            pragma Assert (Current_Time.tv_sec > Next_Wakeup_Time.tv_sec  or else
                           (Current_Time.tv_sec = Next_Wakeup_Time.tv_sec and then
                            Current_Time.tv_nsec >= Next_Wakeup_Time.tv_nsec));
         end loop;

         pragma warnings (off, "unreachable code");
         return System.Null_Address;
         pragma warnings (on, "unreachable code");
      end Service2_Thread_Func;

      --
      --  Child thread entry-point function for Service 3
      --
      function Service3_Thread_Func (arg : System.Address) return System.Address
      is
         Cpu_Id : constant C.int := sched_h.sched_getcpu;
         Cpu_Id_Str : constant C.char_array := Value_to_C_Str (Cpu_Id);
         Cnt : C.int:= 0;
         Current_Time : aliased timespec_h.timespec;
         Next_Wakeup_Time : aliased timespec_h.timespec;
         Remaining_Sleep_Time : aliased timespec_h.timespec;
         C_Ret : C.int;
      begin
         pragma Assert (arg = System.Null_Address);
         C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                        uu_tp => Current_Time'Access);
         pragma Assert (C_Ret = 0);

         Next_Wakeup_Time := Current_Time;
         loop
            Cnt := Cnt + 1;
            syslog_h.syslog (syslog_h.LOG_INFO,
                             "S3 6.66 Hz on core " & Cpu_Id_Str & " for release " &
                             Value_to_C_Str (Cnt) & " @ " &
                             Value_to_C_Str (Current_Time.tv_sec) & "s, " &
                             Value_to_C_Str (Current_Time.tv_nsec / NSEC_PER_MSEC) & "ms, " &
                             Value_to_C_Str (Current_Time.tv_nsec mod NSEC_PER_MSEC) & "ns" &
                             C.nul);

            Next_Wakeup_Time := Calc_Next_Wakeup_Time (Next_Wakeup_Time,
                                                       Service3_Period_Ms);

            --
            --  Check that we are not going to miss the next period:
            --  (or that we have not missed the current deadline)
            --
            C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                           uu_tp => Current_Time'Access);
            pragma Assert (C_Ret = 0);
            pragma Assert (Next_Wakeup_Time.tv_sec > Current_Time.tv_sec or else
                           (Next_Wakeup_Time.tv_sec = Current_Time.tv_sec and then
                            Next_Wakeup_Time.tv_nsec > Current_Time.tv_nsec));

            --
            --  Wait for next period:
            --
            C_Ret := time_h.clock_nanosleep (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                             uu_flags => time_h.TIMER_ABSTIME,
                                             uu_req => Next_Wakeup_Time'Access,
                                             uu_rem => Remaining_Sleep_Time'Access);
            pragma Assert (C_Ret = 0);

            --
            --  Check that we did not wake up too early:
            --
            C_Ret := time_h.clock_gettime (uu_clock_id => time_h.CLOCK_MONOTONIC,
                                           uu_tp => Current_Time'Access);
            pragma Assert (C_Ret = 0);
            pragma Assert (Current_Time.tv_sec > Next_Wakeup_Time.tv_sec  or else
                           (Current_Time.tv_sec = Next_Wakeup_Time.tv_sec and then
                            Current_Time.tv_nsec >= Next_Wakeup_Time.tv_nsec));
         end loop;

         pragma warnings (off, "unreachable code");
         return System.Null_Address;
         pragma warnings (on, "unreachable code");
      end Service3_Thread_Func;

      C_Ret : C.int;
      Rt_Max_Prio : constant C.int := sched_h.sched_get_priority_max(sched_h.SCHED_FIFO);
      Thread_Attr : aliased pthread_h.pthread_attr_t;
      Thread_Handle : aliased pthread_h.pthread_t;
      SysLog_Msg_Prefix : constant C.char_array := "[COURSE:1][ASSIGNMENT:4]" & C.nul;
      Cpu_Id : constant C.int := sched_h.sched_getcpu;
   begin
      C_Ret := stdlib_h.c_system ("logger [COURSE:1][ASSIGNMENT:4]: `uname -a`" & C.nul);
      pragma Assert (C_Ret = 0);

      syslog_h.openlog (SysLog_Msg_Prefix, syslog_h.LOG_CONS + syslog_h.LOG_NDELAY, syslog_h.LOG_LOCAL1);

      --
      --  Set SCHED_FIFO scheduling poiciy for main thread and set is priority to Rt_Max_Prio,
      --  so that it can create all real-time child threads, without being preempted:
      --
      Set_Main_Thread_Real_Time_Prio (Rt_Max_Prio);

      --
      --  Create child threads with priorities <= Rt_Max_Prio - 1:
      --

      Set_Real_Time_Thread_Attr (Thread_Attr, Rt_Max_Prio - 1, Cpu_Id);
      C_Ret := pthread_h.pthread_create (Thread_Handle'Access,
                                         uu_attr => Thread_Attr'Access,
                                         uu_start_routine => Service1_Thread_Func'Access,
                                         uu_arg => System.Null_Address);
      pragma Assert (C_Ret = 0);

      Set_Real_Time_Thread_Attr (Thread_Attr, Rt_Max_Prio - 2, Cpu_Id);
      C_Ret := pthread_h.pthread_create (Thread_Handle'Access,
                                         uu_attr => Thread_Attr'Access,
                                         uu_start_routine => Service2_Thread_Func'Access,
                                         uu_arg => System.Null_Address);
      pragma Assert (C_Ret = 0);

      Set_Real_Time_Thread_Attr (Thread_Attr, Rt_Max_Prio - 3, Cpu_Id);
      C_Ret := pthread_h.pthread_create (Thread_Handle'Access,
                                         uu_attr => Thread_Attr'Access,
                                         uu_start_routine => Service3_Thread_Func'Access,
                                         uu_arg => System.Null_Address);
      pragma Assert (C_Ret = 0);

      --
      --  None of the child threads are supposed to terminate, so just wait
      --  on the last child thread created, to prevent the process to terminate
      --
      C_Ret := pthread_h.pthread_join (Thread_Handle, System.Null_Address);
      pragma Assert (C_Ret = 0);

      syslog_h.closelog;
   end Run_Assignment;

end Assignment;
