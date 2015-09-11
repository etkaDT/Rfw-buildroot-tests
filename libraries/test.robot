*** settings ***
Documentation   Example Test Suite Using the TelnetHack And Qemu Libraries
Library         Telnet   prompt=${prompt}    timeout=5
Library         telnet/TelnetHack.py
Variables       boot.py
Library         qemu/Qemu.py
Suite Setup     Boot Qemu   ${arch}     kernel=${kernel_path}    options=@{options}      append=@{append}
Suite Teardown  Stop Qemu
*** Variables ***
${address}     localhost
${username}    root
${password}    tototo
${prompt}      \# \r\n\#

*** test cases ***
Connect To Target
    Wait Until Keyword succeeds     10 sec  2 sec   Open Connection     ${address}  port=${tel_port}
    TelnetHack.login    ${username}     ${password}
    Command Return Code Should Be      0   echo 'll'
