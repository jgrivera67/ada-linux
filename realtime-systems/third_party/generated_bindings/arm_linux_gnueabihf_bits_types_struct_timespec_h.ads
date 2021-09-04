pragma Ada_2005;
pragma Style_Checks (Off);

with arm_linux_gnueabihf_bits_types_h;

package arm_linux_gnueabihf_bits_types_struct_timespec_h is

  -- NB: Include guard matches what <linux/time.h> uses.
  -- POSIX.1b structure for a time value.  This is like a `struct timeval' but
  --   has nanoseconds instead of microseconds.

  -- Seconds.
   type timespec is record
      tv_sec : aliased arm_linux_gnueabihf_bits_types_h.uu_time_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_timespec.h:11
      tv_nsec : aliased arm_linux_gnueabihf_bits_types_h.uu_syscall_slong_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_timespec.h:12
   end record;
   pragma Convention (C_Pass_By_Copy, timespec);  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_timespec.h:9

  -- Nanoseconds.
end arm_linux_gnueabihf_bits_types_struct_timespec_h;
