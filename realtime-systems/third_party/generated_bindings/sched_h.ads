pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;
limited with arm_linux_gnueabihf_bits_types_struct_sched_param_h;
limited with arm_linux_gnueabihf_bits_types_struct_timespec_h;

package sched_h is

   --  unsupported macro: sched_priority sched_priority
   subtype pid_t is arm_linux_gnueabihf_bits_types_h.uu_pid_t;  -- /usr/include/sched.h:38

   function sched_setparam (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_param : access constant sched_param) return int;  -- /usr/include/sched.h:54
   pragma Import (C, sched_setparam, "sched_setparam");

   function sched_getparam (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_param : access arm_linux_gnueabihf_bits_types_struct_sched_param_h.sched_param) return int;  -- /usr/include/sched.h:58
   pragma Import (C, sched_getparam, "sched_getparam");

   function sched_setscheduler
     (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t;
      uu_policy : int;
      uu_param : access constant sched_param) return int;  -- /usr/include/sched.h:61
   pragma Import (C, sched_setscheduler, "sched_setscheduler");

   function sched_getscheduler (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t) return int;  -- /usr/include/sched.h:65
   pragma Import (C, sched_getscheduler, "sched_getscheduler");

   function sched_yield return int;  -- /usr/include/sched.h:68
   pragma Import (C, sched_yield, "sched_yield");

   function sched_get_priority_max (uu_algorithm : int) return int;  -- /usr/include/sched.h:71
   pragma Import (C, sched_get_priority_max, "sched_get_priority_max");

   function sched_get_priority_min (uu_algorithm : int) return int;  -- /usr/include/sched.h:74
   pragma Import (C, sched_get_priority_min, "sched_get_priority_min");

   function sched_rr_get_interval (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_t : access arm_linux_gnueabihf_bits_types_struct_timespec_h.timespec) return int;  -- /usr/include/sched.h:77
   pragma Import (C, sched_rr_get_interval, "sched_rr_get_interval");

end sched_h;
