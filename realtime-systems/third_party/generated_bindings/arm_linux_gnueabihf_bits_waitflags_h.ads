pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package arm_linux_gnueabihf_bits_waitflags_h is

   WNOHANG : constant := 1;  --  /usr/include/arm-linux-gnueabihf/bits/waitflags.h:25
   WUNTRACED : constant := 2;  --  /usr/include/arm-linux-gnueabihf/bits/waitflags.h:26

   WSTOPPED : constant := 2;  --  /usr/include/arm-linux-gnueabihf/bits/waitflags.h:30
   WEXITED : constant := 4;  --  /usr/include/arm-linux-gnueabihf/bits/waitflags.h:31
   WCONTINUED : constant := 8;  --  /usr/include/arm-linux-gnueabihf/bits/waitflags.h:32
   WNOWAIT : constant := 16#01000000#;  --  /usr/include/arm-linux-gnueabihf/bits/waitflags.h:33

  -- Definitions of flag bits for `waitpid' et al.
  --   Copyright (C) 1992-2018 Free Software Foundation, Inc.
  --   This file is part of the GNU C Library.
  --   The GNU C Library is free software; you can redistribute it and/or
  --   modify it under the terms of the GNU Lesser General Public
  --   License as published by the Free Software Foundation; either
  --   version 2.1 of the License, or (at your option) any later version.
  --   The GNU C Library is distributed in the hope that it will be useful,
  --   but WITHOUT ANY WARRANTY; without even the implied warranty of
  --   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  --   Lesser General Public License for more details.
  --   You should have received a copy of the GNU Lesser General Public
  --   License along with the GNU C Library; if not, see
  --   <http://www.gnu.org/licenses/>.   

  -- Bits in the third argument to `waitpid'.   
  -- Bits in the fourth argument to `waitid'.   
  -- The following values are used by the `waitid' function.   
  -- The Linux kernel defines these bare, rather than an enum,
  --   which causes a conflict if the include order is reversed.  

  -- Wait for any child.   
  -- Wait for specified process.   
  -- Wait for members of process group.   
   type idtype_t is 
     (P_ALL,
      P_PID,
      P_PGID);
   pragma Convention (C, idtype_t);  -- /usr/include/arm-linux-gnueabihf/bits/waitflags.h:57

end arm_linux_gnueabihf_bits_waitflags_h;
