pragma Ada_2005;
pragma Style_Checks (Off);

with timespec_h;

package itimerspec_h is

   type itimerspec is record
      it_interval : aliased timespec_h.timespec;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_itimerspec.h:10
      it_value : aliased timespec_h.timespec;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_itimerspec.h:11
   end record;
   pragma Convention (C_Pass_By_Copy, itimerspec);  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_itimerspec.h:8

end itimerspec_h;
