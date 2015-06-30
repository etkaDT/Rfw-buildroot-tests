*** Settings ***
Documentation     Buildroot resource file
...               Provides common keywords used by all buildroot test

Library           Operating System
Library           Telnet    prompt=${prompt}    timeout=5
Library           Process
Library           Buildroot.py 

*** Variables ***
${port}        1234
${address}     localhost
${username}    root
${password}    tototo
${prompt}      \# \r\n\#

*** Keywords ***
Boot
    [documentation]     boots qemu using variables defined in the test file
    @{image_option}=    Create Image Option
    @{options}=    Create List    @{options}    @{image_option}
    @{args}=      Qemu Args    ${arch}    kernel=${kernel}    options=@{options}    append=@{append}
    ${handle}=    Start Process    @{args}
    Set Suite Variable     ${HANDLE}    ${handle}

Shutdown
    [documentation]     Close the telnet connection to qemu and stop qemu 
    ...                 process
    Close Connection
    Terminate Process    ${HANDLE}

Boot And Connect
    [documentation]     Boots, connects and login to qemu. Should also build 
    Boot
    Wait Until Keyword Succeeds  10 sec  2 sec  Open Connection  ${address}  port=${port}
# We need to wait for the connection to be established to continue, obviously
    Buildroot.Login    ${username}     ${password}

Execute Command With Return Code
    [documentation]    Expands the telnet library Execute Command by getting
    ...                Return code
    [arguments]    ${command}    ${loglevel}=${EMPTY}    ${strip_prompt}=${FALSE}
    ${out}=       Execute Command    ${command}    ${loglevel}    ${strip_prompt}
    ${return}=    Execute Command    echo $?     strip_prompt=${TRUE}
    [return]    ${out}    ${return.strip()}

Check Command Return Code
    [documentation]    acts on distant machine
    [arguments]    ${expected_code}    ${command}
    ${out}    ${return_code}    Execute Command With Return Code    ${command}
    Should Be equal    ${expected_code}    ${return_code}

Check Command Output
    [arguments]    ${expected_output}    ${command}
    ${out}    ${output}    Execute Command With Return output    ${command}
    Should Be equal    ${expected_output}    ${output}
