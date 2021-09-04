pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;

package arm_linux_gnueabihf_bits_types_struct_timeval_h is

  -- A time value that is accurate to the nearest
  --   microsecond but also has a range of years.   

  -- Seconds.   
   type timeval is record
      tv_sec : aliased arm_linux_gnueabihf_bits_types_h.uu_time_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_timeval.h:10
      tv_usec : aliased arm_linux_gnueabihf_bits_types_h.uu_suseconds_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_timeval.h:11
   end record;
   pragma Convention (C_Pass_By_Copy, timeval);  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_timeval.h:8

  -- Microseconds.   
end arm_linux_gnueabihf_bits_types_struct_timeval_h;
