pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_struct_timespec_h;

package arm_linux_gnueabihf_bits_types_struct_itimerspec_h is

   type itimerspec is record
      it_interval : aliased arm_linux_gnueabihf_bits_types_struct_timespec_h.timespec;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_itimerspec.h:10
      it_value : aliased arm_linux_gnueabihf_bits_types_struct_timespec_h.timespec;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_itimerspec.h:11
   end record;
   pragma Convention (C_Pass_By_Copy, itimerspec);  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_itimerspec.h:8

end arm_linux_gnueabihf_bits_types_struct_itimerspec_h;
