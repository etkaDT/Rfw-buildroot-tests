# Test Libraries

Two Robot Framework libraries are provided in the libraries folder

## TelnetHack
**TelnetHack** expands the Robot Framework Telnet Library. It provides
Login without password using **TelnetHack.Login** and keywords for getting
return code of commands:
+ **Execute Command With Return Code**: Returns output and return code
+ **Command Return Code Should Be**: Check that a command's return code was
                                     as expected

## Qemu

The Qemu library provides keywords for starting and stopping Qemu.

### **Boot Qemu**
Args:
+ arch : architecture of the virtual machine (e.g. x86_64)
+ kernel : Default : Empty. Path to kernel image
+ append : Default : Empty. List of kernel command line options
+ options : Default : Empty. List of Qemu options

The keyword starts Qemu with option *-display none*.
It uses the Robot Framework Process Library.

### **Stop Qemu**

Terminate a previously started Qemu process

## test.robot

An example test suite using Qemu and TelnetHack.

At setup of test suite, Robot Framework starts Qemu.
Tests are done
At teardown, Qemu is stopped.

The boot.py variable file contains all required variables for starting Qemu

the folder images contains images used for testing.

## TODO

+ Replace resources files with libraries
