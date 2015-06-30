*** Settings ***
Documentation    Tests for ext2 revision 1.
...              Never ran, but should work
...              See resources files for more info

Library        Operating System
Resource       ../resources/fs/fs_keywords.robot
Resource       ../resources/common/buildroot.robot
Suite Setup    Run Dumpe2fs    ${builddir}    ${image}

*** Variables ***
${arch}        armv7
${kernel}      builtin
@{options}     ${EMPTY}     
@{append}      root\=/dev/mmcblk0    rootfstype\=ext2
${image}       rootfs.ext2
${builddir}    

*** Test cases ***
Test Volume Name
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${VOLNAME_PROP}
    Should Be Equal    ${out}    foobar

Test Revision
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${REVISION_PROP}
    Should Be Equal    ${out}    1 (dynamic)

Test Journal Feature
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${FEATURES_PROP}
    Should Not Contain    ${out}    has_journal

Test Mount
    [setup]     Boot And Connect
    Check Command Return Code    0    mount | grep '/dev/root on / type ext2'
    [teardown]    Shutdown
    

*** keywords ***
Create Image Option
    ${image_path}=    Join Path     ${builddir}     images    ${image}
    @{image_options}=    Create List    -drive    file\=${image_path},if\=sd
    [return]    @{image_options}

    
    
    



