pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;
with arm_linux_gnueabihf_bits_types_u_sigval_t_h;
with System;

package arm_linux_gnueabihf_bits_types_siginfo_t_h is

   --  unsupported macro: si_pid _sifields._kill.si_pid
   --  unsupported macro: si_uid _sifields._kill.si_uid
   --  unsupported macro: si_timerid _sifields._timer.si_tid
   --  unsupported macro: si_overrun _sifields._timer.si_overrun
   --  unsupported macro: si_status _sifields._sigchld.si_status
   --  unsupported macro: si_utime _sifields._sigchld.si_utime
   --  unsupported macro: si_stime _sifields._sigchld.si_stime
   --  unsupported macro: si_value _sifields._rt.si_sigval
   --  unsupported macro: si_int _sifields._rt.si_sigval.sival_int
   --  unsupported macro: si_ptr _sifields._rt.si_sigval.sival_ptr
   --  unsupported macro: si_addr _sifields._sigfault.si_addr
   --  unsupported macro: si_addr_lsb _sifields._sigfault.si_addr_lsb
   --  unsupported macro: si_lower _sifields._sigfault._bounds._addr_bnd._lower
   --  unsupported macro: si_upper _sifields._sigfault._bounds._addr_bnd._upper
   --  unsupported macro: si_pkey _sifields._sigfault._bounds._pkey
   --  unsupported macro: si_band _sifields._sigpoll.si_band
   --  unsupported macro: si_fd _sifields._sigpoll.si_fd
   --  unsupported macro: si_call_addr _sifields._sigsys._call_addr
   --  unsupported macro: si_syscall _sifields._sigsys._syscall
   --  unsupported macro: si_arch _sifields._sigsys._arch
  -- Some fields of siginfo_t have architecture-specific variations.   
  -- Signal number.   
   type anon_4 is record
      si_pid : aliased arm_linux_gnueabihf_bits_types_h.uu_pid_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:58
      si_uid : aliased arm_linux_gnueabihf_bits_types_h.uu_uid_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:59
   end record;
   pragma Convention (C_Pass_By_Copy, anon_4);
   type anon_5 is record
      si_tid : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:65
      si_overrun : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:66
      si_sigval : aliased arm_linux_gnueabihf_bits_types_u_sigval_t_h.uu_sigval_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:67
   end record;
   pragma Convention (C_Pass_By_Copy, anon_5);
   type anon_6 is record
      si_pid : aliased arm_linux_gnueabihf_bits_types_h.uu_pid_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:73
      si_uid : aliased arm_linux_gnueabihf_bits_types_h.uu_uid_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:74
      si_sigval : aliased arm_linux_gnueabihf_bits_types_u_sigval_t_h.uu_sigval_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:75
   end record;
   pragma Convention (C_Pass_By_Copy, anon_6);
   type anon_7 is record
      si_pid : aliased arm_linux_gnueabihf_bits_types_h.uu_pid_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:81
      si_uid : aliased arm_linux_gnueabihf_bits_types_h.uu_uid_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:82
      si_status : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:83
      si_utime : aliased arm_linux_gnueabihf_bits_types_h.uu_clock_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:84
      si_stime : aliased arm_linux_gnueabihf_bits_types_h.uu_clock_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:85
   end record;
   pragma Convention (C_Pass_By_Copy, anon_7);
   type anon_10 is record
      u_lower : System.Address;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:99
      u_upper : System.Address;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:100
   end record;
   pragma Convention (C_Pass_By_Copy, anon_10);
   type anon_9 (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            u_addr_bnd : aliased anon_10;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:101
         when others =>
            u_pkey : aliased arm_linux_gnueabihf_bits_types_h.uu_uint32_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:103
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, anon_9);
   pragma Unchecked_Union (anon_9);type anon_8 is record
      si_addr : System.Address;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:91
      si_addr_lsb : aliased short;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:93
      u_bounds : aliased anon_9;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:104
   end record;
   pragma Convention (C_Pass_By_Copy, anon_8);
   type anon_11 is record
      si_band : aliased long;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:110
      si_fd : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:111
   end record;
   pragma Convention (C_Pass_By_Copy, anon_11);
   type anon_12 is record
      u_call_addr : System.Address;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:118
      u_syscall : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:119
      u_arch : aliased unsigned;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:120
   end record;
   pragma Convention (C_Pass_By_Copy, anon_12);
   type siginfo_t_u_pad_array is array (0 .. 28) of aliased int;
   type anon_3 (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            u_pad : aliased siginfo_t_u_pad_array;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:53
         when 1 =>
            u_kill : aliased anon_4;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:60
         when 2 =>
            u_timer : aliased anon_5;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:68
         when 3 =>
            u_rt : aliased anon_6;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:76
         when 4 =>
            u_sigchld : aliased anon_7;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:86
         when 5 =>
            u_sigfault : aliased anon_8;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:105
         when 6 =>
            u_sigpoll : aliased anon_11;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:112
         when others =>
            u_sigsys : aliased anon_12;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:121
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, anon_3);
   pragma Unchecked_Union (anon_3);type siginfo_t is record
      si_signo : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:38
      si_errno : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:40
      si_code : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:42
      u_sifields : aliased anon_3;  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:123
   end record;
   pragma Convention (C_Pass_By_Copy, siginfo_t);  -- /usr/include/arm-linux-gnueabihf/bits/types/siginfo_t.h:124

   --  skipped anonymous struct anon_2

  -- If non-zero, an errno value associated with
  --				   this signal, as defined in <errno.h>.   

  -- Signal code.   
  -- Explicit padding.   
  -- kill().   
  -- Sending process ID.   
  -- Real user ID of sending process.   
  -- POSIX.1b timers.   
  -- Timer ID.   
  -- Overrun count.   
  -- Signal value.   
  -- POSIX.1b signals.   
  -- Sending process ID.   
  -- Real user ID of sending process.   
  -- Signal value.   
  -- SIGCHLD.   
  -- Which child.	  
  -- Real user ID of sending process.   
  -- Exit value or signal.   
  -- SIGILL, SIGFPE, SIGSEGV, SIGBUS.   
  -- Faulting insn/memory ref.   
  -- Valid LSB of the reported address.   
  -- used when si_code=SEGV_BNDERR  
  -- used when si_code=SEGV_PKUERR  
  -- SIGPOLL.   
  -- Band event for SIGPOLL.   
  -- SIGSYS.   
  -- Calling user insn.   
  -- Triggering system call number.   
  -- AUDIT_ARCH_* of syscall.   
  -- X/Open requires some more fields with fixed names.   
end arm_linux_gnueabihf_bits_types_siginfo_t_h;
