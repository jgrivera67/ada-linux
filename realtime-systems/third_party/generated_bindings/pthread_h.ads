pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with arm_linux_gnueabihf_bits_pthreadtypes_h;
with stddef_h;
with arm_linux_gnueabihf_bits_types_struct_sched_param_h; use arm_linux_gnueabihf_bits_types_struct_sched_param_h;
with arm_linux_gnueabihf_bits_types_struct_timespec_h; use arm_linux_gnueabihf_bits_types_struct_timespec_h;
with arm_linux_gnueabihf_bits_setjmp_h;
with arm_linux_gnueabihf_bits_types_h;

package pthread_h is

   subtype pthread_t is arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t;

   --  unsupported macro: PTHREAD_CREATE_JOINABLE PTHREAD_CREATE_JOINABLE
   --  unsupported macro: PTHREAD_CREATE_DETACHED PTHREAD_CREATE_DETACHED
   --  unsupported macro: PTHREAD_MUTEX_INITIALIZER { { 0, 0, 0, 0, 0, { __PTHREAD_SPINS } } }
   --  unsupported macro: PTHREAD_RWLOCK_INITIALIZER { { 0, 0, 0, 0, 0, 0, 0, 0, __PTHREAD_RWLOCK_ELISION_EXTRA, 0, 0 } }
   --  unsupported macro: PTHREAD_INHERIT_SCHED PTHREAD_INHERIT_SCHED
   --  unsupported macro: PTHREAD_EXPLICIT_SCHED PTHREAD_EXPLICIT_SCHED
   --  unsupported macro: PTHREAD_SCOPE_SYSTEM PTHREAD_SCOPE_SYSTEM
   --  unsupported macro: PTHREAD_SCOPE_PROCESS PTHREAD_SCOPE_PROCESS
   --  unsupported macro: PTHREAD_PROCESS_PRIVATE PTHREAD_PROCESS_PRIVATE
   --  unsupported macro: PTHREAD_PROCESS_SHARED PTHREAD_PROCESS_SHARED
   --  unsupported macro: PTHREAD_COND_INITIALIZER { { {0}, {0}, {0, 0}, {0, 0}, 0, 0, {0, 0} } }
   --  unsupported macro: PTHREAD_CANCEL_ENABLE PTHREAD_CANCEL_ENABLE
   --  unsupported macro: PTHREAD_CANCEL_DISABLE PTHREAD_CANCEL_DISABLE
   --  unsupported macro: PTHREAD_CANCEL_DEFERRED PTHREAD_CANCEL_DEFERRED
   --  unsupported macro: PTHREAD_CANCEL_ASYNCHRONOUS PTHREAD_CANCEL_ASYNCHRONOUS
   --  unsupported macro: PTHREAD_CANCELED ((void *) -1)
   PTHREAD_ONCE_INIT : constant := 0;  --  /usr/include/pthread.h:218

   PTHREAD_BARRIER_SERIAL_THREAD : constant := -1;  --  /usr/include/pthread.h:225
   --  arg-macro: procedure pthread_cleanup_push (routine, arg)
   --    do { __pthread_unwind_buf_t __cancel_buf; void (*__cancel_routine) (void *) := (routine); void *__cancel_arg := (arg); int __not_first_call := __sigsetjmp ((struct __jmp_buf_tag *) (void *) __cancel_buf.__cancel_jmp_buf, 0); if (__glibc_unlikely (__not_first_call)) { __cancel_routine (__cancel_arg); __pthread_unwind_next (and__cancel_buf); } __pthread_register_cancel (and__cancel_buf); do {
   --  arg-macro: procedure pthread_cleanup_pop (execute)
   --    do { } while (0); } while (0); __pthread_unregister_cancel (and__cancel_buf); if (execute) __cancel_routine (__cancel_arg); } while (0)

   type u_pthread_cleanup_buffer;
   type u_pthread_cleanup_buffer is record
      uu_routine : access procedure (arg1 : System.Address);  -- /usr/include/pthread.h:193
      uu_arg : System.Address;  -- /usr/include/pthread.h:194
      uu_canceltype : aliased int;  -- /usr/include/pthread.h:195
      uu_prev : access u_pthread_cleanup_buffer;  -- /usr/include/pthread.h:196
   end record;
   pragma Convention (C_Pass_By_Copy, u_pthread_cleanup_buffer);  -- /usr/include/pthread.h:191

   function pthread_create
     (uu_newthread : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t;
      uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t;
      uu_start_routine : access function (arg1 : System.Address) return System.Address;
      uu_arg : System.Address) return int;  -- /usr/include/pthread.h:234
   pragma Import (C, pthread_create, "pthread_create");

   procedure pthread_exit (uu_retval : System.Address);  -- /usr/include/pthread.h:243
   pragma Import (C, pthread_exit, "pthread_exit");

   function pthread_join (uu_th : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t; uu_thread_return : System.Address) return int;  -- /usr/include/pthread.h:251
   pragma Import (C, pthread_join, "pthread_join");

   function pthread_detach (uu_th : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t) return int;  -- /usr/include/pthread.h:272
   pragma Import (C, pthread_detach, "pthread_detach");

   function pthread_self return arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t;  -- /usr/include/pthread.h:276
   pragma Import (C, pthread_self, "pthread_self");

   function pthread_equal (uu_thread1 : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t; uu_thread2 : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t) return int;  -- /usr/include/pthread.h:279
   pragma Import (C, pthread_equal, "pthread_equal");

   function pthread_attr_init (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t) return int;  -- /usr/include/pthread.h:288
   pragma Import (C, pthread_attr_init, "pthread_attr_init");

   function pthread_attr_destroy (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t) return int;  -- /usr/include/pthread.h:291
   pragma Import (C, pthread_attr_destroy, "pthread_attr_destroy");

   function pthread_attr_getdetachstate (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_detachstate : access int) return int;  -- /usr/include/pthread.h:295
   pragma Import (C, pthread_attr_getdetachstate, "pthread_attr_getdetachstate");

   function pthread_attr_setdetachstate (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_detachstate : int) return int;  -- /usr/include/pthread.h:300
   pragma Import (C, pthread_attr_setdetachstate, "pthread_attr_setdetachstate");

   function pthread_attr_getguardsize (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_guardsize : access stddef_h.size_t) return int;  -- /usr/include/pthread.h:306
   pragma Import (C, pthread_attr_getguardsize, "pthread_attr_getguardsize");

   function pthread_attr_setguardsize (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_guardsize : stddef_h.size_t) return int;  -- /usr/include/pthread.h:311
   pragma Import (C, pthread_attr_setguardsize, "pthread_attr_setguardsize");

   function pthread_attr_getschedparam (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_param : access arm_linux_gnueabihf_bits_types_struct_sched_param_h.sched_param) return int;  -- /usr/include/pthread.h:317
   pragma Import (C, pthread_attr_getschedparam, "pthread_attr_getschedparam");

   function pthread_attr_setschedparam (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_param : access constant sched_param) return int;  -- /usr/include/pthread.h:322
   pragma Import (C, pthread_attr_setschedparam, "pthread_attr_setschedparam");

   function pthread_attr_getschedpolicy (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_policy : access int) return int;  -- /usr/include/pthread.h:327
   pragma Import (C, pthread_attr_getschedpolicy, "pthread_attr_getschedpolicy");

   function pthread_attr_setschedpolicy (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_policy : int) return int;  -- /usr/include/pthread.h:332
   pragma Import (C, pthread_attr_setschedpolicy, "pthread_attr_setschedpolicy");

   function pthread_attr_getinheritsched (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_inherit : access int) return int;  -- /usr/include/pthread.h:336
   pragma Import (C, pthread_attr_getinheritsched, "pthread_attr_getinheritsched");

   function pthread_attr_setinheritsched (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_inherit : int) return int;  -- /usr/include/pthread.h:341
   pragma Import (C, pthread_attr_setinheritsched, "pthread_attr_setinheritsched");

   function pthread_attr_getscope (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_scope : access int) return int;  -- /usr/include/pthread.h:347
   pragma Import (C, pthread_attr_getscope, "pthread_attr_getscope");

   function pthread_attr_setscope (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_scope : int) return int;  -- /usr/include/pthread.h:352
   pragma Import (C, pthread_attr_setscope, "pthread_attr_setscope");

   function pthread_attr_getstackaddr (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_stackaddr : System.Address) return int;  -- /usr/include/pthread.h:356
   pragma Import (C, pthread_attr_getstackaddr, "pthread_attr_getstackaddr");

   function pthread_attr_setstackaddr (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_stackaddr : System.Address) return int;  -- /usr/include/pthread.h:364
   pragma Import (C, pthread_attr_setstackaddr, "pthread_attr_setstackaddr");

   function pthread_attr_getstacksize (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_stacksize : access stddef_h.size_t) return int;  -- /usr/include/pthread.h:369
   pragma Import (C, pthread_attr_getstacksize, "pthread_attr_getstacksize");

   function pthread_attr_setstacksize (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t; uu_stacksize : stddef_h.size_t) return int;  -- /usr/include/pthread.h:376
   pragma Import (C, pthread_attr_setstacksize, "pthread_attr_setstacksize");

   function pthread_attr_getstack
     (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t;
      uu_stackaddr : System.Address;
      uu_stacksize : access stddef_h.size_t) return int;  -- /usr/include/pthread.h:382
   pragma Import (C, pthread_attr_getstack, "pthread_attr_getstack");

   function pthread_attr_setstack
     (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_attr_t;
      uu_stackaddr : System.Address;
      uu_stacksize : stddef_h.size_t) return int;  -- /usr/include/pthread.h:390
   pragma Import (C, pthread_attr_setstack, "pthread_attr_setstack");

   function pthread_setschedparam
     (uu_target_thread : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t;
      uu_policy : int;
      uu_param : access constant sched_param) return int;  -- /usr/include/pthread.h:430
   pragma Import (C, pthread_setschedparam, "pthread_setschedparam");

   function pthread_getschedparam
     (uu_target_thread : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t;
      uu_policy : access int;
      uu_param : access arm_linux_gnueabihf_bits_types_struct_sched_param_h.sched_param) return int;  -- /usr/include/pthread.h:435
   pragma Import (C, pthread_getschedparam, "pthread_getschedparam");

   function pthread_setschedprio (uu_target_thread : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t; uu_prio : int) return int;  -- /usr/include/pthread.h:441
   pragma Import (C, pthread_setschedprio, "pthread_setschedprio");

   function pthread_once (uu_once_control : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_once_t; uu_init_routine : access procedure) return int;  -- /usr/include/pthread.h:495
   pragma Import (C, pthread_once, "pthread_once");

   function pthread_setcancelstate (uu_state : int; uu_oldstate : access int) return int;  -- /usr/include/pthread.h:507
   pragma Import (C, pthread_setcancelstate, "pthread_setcancelstate");

   function pthread_setcanceltype (uu_type : int; uu_oldtype : access int) return int;  -- /usr/include/pthread.h:511
   pragma Import (C, pthread_setcanceltype, "pthread_setcanceltype");

   function pthread_cancel (uu_th : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t) return int;  -- /usr/include/pthread.h:514
   pragma Import (C, pthread_cancel, "pthread_cancel");

   procedure pthread_testcancel;  -- /usr/include/pthread.h:519
   pragma Import (C, pthread_testcancel, "pthread_testcancel");

   type uu_pthread_unwind_buf_t_anon1386_struct is record
      uu_cancel_jmp_buf : aliased arm_linux_gnueabihf_bits_setjmp_h.uu_jmp_buf;  -- /usr/include/pthread.h:528
      uu_mask_was_saved : aliased int;  -- /usr/include/pthread.h:529
   end record;
   pragma Convention (C_Pass_By_Copy, uu_pthread_unwind_buf_t_anon1386_struct);
   type uu_pthread_unwind_buf_t_uu_cancel_jmp_buf_array is array (0 .. 0) of aliased uu_pthread_unwind_buf_t_anon1386_struct;
   type uu_pthread_unwind_buf_t_uu_pad_array is array (0 .. 3) of System.Address;
   type uu_pthread_unwind_buf_t is record
      uu_cancel_jmp_buf : aliased uu_pthread_unwind_buf_t_uu_cancel_jmp_buf_array;  -- /usr/include/pthread.h:530
      uu_pad : uu_pthread_unwind_buf_t_uu_pad_array;  -- /usr/include/pthread.h:531
   end record;
   pragma Convention (C_Pass_By_Copy, uu_pthread_unwind_buf_t);  -- /usr/include/pthread.h:532

   type uu_pthread_cleanup_frame is record
      uu_cancel_routine : access procedure (arg1 : System.Address);  -- /usr/include/pthread.h:543
      uu_cancel_arg : System.Address;  -- /usr/include/pthread.h:544
      uu_do_it : aliased int;  -- /usr/include/pthread.h:545
      uu_cancel_type : aliased int;  -- /usr/include/pthread.h:546
   end record;
   pragma Convention (C_Pass_By_Copy, uu_pthread_cleanup_frame);  -- /usr/include/pthread.h:541

   --  skipped func __pthread_register_cancel

   --  skipped func __pthread_unregister_cancel

   --  skipped func __pthread_unwind_next

   type uu_jmp_buf_tag is null record;   -- incomplete struct

   --  skipped func __sigsetjmp

   function pthread_mutex_init (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t; uu_mutexattr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t) return int;  -- /usr/include/pthread.h:750
   pragma Import (C, pthread_mutex_init, "pthread_mutex_init");

   function pthread_mutex_destroy (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t) return int;  -- /usr/include/pthread.h:755
   pragma Import (C, pthread_mutex_destroy, "pthread_mutex_destroy");

   function pthread_mutex_trylock (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t) return int;  -- /usr/include/pthread.h:759
   pragma Import (C, pthread_mutex_trylock, "pthread_mutex_trylock");

   function pthread_mutex_lock (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t) return int;  -- /usr/include/pthread.h:763
   pragma Import (C, pthread_mutex_lock, "pthread_mutex_lock");

   function pthread_mutex_timedlock (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t; uu_abstime : access constant timespec) return int;  -- /usr/include/pthread.h:768
   pragma Import (C, pthread_mutex_timedlock, "pthread_mutex_timedlock");

   function pthread_mutex_unlock (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t) return int;  -- /usr/include/pthread.h:774
   pragma Import (C, pthread_mutex_unlock, "pthread_mutex_unlock");

   function pthread_mutex_getprioceiling (uu_mutex : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t; uu_prioceiling : access int) return int;  -- /usr/include/pthread.h:779
   pragma Import (C, pthread_mutex_getprioceiling, "pthread_mutex_getprioceiling");

   function pthread_mutex_setprioceiling
     (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t;
      uu_prioceiling : int;
      uu_old_ceiling : access int) return int;  -- /usr/include/pthread.h:786
   pragma Import (C, pthread_mutex_setprioceiling, "pthread_mutex_setprioceiling");

   function pthread_mutex_consistent (uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t) return int;  -- /usr/include/pthread.h:794
   pragma Import (C, pthread_mutex_consistent, "pthread_mutex_consistent");

   function pthread_mutexattr_init (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t) return int;  -- /usr/include/pthread.h:807
   pragma Import (C, pthread_mutexattr_init, "pthread_mutexattr_init");

   function pthread_mutexattr_destroy (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t) return int;  -- /usr/include/pthread.h:811
   pragma Import (C, pthread_mutexattr_destroy, "pthread_mutexattr_destroy");

   function pthread_mutexattr_getpshared (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_pshared : access int) return int;  -- /usr/include/pthread.h:815
   pragma Import (C, pthread_mutexattr_getpshared, "pthread_mutexattr_getpshared");

   function pthread_mutexattr_setpshared (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_pshared : int) return int;  -- /usr/include/pthread.h:821
   pragma Import (C, pthread_mutexattr_setpshared, "pthread_mutexattr_setpshared");

   function pthread_mutexattr_gettype (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_kind : access int) return int;  -- /usr/include/pthread.h:827
   pragma Import (C, pthread_mutexattr_gettype, "pthread_mutexattr_gettype");

   function pthread_mutexattr_settype (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_kind : int) return int;  -- /usr/include/pthread.h:834
   pragma Import (C, pthread_mutexattr_settype, "pthread_mutexattr_settype");

   function pthread_mutexattr_getprotocol (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_protocol : access int) return int;  -- /usr/include/pthread.h:839
   pragma Import (C, pthread_mutexattr_getprotocol, "pthread_mutexattr_getprotocol");

   function pthread_mutexattr_setprotocol (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_protocol : int) return int;  -- /usr/include/pthread.h:846
   pragma Import (C, pthread_mutexattr_setprotocol, "pthread_mutexattr_setprotocol");

   function pthread_mutexattr_getprioceiling (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_prioceiling : access int) return int;  -- /usr/include/pthread.h:851
   pragma Import (C, pthread_mutexattr_getprioceiling, "pthread_mutexattr_getprioceiling");

   function pthread_mutexattr_setprioceiling (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_prioceiling : int) return int;  -- /usr/include/pthread.h:857
   pragma Import (C, pthread_mutexattr_setprioceiling, "pthread_mutexattr_setprioceiling");

   function pthread_mutexattr_getrobust (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_robustness : access int) return int;  -- /usr/include/pthread.h:863
   pragma Import (C, pthread_mutexattr_getrobust, "pthread_mutexattr_getrobust");

   function pthread_mutexattr_setrobust (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutexattr_t; uu_robustness : int) return int;  -- /usr/include/pthread.h:873
   pragma Import (C, pthread_mutexattr_setrobust, "pthread_mutexattr_setrobust");

   function pthread_rwlock_init (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t; uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlockattr_t) return int;  -- /usr/include/pthread.h:889
   pragma Import (C, pthread_rwlock_init, "pthread_rwlock_init");

   function pthread_rwlock_destroy (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t) return int;  -- /usr/include/pthread.h:894
   pragma Import (C, pthread_rwlock_destroy, "pthread_rwlock_destroy");

   function pthread_rwlock_rdlock (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t) return int;  -- /usr/include/pthread.h:898
   pragma Import (C, pthread_rwlock_rdlock, "pthread_rwlock_rdlock");

   function pthread_rwlock_tryrdlock (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t) return int;  -- /usr/include/pthread.h:902
   pragma Import (C, pthread_rwlock_tryrdlock, "pthread_rwlock_tryrdlock");

   function pthread_rwlock_timedrdlock (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t; uu_abstime : access constant timespec) return int;  -- /usr/include/pthread.h:907
   pragma Import (C, pthread_rwlock_timedrdlock, "pthread_rwlock_timedrdlock");

   function pthread_rwlock_wrlock (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t) return int;  -- /usr/include/pthread.h:913
   pragma Import (C, pthread_rwlock_wrlock, "pthread_rwlock_wrlock");

   function pthread_rwlock_trywrlock (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t) return int;  -- /usr/include/pthread.h:917
   pragma Import (C, pthread_rwlock_trywrlock, "pthread_rwlock_trywrlock");

   function pthread_rwlock_timedwrlock (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t; uu_abstime : access constant timespec) return int;  -- /usr/include/pthread.h:922
   pragma Import (C, pthread_rwlock_timedwrlock, "pthread_rwlock_timedwrlock");

   function pthread_rwlock_unlock (uu_rwlock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlock_t) return int;  -- /usr/include/pthread.h:928
   pragma Import (C, pthread_rwlock_unlock, "pthread_rwlock_unlock");

   function pthread_rwlockattr_init (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlockattr_t) return int;  -- /usr/include/pthread.h:935
   pragma Import (C, pthread_rwlockattr_init, "pthread_rwlockattr_init");

   function pthread_rwlockattr_destroy (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlockattr_t) return int;  -- /usr/include/pthread.h:939
   pragma Import (C, pthread_rwlockattr_destroy, "pthread_rwlockattr_destroy");

   function pthread_rwlockattr_getpshared (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlockattr_t; uu_pshared : access int) return int;  -- /usr/include/pthread.h:943
   pragma Import (C, pthread_rwlockattr_getpshared, "pthread_rwlockattr_getpshared");

   function pthread_rwlockattr_setpshared (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlockattr_t; uu_pshared : int) return int;  -- /usr/include/pthread.h:949
   pragma Import (C, pthread_rwlockattr_setpshared, "pthread_rwlockattr_setpshared");

   function pthread_rwlockattr_getkind_np (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlockattr_t; uu_pref : access int) return int;  -- /usr/include/pthread.h:954
   pragma Import (C, pthread_rwlockattr_getkind_np, "pthread_rwlockattr_getkind_np");

   function pthread_rwlockattr_setkind_np (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_rwlockattr_t; uu_pref : int) return int;  -- /usr/include/pthread.h:960
   pragma Import (C, pthread_rwlockattr_setkind_np, "pthread_rwlockattr_setkind_np");

   function pthread_cond_init (uu_cond : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_cond_t; uu_cond_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_condattr_t) return int;  -- /usr/include/pthread.h:969
   pragma Import (C, pthread_cond_init, "pthread_cond_init");

   function pthread_cond_destroy (uu_cond : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_cond_t) return int;  -- /usr/include/pthread.h:974
   pragma Import (C, pthread_cond_destroy, "pthread_cond_destroy");

   function pthread_cond_signal (uu_cond : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_cond_t) return int;  -- /usr/include/pthread.h:978
   pragma Import (C, pthread_cond_signal, "pthread_cond_signal");

   function pthread_cond_broadcast (uu_cond : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_cond_t) return int;  -- /usr/include/pthread.h:982
   pragma Import (C, pthread_cond_broadcast, "pthread_cond_broadcast");

   function pthread_cond_wait (uu_cond : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_cond_t; uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t) return int;  -- /usr/include/pthread.h:990
   pragma Import (C, pthread_cond_wait, "pthread_cond_wait");

   function pthread_cond_timedwait
     (uu_cond : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_cond_t;
      uu_mutex : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_mutex_t;
      uu_abstime : access constant timespec) return int;  -- /usr/include/pthread.h:1001
   pragma Import (C, pthread_cond_timedwait, "pthread_cond_timedwait");

   function pthread_condattr_init (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_condattr_t) return int;  -- /usr/include/pthread.h:1009
   pragma Import (C, pthread_condattr_init, "pthread_condattr_init");

   function pthread_condattr_destroy (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_condattr_t) return int;  -- /usr/include/pthread.h:1013
   pragma Import (C, pthread_condattr_destroy, "pthread_condattr_destroy");

   function pthread_condattr_getpshared (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_condattr_t; uu_pshared : access int) return int;  -- /usr/include/pthread.h:1017
   pragma Import (C, pthread_condattr_getpshared, "pthread_condattr_getpshared");

   function pthread_condattr_setpshared (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_condattr_t; uu_pshared : int) return int;  -- /usr/include/pthread.h:1023
   pragma Import (C, pthread_condattr_setpshared, "pthread_condattr_setpshared");

   function pthread_condattr_getclock (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_condattr_t; uu_clock_id : access arm_linux_gnueabihf_bits_types_h.uu_clockid_t) return int;  -- /usr/include/pthread.h:1028
   pragma Import (C, pthread_condattr_getclock, "pthread_condattr_getclock");

   function pthread_condattr_setclock (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_condattr_t; uu_clock_id : arm_linux_gnueabihf_bits_types_h.uu_clockid_t) return int;  -- /usr/include/pthread.h:1034
   pragma Import (C, pthread_condattr_setclock, "pthread_condattr_setclock");

   function pthread_spin_init (uu_lock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_spinlock_t; uu_pshared : int) return int;  -- /usr/include/pthread.h:1045
   pragma Import (C, pthread_spin_init, "pthread_spin_init");

   function pthread_spin_destroy (uu_lock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_spinlock_t) return int;  -- /usr/include/pthread.h:1049
   pragma Import (C, pthread_spin_destroy, "pthread_spin_destroy");

   function pthread_spin_lock (uu_lock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_spinlock_t) return int;  -- /usr/include/pthread.h:1053
   pragma Import (C, pthread_spin_lock, "pthread_spin_lock");

   function pthread_spin_trylock (uu_lock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_spinlock_t) return int;  -- /usr/include/pthread.h:1057
   pragma Import (C, pthread_spin_trylock, "pthread_spin_trylock");

   function pthread_spin_unlock (uu_lock : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_spinlock_t) return int;  -- /usr/include/pthread.h:1061
   pragma Import (C, pthread_spin_unlock, "pthread_spin_unlock");

   function pthread_barrier_init
     (uu_barrier : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrier_t;
      uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrierattr_t;
      uu_count : unsigned) return int;  -- /usr/include/pthread.h:1069
   pragma Import (C, pthread_barrier_init, "pthread_barrier_init");

   function pthread_barrier_destroy (uu_barrier : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrier_t) return int;  -- /usr/include/pthread.h:1075
   pragma Import (C, pthread_barrier_destroy, "pthread_barrier_destroy");

   function pthread_barrier_wait (uu_barrier : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrier_t) return int;  -- /usr/include/pthread.h:1079
   pragma Import (C, pthread_barrier_wait, "pthread_barrier_wait");

   function pthread_barrierattr_init (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrierattr_t) return int;  -- /usr/include/pthread.h:1084
   pragma Import (C, pthread_barrierattr_init, "pthread_barrierattr_init");

   function pthread_barrierattr_destroy (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrierattr_t) return int;  -- /usr/include/pthread.h:1088
   pragma Import (C, pthread_barrierattr_destroy, "pthread_barrierattr_destroy");

   function pthread_barrierattr_getpshared (uu_attr : access constant arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrierattr_t; uu_pshared : access int) return int;  -- /usr/include/pthread.h:1092
   pragma Import (C, pthread_barrierattr_getpshared, "pthread_barrierattr_getpshared");

   function pthread_barrierattr_setpshared (uu_attr : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_barrierattr_t; uu_pshared : int) return int;  -- /usr/include/pthread.h:1098
   pragma Import (C, pthread_barrierattr_setpshared, "pthread_barrierattr_setpshared");

   function pthread_key_create (uu_key : access arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_key_t; uu_destr_function : access procedure (arg1 : System.Address)) return int;  -- /usr/include/pthread.h:1112
   pragma Import (C, pthread_key_create, "pthread_key_create");

   function pthread_key_delete (uu_key : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_key_t) return int;  -- /usr/include/pthread.h:1117
   pragma Import (C, pthread_key_delete, "pthread_key_delete");

   function pthread_getspecific (arg1 : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_key_t) return System.Address;  -- /usr/include/pthread.h:1120
   pragma Import (C, pthread_getspecific, "pthread_getspecific");

   function pthread_setspecific (uu_key : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_key_t; uu_pointer : System.Address) return int;  -- /usr/include/pthread.h:1123
   pragma Import (C, pthread_setspecific, "pthread_setspecific");

   function pthread_getcpuclockid (uu_thread_id : arm_linux_gnueabihf_bits_pthreadtypes_h.pthread_t; uu_clock_id : access arm_linux_gnueabihf_bits_types_h.uu_clockid_t) return int;  -- /usr/include/pthread.h:1129
   pragma Import (C, pthread_getcpuclockid, "pthread_getcpuclockid");

   function pthread_atfork
     (uu_prepare : access procedure;
      uu_parent : access procedure;
      uu_child : access procedure) return int;  -- /usr/include/pthread.h:1146
   pragma Import (C, pthread_atfork, "pthread_atfork");

end pthread_h;
