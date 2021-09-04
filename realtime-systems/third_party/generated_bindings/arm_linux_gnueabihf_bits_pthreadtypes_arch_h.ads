pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package arm_linux_gnueabihf_bits_pthreadtypes_arch_h is

  -- Copyright (C) 2002-2018 Free Software Foundation, Inc.
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
  --   License along with the GNU C Library.  If not, see
  --   <http://www.gnu.org/licenses/>.   

  -- Data structure for mutex handling.  
   type uu_pthread_rwlock_arch_t is record
      uu_readers : aliased unsigned;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:45
      uu_writers : aliased unsigned;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:46
      uu_wrphase_futex : aliased unsigned;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:47
      uu_writers_futex : aliased unsigned;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:48
      uu_pad3 : aliased unsigned;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:49
      uu_pad4 : aliased unsigned;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:50
      uu_flags : aliased unsigned_char;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:61
      uu_shared : aliased unsigned_char;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:62
      uu_pad1 : aliased unsigned_char;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:63
      uu_pad2 : aliased unsigned_char;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:64
      uu_cur_writer : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:66
   end record;
   pragma Convention (C_Pass_By_Copy, uu_pthread_rwlock_arch_t);  -- /usr/include/arm-linux-gnueabihf/bits/pthreadtypes-arch.h:43

  -- FLAGS must stay at this position in the structure to maintain
  --     binary compatibility.   

  -- FLAGS must stay at this position in the structure to maintain
  --     binary compatibility.   

end arm_linux_gnueabihf_bits_pthreadtypes_arch_h;
