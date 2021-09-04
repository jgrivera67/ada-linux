pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package arm_linux_gnueabihf_bits_cpu_set_h is

   subtype uu_cpu_mask is unsigned_long;  -- /usr/include/arm-linux-gnueabihf/bits/cpu-set.h:32

   type cpu_set_t_uu_bits_array is array (0 .. 31) of aliased uu_cpu_mask;
   type cpu_set_t is record
      uu_bits : aliased cpu_set_t_uu_bits_array;  -- /usr/include/arm-linux-gnueabihf/bits/cpu-set.h:41
   end record;
   pragma Convention (C_Pass_By_Copy, cpu_set_t);  -- /usr/include/arm-linux-gnueabihf/bits/cpu-set.h:42

   --  skipped func __sched_cpucount

   --  skipped func __sched_cpualloc

   --  skipped func __sched_cpufree

end arm_linux_gnueabihf_bits_cpu_set_h;
