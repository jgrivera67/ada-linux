pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package arm_linux_gnueabihf_bits_types_struct_tm_h is

   type tm is record
      tm_sec : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:9
      tm_min : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:10
      tm_hour : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:11
      tm_mday : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:12
      tm_mon : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:13
      tm_year : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:14
      tm_wday : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:15
      tm_yday : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:16
      tm_isdst : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:17
      tm_gmtoff : aliased long;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:20
      tm_zone : Interfaces.C.Strings.chars_ptr;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:21
   end record;
   pragma Convention (C_Pass_By_Copy, tm);  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_tm.h:7

end arm_linux_gnueabihf_bits_types_struct_tm_h;
