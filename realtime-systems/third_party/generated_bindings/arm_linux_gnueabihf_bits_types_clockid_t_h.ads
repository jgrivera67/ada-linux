pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;

package arm_linux_gnueabihf_bits_types_clockid_t_h is

  -- Clock ID used in clock and timer functions.   
   subtype clockid_t is arm_linux_gnueabihf_bits_types_h.uu_clockid_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/clockid_t.h:7

end arm_linux_gnueabihf_bits_types_clockid_t_h;
