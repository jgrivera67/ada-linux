pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with arm_linux_gnueabihf_bits_types_h;
with Interfaces.C.Strings;
with timespec_h;

package signal_h is

   SIGALRM	: constant := 14;	--  Alarm clock.

   --  arg-macro: function sigmask (sig)
   --    return (int)(2 ** ((sig) - 1));
   --  unsupported macro: NSIG _NSIG
   --  unsupported macro: SIGRTMIN (__libc_current_sigrtmin ())
   --  unsupported macro: SIGRTMAX (__libc_current_sigrtmax ())
  -- Copyright (C) 1991-2018 Free Software Foundation, Inc.
  --   This file is part of the GNU C Library.
  --   The GNU C Library is free software; you can redistribute it and/or
  --   modify it under the terms of the GNU Lesser General Public
  --   License as published by the Free Software Foundation; either
  --   version 2.1 of the License, or (at your option) any later version.
  --   The GNU C Library is distributed in the hope that it will be useful,
  --   but WITHOUT ANY WARRANTY; without even the implied warranty of
  --   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  --   Lesser General Public License for more details.
  --   You should have received a copy of the GNU Lesser General Public
  --   License along with the GNU C Library; if not, see
  --   <http://www.gnu.org/licenses/>.

  -- *	ISO C99 Standard: 7.14 Signal handling <signal.h>
  --

   subtype pid_t is arm_linux_gnueabihf_bits_types_h.uu_pid_t;  -- /usr/include/signal.h:40

   subtype uid_t is arm_linux_gnueabihf_bits_types_h.uu_uid_t;  -- /usr/include/signal.h:46

  -- We need `struct timespec' later on.
  -- Type of a signal handler.
   type uu_sighandler_t is access procedure (arg1 : int);
   pragma Convention (C, uu_sighandler_t);  -- /usr/include/signal.h:72

  -- The X/Open definition of `signal' specifies the SVID semantic.  Use
  --   the additional function `sysv_signal' when X/Open compatibility is
  --   requested.

   --  skipped func __sysv_signal

   function sysv_signal (uu_sig : int; uu_handler : uu_sighandler_t) return uu_sighandler_t;  -- /usr/include/signal.h:80
   pragma Import (C, sysv_signal, "sysv_signal");

  -- Set the handler for the signal SIG to HANDLER, returning the old
  --   handler, or SIG_ERR on error.
  --   By default `signal' has the BSD semantic.

   function signal (uu_sig : int; uu_handler : uu_sighandler_t) return uu_sighandler_t;  -- /usr/include/signal.h:88
   pragma Import (C, signal, "signal");

  -- Make sure the used `signal' implementation is the SVID version.
  -- The X/Open definition of `signal' conflicts with the BSD version.
  --   So they defined another function `bsd_signal'.

  -- Send signal SIG to process number PID.  If PID is zero,
  --   send SIG to all processes in the current process's process group.
  --   If PID is < -1, send SIG to all processes in process group - PID.

   function kill (uu_pid : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_sig : int) return int;  -- /usr/include/signal.h:112
   pragma Import (C, kill, "kill");

  -- Send SIG to all processes in process group PGRP.
  --   If PGRP is zero, send SIG to all processes in
  --   the current process's process group.

   function killpg (uu_pgrp : arm_linux_gnueabihf_bits_types_h.uu_pid_t; uu_sig : int) return int;  -- /usr/include/signal.h:119
   pragma Import (C, killpg, "killpg");

  -- Raise signal SIG, i.e., send SIG to yourself.
   function c_raise (uu_sig : int) return int;  -- /usr/include/signal.h:123
   pragma Import (C, c_raise, "raise");

  -- SVID names for the same things.
   function ssignal (uu_sig : int; uu_handler : uu_sighandler_t) return uu_sighandler_t;  -- /usr/include/signal.h:127
   pragma Import (C, ssignal, "ssignal");

   function gsignal (uu_sig : int) return int;  -- /usr/include/signal.h:129
   pragma Import (C, gsignal, "gsignal");

  -- Print a message describing the meaning of the given signal number.
   procedure psignal (uu_sig : int; uu_s : Interfaces.C.Strings.chars_ptr);  -- /usr/include/signal.h:134
   pragma Import (C, psignal, "psignal");

  -- The `sigpause' function in X/Open defines the argument as the
  --   signal number.  This requires redirecting to another function
  --   because the default version in glibc uses an old BSD interface.
  --   This function is a cancellation point and therefore not marked with
  --   __THROW.

   function sigpause (uu_sig : int) return int;  -- /usr/include/signal.h:151
   pragma Import (C, sigpause, "__xpg_sigpause");

  -- Remove a signal from the signal mask and suspend the process.
  -- None of the following functions should be used anymore.  They are here
  --   only for compatibility.  A single word (`int') is not guaranteed to be
  --   enough to hold a complete signal mask and therefore these functions
  --   simply do not work in many situations.  Use `sigprocmask' instead.

  -- Compute mask for signal SIG.
  -- Block signals in MASK, returning the old mask.
   function sigblock (uu_mask : int) return int;  -- /usr/include/signal.h:170
   pragma Import (C, sigblock, "sigblock");

  -- Set the mask of blocked signals to MASK, returning the old mask.
   function sigsetmask (uu_mask : int) return int;  -- /usr/include/signal.h:173
   pragma Import (C, sigsetmask, "sigsetmask");

  -- Return currently selected signal mask.
   function siggetmask return int;  -- /usr/include/signal.h:176
   pragma Import (C, siggetmask, "siggetmask");

   subtype sighandler_t is uu_sighandler_t;  -- /usr/include/signal.h:185

  -- 4.4 BSD uses the name `sig_t' for this.
   subtype sig_t is uu_sighandler_t;  -- /usr/include/signal.h:190

  -- Clear all signals from SET.
   function sigemptyset (uu_set : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:196
   pragma Import (C, sigemptyset, "sigemptyset");

  -- Set all signals in SET.
   function sigfillset (uu_set : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:199
   pragma Import (C, sigfillset, "sigfillset");

  -- Add SIGNO to SET.
   function sigaddset (uu_set : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t; uu_signo : int) return int;  -- /usr/include/signal.h:202
   pragma Import (C, sigaddset, "sigaddset");

  -- Remove SIGNO from SET.
   function sigdelset (uu_set : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t; uu_signo : int) return int;  -- /usr/include/signal.h:205
   pragma Import (C, sigdelset, "sigdelset");

  -- Return 1 if SIGNO is in SET, 0 if not.
   function sigismember (uu_set : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t; uu_signo : int) return int;  -- /usr/include/signal.h:208
   pragma Import (C, sigismember, "sigismember");

  -- Return non-empty value is SET is not empty.
   function sigisemptyset (uu_set : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:213
   pragma Import (C, sigisemptyset, "sigisemptyset");

  -- Build new signal set by combining the two inputs set using logical AND.
   function sigandset
     (uu_set : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t;
      uu_left : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t;
      uu_right : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:216
   pragma Import (C, sigandset, "sigandset");

  -- Build new signal set by combining the two inputs set using logical OR.
   function sigorset
     (uu_set : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t;
      uu_left : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t;
      uu_right : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:220
   pragma Import (C, sigorset, "sigorset");

  -- Get the system-specific definitions of `struct sigaction'
  --   and the `SA_*' and `SIG_*'. constants.

  -- Get and/or change the set of blocked signals.
   function sigprocmask
     (uu_how : int;
      uu_set : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t;
      uu_oset : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:229
   pragma Import (C, sigprocmask, "sigprocmask");

  -- Change the set of blocked signals to SET,
  --   wait until a signal arrives, and restore the set of blocked signals.
  --   This function is a cancellation point and therefore not marked with
  --   __THROW.

   function sigsuspend (uu_set : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:237
   pragma Import (C, sigsuspend, "sigsuspend");

  -- Put in SET all signals that are blocked and waiting to be delivered.
   function sigpending (uu_set : access arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t) return int;  -- /usr/include/signal.h:244
   pragma Import (C, sigpending, "sigpending");

  -- Select any of pending signals from SET or wait for any to arrive.
  --   This function is a cancellation point and therefore not marked with
  --   __THROW.

   function sigwait (uu_set : access constant arm_linux_gnueabihf_bits_types_sigset_t_h.sigset_t; uu_sig : access int) return int;  -- /usr/include/signal.h:252
   pragma Import (C, sigwait, "sigwait");

  -- Select any of pending signals from SET and place information in INFO.
  --   This function is a cancellation point and therefore not marked with
  --   __THROW.

  -- Send signal SIG to the process PID.  Associate data in VAL with the
  --   signal.

  -- Names of the signals.  This variable exists only for compatibility.
  --   Use `strsignal' instead (see <string.h>).

   sys_siglist : array (0 .. 64) of Interfaces.C.Strings.chars_ptr;  -- /usr/include/signal.h:287
   pragma Import (C, sys_siglist, "sys_siglist");

  -- This will define `ucontext_t' and `mcontext_t'.
  -- If INTERRUPT is nonzero, make signal SIG interrupt system calls
  --   (causing them to fail with EINTR); if INTERRUPT is zero, make system
  --   calls be restarted after signal SIG.

   function siginterrupt (uu_sig : int; uu_interrupt : int) return int;  -- /usr/include/signal.h:314
   pragma Import (C, siginterrupt, "siginterrupt");

  -- Alternate signal handler stack interface.
  --   This interface should always be preferred over `sigstack'.

  -- Simplified interface for signal management.
  -- Add SIG to the calling process' signal mask.
   function sighold (uu_sig : int) return int;  -- /usr/include/signal.h:343
   pragma Import (C, sighold, "sighold");

  -- Remove SIG from the calling process' signal mask.
   function sigrelse (uu_sig : int) return int;  -- /usr/include/signal.h:346
   pragma Import (C, sigrelse, "sigrelse");

  -- Set the disposition of SIG to SIG_IGN.
   function sigignore (uu_sig : int) return int;  -- /usr/include/signal.h:349
   pragma Import (C, sigignore, "sigignore");

  -- Set the disposition of SIG.
   function sigset (uu_sig : int; uu_disp : uu_sighandler_t) return uu_sighandler_t;  -- /usr/include/signal.h:352
   pragma Import (C, sigset, "sigset");

  -- Some of the functions for handling signals in threaded programs must
  --   be defined here.

  -- The following functions are used internally in the C library and in
  --   other code which need deep insights.

  -- Return number of available real-time signal with highest priority.
   --  skipped func __libc_current_sigrtmin

  -- Return number of available real-time signal with lowest priority.
   --  skipped func __libc_current_sigrtmax

end signal_h;
