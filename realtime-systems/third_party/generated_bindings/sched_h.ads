pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;
limited with sched_param_h;
limited with timespec_h;

package sched_h is
   SCHED_OTHER : constant := 0;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:28
   SCHED_FIFO : constant := 1;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:29
   SCHED_RR : constant := 2;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:30

   SCHED_BATCH : constant := 3;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:32
   SCHED_ISO : constant := 4;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:33
   SCHED_IDLE : constant := 5;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:34
   SCHED_DEADLINE : constant := 6;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:35

   SCHED_RESET_ON_FORK : constant := 16#40000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:37

   CSIGNAL : constant := 16#000000ff#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:42
   CLONE_VM : constant := 16#00000100#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:43
   CLONE_FS : constant := 16#00000200#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:44
   CLONE_FILES : constant := 16#00000400#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:45
   CLONE_SIGHAND : constant := 16#00000800#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:46
   CLONE_PTRACE : constant := 16#00002000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:47
   CLONE_VFORK : constant := 16#00004000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:48

   CLONE_PARENT : constant := 16#00008000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:50

   CLONE_THREAD : constant := 16#00010000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:52
   CLONE_NEWNS : constant := 16#00020000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:53
   CLONE_SYSVSEM : constant := 16#00040000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:54
   CLONE_SETTLS : constant := 16#00080000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:55
   CLONE_PARENT_SETTID : constant := 16#00100000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:56

   CLONE_CHILD_CLEARTID : constant := 16#00200000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:58

   CLONE_DETACHED : constant := 16#00400000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:60
   CLONE_UNTRACED : constant := 16#00800000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:61

   CLONE_CHILD_SETTID : constant := 16#01000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:63

   CLONE_NEWCGROUP : constant := 16#02000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:65
   CLONE_NEWUTS : constant := 16#04000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:66
   CLONE_NEWIPC : constant := 16#08000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:67
   CLONE_NEWUSER : constant := 16#10000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:68
   CLONE_NEWPID : constant := 16#20000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:69
   CLONE_NEWNET : constant := 16#40000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:70
   CLONE_IO : constant := 16#80000000#;  --  /usr/include/arm-linux-gnueabihf/bits/sched.h:71

   --  unsupported macro: sched_priority sched_priority
   subtype pid_t is arm_linux_gnueabihf_bits_types_h.uu_pid_t;  -- /usr/include/sched.h:38

   function sched_setparam (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_param : access constant sched_param_h.sched_param) return int;  -- /usr/include/sched.h:54
   pragma Import (C, sched_setparam, "sched_setparam");

   function sched_getparam (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_param : access sched_param_h.sched_param) return int;  -- /usr/include/sched.h:58
   pragma Import (C, sched_getparam, "sched_getparam");

   function sched_setscheduler
     (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t;
      uu_policy : int;
      uu_param : access constant sched_param_h.sched_param) return int;  -- /usr/include/sched.h:61
   pragma Import (C, sched_setscheduler, "sched_setscheduler");

   function sched_getscheduler (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t) return int;  -- /usr/include/sched.h:65
   pragma Import (C, sched_getscheduler, "sched_getscheduler");

   function sched_yield return int;  -- /usr/include/sched.h:68
   pragma Import (C, sched_yield, "sched_yield");

   function sched_get_priority_max (uu_algorithm : int) return int;  -- /usr/include/sched.h:71
   pragma Import (C, sched_get_priority_max, "sched_get_priority_max");

   function sched_get_priority_min (uu_algorithm : int) return int;  -- /usr/include/sched.h:74
   pragma Import (C, sched_get_priority_min, "sched_get_priority_min");

   function sched_rr_get_interval (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_t : access timespec_h.timespec) return int;  -- /usr/include/sched.h:77
   pragma Import (C, sched_rr_get_interval, "sched_rr_get_interval");

   -- Get index of currently used CPU.
   function sched_getcpu return int;  -- /usr/include/arm-linux-gnueabihf/bits/sched.h:87
   pragma Import (C, sched_getcpu, "sched_getcpu");

end sched_h;
