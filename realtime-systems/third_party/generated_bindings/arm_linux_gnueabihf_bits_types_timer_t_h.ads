pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;

package arm_linux_gnueabihf_bits_types_timer_t_h is

  -- Timer ID returned by `timer_create'.   
   subtype timer_t is arm_linux_gnueabihf_bits_types_h.uu_timer_t;  -- /usr/include/arm-linux-gnueabihf/bits/types/timer_t.h:7

end arm_linux_gnueabihf_bits_types_timer_t_h;
