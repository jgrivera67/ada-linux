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
   use type System.Address;

   procedure Run_Assignment is
      function Thread_Func (arg : System.Address) return System.Address
        with Convention => C;

      function Thread_Func (arg : System.Address) return System.Address
      is
      begin
         pragma Assert (arg = System.Null_Address);
         syslog_h.syslog (syslog_h.LOG_INFO, "Hello World from Thread!" & c.nul);
         return System.Null_Address;
      end Thread_Func;

      Thread_Handle : aliased pthread_h.pthread_t;
      C_Ret : C.int;
      SysLog_Msg_Prefix : constant C.char_array := "[COURSE:1][ASSIGNMENT:1]" & C.nul;
   begin
      C_Ret := stdlib_h.c_system ("logger [COURSE:1][ASSIGNMENT:1]: `uname -a`" & C.nul);
      pragma Assert (C_Ret = 0);

      syslog_h.openlog (SysLog_Msg_Prefix, syslog_h.LOG_CONS + syslog_h.LOG_NDELAY, syslog_h.LOG_LOCAL1);

      syslog_h.syslog (syslog_h.LOG_INFO, "Hello World from Main!" & C.nul);

      C_Ret := pthread_h.pthread_create (Thread_Handle'Access,
                                         uu_attr => null,
                                         uu_start_routine => Thread_Func'Access,
                                         uu_arg => System.Null_Address);
      pragma Assert (C_Ret = 0);

      C_Ret := pthread_h.pthread_join (Thread_Handle, System.Null_Address);
      pragma Assert (C_Ret = 0);

      syslog_h.closelog;
   end Run_Assignment;

end Assignment;
