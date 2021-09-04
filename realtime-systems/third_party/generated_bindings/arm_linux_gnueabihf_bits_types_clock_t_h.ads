pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;

package arm_linux_gnueabihf_bits_types_clock_t_h is

  -- Returned by `clock'.   
   subtype clock_t is arm_linux_gnueabihf_bits_types_h.uu_clock_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/clock_t.h:7

end arm_linux_gnueabihf_bits_types_clock_t_h;
