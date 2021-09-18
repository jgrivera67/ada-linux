pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;

package arm_linux_gnueabihf_bits_sched_h is


  -- Definitions of constants and data structure for POSIX 1003.1b-1993
  --   scheduling interface.
  --   Copyright (C) 1996-2018 Free Software Foundation, Inc.
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

  -- Scheduling algorithms.
  -- Cloning flags.
  -- Clone current process.
   function clone
     (uu_fn : access function (arg1 : System.Address) return int;
      uu_child_stack : System.Address;
      uu_flags : int;
      uu_arg : System.Address  -- , ...
      ) return int;  -- /usr/include/arm-linux-gnueabihf/bits/sched.h:80
   pragma Import (C, clone, "clone");

  -- Unshare the specified resources.
   function unshare (uu_flags : int) return int;  -- /usr/include/arm-linux-gnueabihf/bits/sched.h:84
   pragma Import (C, unshare, "unshare");

  -- Get index of currently used CPU.
   function sched_getcpu return int;  -- /usr/include/arm-linux-gnueabihf/bits/sched.h:87
   pragma Import (C, sched_getcpu, "sched_getcpu");

  -- Switch process to namespace of type NSTYPE indicated by FD.
   function setns (uu_fd : int; uu_nstype : int) return int;  -- /usr/include/arm-linux-gnueabihf/bits/sched.h:90
   pragma Import (C, setns, "setns");

end arm_linux_gnueabihf_bits_sched_h;
