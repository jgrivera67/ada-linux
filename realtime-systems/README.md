# How to Build Executalbes for the Assignments

To build the executables of the assignments in this directory,
make sure that the GNAT Ada compiler and the gprbuild tool are installed:

`sudo apt install gnat gprbuild`

To build the executable of a given assignment from the command line,
cd to corresponding directory and run `gprbuild` as follows:

```
cd <assignment directory>
gprbuild -P assignment.gpr -p
```

The executable will be generated in the directory of the assignment
with the following name:

`<assignment name>/<assignment name>.elf`

Example:
```
cd assignment1
gprbuild -P assignment.gpr -p
./assignment1.elf
```
# How to Generate Ada Bindings for C Header Files

Run the following command on the given C header file:

`g++ -c -fdump-ada-spec -C <C header file>`

Example:

`g++ -c -fdump-ada-spec -C /usr/include/pthread.h`
