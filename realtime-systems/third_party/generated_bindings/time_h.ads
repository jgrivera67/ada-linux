pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_clock_t_h;
with arm_linux_gnueabihf_bits_types_time_t_h;
with Interfaces.C.Strings;
limited with timespec_h;
with arm_linux_gnueabihf_bits_types_clockid_t_h;
with sched_h;
with System;
with arm_linux_gnueabihf_bits_types_timer_t_h;
limited with itimerspec_h;

package time_h is

   TIME_UTC : constant := 1;  --  /usr/include/time.h:65

   CLOCK_REALTIME : constant := 0;
   CLOCK_MONOTONIC : constant := 1;
   CLOCK_MONOTONIC_RAW : constant := 4;

   TIMER_ABSTIME : constant := 1; --  Flag to indicate time is absolute.

   type sigevent is null record;   -- incomplete struct

   function clock return arm_linux_gnueabihf_bits_types_clock_t_h.clock_t;  -- /usr/include/time.h:72
   pragma Import (C, clock, "clock");

   function time (uu_timer : access arm_linux_gnueabihf_bits_types_time_t_h.time_t) return arm_linux_gnueabihf_bits_types_time_t_h.time_t;  -- /usr/include/time.h:75
   pragma Import (C, time, "time");

   function difftime (uu_time1 : arm_linux_gnueabihf_bits_types_time_t_h.time_t; uu_time0 : arm_linux_gnueabihf_bits_types_time_t_h.time_t) return double;  -- /usr/include/time.h:78
   pragma Import (C, difftime, "difftime");

   function ctime (arg1 : access arm_linux_gnueabihf_bits_types_time_t_h.time_t) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:142
   pragma Import (C, ctime, "ctime");

   function ctime_r (arg1 : access arm_linux_gnueabihf_bits_types_time_t_h.time_t; arg2 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:153
   pragma Import (C, ctime_r, "ctime_r");

   tzname : array (0 .. 1) of Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:166
   pragma Import (C, tzname, "tzname");

   procedure tzset;  -- /usr/include/time.h:170
   pragma Import (C, tzset, "tzset");

   daylight : aliased int;  -- /usr/include/time.h:174
   pragma Import (C, daylight, "daylight");

   timezone : aliased long;  -- /usr/include/time.h:175
   pragma Import (C, timezone, "timezone");

   function stime (uu_when : access arm_linux_gnueabihf_bits_types_time_t_h.time_t) return int;  -- /usr/include/time.h:181
   pragma Import (C, stime, "stime");

   function dysize (uu_year : int) return int;  -- /usr/include/time.h:202
   pragma Import (C, dysize, "dysize");

   function nanosleep (uu_requested_time : access constant timespec_h.timespec; uu_remaining : access timespec_h.timespec) return int;  -- /usr/include/time.h:211
   pragma Import (C, nanosleep, "nanosleep");

   function clock_getres (uu_clock_id : arm_linux_gnueabihf_bits_types_clockid_t_h.clockid_t; uu_res : access timespec_h.timespec) return int;  -- /usr/include/time.h:216
   pragma Import (C, clock_getres, "clock_getres");

   function clock_gettime (uu_clock_id : arm_linux_gnueabihf_bits_types_clockid_t_h.clockid_t; uu_tp : access timespec_h.timespec) return int;  -- /usr/include/time.h:219
   pragma Import (C, clock_gettime, "clock_gettime");

   function clock_settime (uu_clock_id : arm_linux_gnueabihf_bits_types_clockid_t_h.clockid_t; uu_tp : access constant timespec_h.timespec) return int;  -- /usr/include/time.h:222
   pragma Import (C, clock_settime, "clock_settime");

   function clock_nanosleep
     (uu_clock_id : arm_linux_gnueabihf_bits_types_clockid_t_h.clockid_t;
      uu_flags : int;
      uu_req : access constant timespec_h.timespec;
      uu_rem : access timespec_h.timespec) return int;  -- /usr/include/time.h:230
   pragma Import (C, clock_nanosleep, "clock_nanosleep");

   function clock_getcpuclockid (uu_pid : sched_h.pid_t; uu_clock_id : access arm_linux_gnueabihf_bits_types_clockid_t_h.clockid_t) return int;  -- /usr/include/time.h:235
   pragma Import (C, clock_getcpuclockid, "clock_getcpuclockid");

   function timer_create
     (uu_clock_id : arm_linux_gnueabihf_bits_types_clockid_t_h.clockid_t;
      uu_evp : access sigevent;
      uu_timerid : System.Address) return int;  -- /usr/include/time.h:240
   pragma Import (C, timer_create, "timer_create");

   function timer_delete (uu_timerid : arm_linux_gnueabihf_bits_types_timer_t_h.timer_t) return int;  -- /usr/include/time.h:245
   pragma Import (C, timer_delete, "timer_delete");

   function timer_settime
     (uu_timerid : arm_linux_gnueabihf_bits_types_timer_t_h.timer_t;
      uu_flags : int;
      uu_value : access constant itimerspec_h.itimerspec;
      uu_ovalue : access itimerspec_h.itimerspec) return int;  -- /usr/include/time.h:248
   pragma Import (C, timer_settime, "timer_settime");

   function timer_gettime (uu_timerid : arm_linux_gnueabihf_bits_types_timer_t_h.timer_t; uu_value : access itimerspec_h.itimerspec) return int;  -- /usr/include/time.h:253
   pragma Import (C, timer_gettime, "timer_gettime");

   function timer_getoverrun (uu_timerid : arm_linux_gnueabihf_bits_types_timer_t_h.timer_t) return int;  -- /usr/include/time.h:257
   pragma Import (C, timer_getoverrun, "timer_getoverrun");

   function timespec_get (uu_ts : access timespec_h.timespec; uu_base : int) return int;  -- /usr/include/time.h:263
   pragma Import (C, timespec_get, "timespec_get");

end time_h;
