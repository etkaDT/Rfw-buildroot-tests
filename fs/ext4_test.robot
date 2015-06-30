*** Settings ***
Documentation    Tests for ext4
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
@{append}      root\=/dev/mmcblk0    rootfstype\=ext4
${image}       rootfs.ext4
${builddir}    

*** Test cases ***
Test Revision
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${REVISION_PROP}
    Should Be Equal    ${out}    1 (dynamic)

Test Block Count
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${BLOCKCNT_PROP}
    Should Be Equal    ${out}    16384

Test Inode Count
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${INODECNT_PROP}
    Should Be Equal    ${out}    3008

Test Journal Feature
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${FEATURES_PROP}
    Should Contain    ${out}    has_journal

Test Extent Feature
    ${out}=    Get Prop of Ext Fs    ${DUMP}    ${FEATURES_PROP}
    Should Contain    ${out}    extent

Test Mount
    [setup]     Boot And Connect
    Check Command Return Code    0    mount | grep '/dev/root on / type ext4'
    [teardown]    Shutdown
    

*** keywords ***
Create Image Option
    ${image_path}=    Join Path     ${builddir}     images    ${image}
    @{image_options}=    Create List    -drive    file\=${image_path},if\=sd
    [return]    @{image_options}

    
    
    



