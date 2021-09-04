# ada-linux

Ada code projects that run on Linux user-space.
These projects call C fucntions from libc, pthreads and other
C libraries.

# How to Generate Ada Bindings for C Header Files

Run the following command on the given C header file:

`g++ -c -fdump-ada-spec -C <C header file>`

Example:

`g++ -c -fdump-ada-spec -C /usr/include/pthread.h`