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

package body Assignment is
   use Interfaces;
   use type C.int;
   use type C.char_array;
   use type C.size_t;

   Num_Threads : constant := 128;

   type Thread_Index_Type is range 0 .. Num_Threads - 1;

   type Thread_Params_Type is record
         Thread_Index : Thread_Index_Type;
   end record;

   Threads_Params : array (Thread_Index_Type) of Thread_Params_Type;

   Threads : array (Thread_Index_Type) of aliased pthread_h.pthread_t;

   --  Convert int to a C string without null terminator
   function Value_to_C_Str (Value : C.int) return C.char_array is
      C_Image_Str : constant c.char_array :=
         C.To_C (Value'Image, Append_Nul => False);
   begin
      return C_Image_Str (C_Image_Str'First + 1 .. C_Image_Str'Last);
   end Value_to_C_Str;

   procedure Run_Assignment is
      function Thread_Func (arg : System.Address) return System.Address
        with Convention => C;

      function Thread_Func (arg : System.Address) return System.Address
      is
         function Calc_Sum (End_Value : Thread_Index_Type) return C.int is
            Sum : C.int := 0;
         begin
            for I in 1 .. End_Value loop
               Sum := Sum + C.int (I);
            end loop;

            return Sum;
         end Calc_Sum;

         Thread_Params : Thread_Params_Type with Address => arg;
         C_Thread_Index_Str : constant C.char_array := Value_to_C_Str (C.int (Thread_Params.Thread_Index));
         Sum : constant C.int := Calc_Sum (Thread_Params.Thread_Index);
         C_Sum_Str : constant C.char_array := Value_to_C_Str (Sum);
      begin
         syslog_h.syslog (syslog_h.LOG_INFO,
            "Thread idx=" & C_Thread_Index_Str & ", sum[0..." & C_Thread_Index_Str & "]=" & C_Sum_Str & C.nul);

         return System.Null_Address;
      end Thread_Func;

      C_Ret : C.int;
      SysLog_Msg_Prefix : constant C.char_array := "[COURSE:1][ASSIGNMENT:2]" & C.nul;
   begin
      C_Ret := stdlib_h.c_system ("logger [COURSE:1][ASSIGNMENT:2]: `uname -a`" & C.nul);
      pragma Assert (C_Ret = 0);

      syslog_h.openlog (SysLog_Msg_Prefix, syslog_h.LOG_CONS + syslog_h.LOG_NDELAY, syslog_h.LOG_LOCAL1);

      for I in Thread_Index_Type loop
         Threads_Params (I).Thread_Index := I;
         C_Ret := pthread_h.pthread_create (Threads (I)'Access,
                                            uu_attr => null,
                                            uu_start_routine => Thread_Func'Access,
                                            uu_arg => Threads_Params (I)'Address);
         pragma Assert (C_Ret = 0);
      end loop;

      for I in Thread_Index_Type loop
         C_Ret := pthread_h.pthread_join (Threads (I), System.Null_Address);
         pragma Assert (C_Ret = 0);
      end loop;

      syslog_h.closelog;
   end Run_Assignment;

end Assignment;
