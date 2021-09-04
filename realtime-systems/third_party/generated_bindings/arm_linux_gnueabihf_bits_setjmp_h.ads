pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package arm_linux_gnueabihf_bits_setjmp_h is

   type uu_jmp_buf is array (0 .. 63) of aliased int;  -- /usr/include/arm-linux-gnueabihf/bits/setjmp.h:33

end arm_linux_gnueabihf_bits_setjmp_h;
