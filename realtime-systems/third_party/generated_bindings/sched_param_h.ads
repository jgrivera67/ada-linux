pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package sched_param_h is

   type sched_param is record
      sched_priority : aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_sched_param.h:25
   end record;
   pragma Convention (C_Pass_By_Copy, sched_param);  -- /usr/include/arm-linux-gnueabihf/bits/types/struct_sched_param.h:23

end sched_param_h;
