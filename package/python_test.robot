*** Settings ***
Documentation     Data Driven test to check python on buildroot
...
...               This test checks the python package.
...               I ran it with an image of my own and it worked.

Resource          ../resources/common/buildroot.robot
Test Template     Check Command Return Code
 
Suite Setup       Boot And Connect
Suite TearDown    Shutdown 


*** Variables ***
${kernel}      builtin
@{options}     
@{append}      
${arch}        armv5
${image}       rootfs.cpio
${builddir}    



*** Test Cases ***       EXPECTED_CODE    COMMAND
Check Python Version     0                python --version 2>&1 | grep -q '^Python 2' 
Check Python Math        0                python -c 'import math; math.floor(12.3)' 
Check Python Libc        0                python -c 'import ctypes; libc = ctypes.cdll.LoadLibrary(\"libc.so.0\"); print libc.time(None)'
Check Python Zlib        1                python -c 'import zlib'

*** keywords***
Create Image Option
    [documentation]    Called by Keyword Boot, helps getting the correct option
    ${image_path}=       Join Path    ${builddir}    images    ${image}
    @{image_option}=     Create List    -initrd    ${image_path}
    [return]    @{image_option}

