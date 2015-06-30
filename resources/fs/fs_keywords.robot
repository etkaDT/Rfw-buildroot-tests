*** Settings ***
Documentation    Provides Keyword for testing ext file systems
Library     Ext2fs.py
Library     Process
Library     Operating System
Library     String

*** Variables ***
${VOLNAME_PROP}       "Filesystem volume name"
${REVISION_PROP}      "Filesystem revision #"
${FEATURES_PROP}      "Filesystem features"
${BLOCKCNT_PROP}      "Block count"
${INODECNT_PROP}      "Inode count"
${RESBLKCNT_PROP}     "Reserved block count"


*** Keywords ***
Run Dumpe2fs
    [arguments]    ${builddir}    ${image} 
    ${image_path}=    Join Path    ${builddir}    images    ${image}
    ${out}=    Run Process     host/usr/sbin/dump2fs    ${image_path}    stderr=/dev/null    cwd=${Builddir}    env:LANG=C
    @{output}=    Split To Lines    ${out.strip()}
    Set Suite Variable    ${DUMP}    @{output}

Check Ext Fs Property
    [arguments]    ${property}    ${expected_value}    ${dump}
    ${out}=    Get Prop of Ext Fs    ${dump}    ${property}
    # Get Prop of Ext Fs is in the Ext2fs.py library
    Should Be equal    ${property}    ${expected_value}


Check If Mounted
    [arguments]    ${fs_type}
    Check Command Return Code    0    mount | grep '/dev/root on / type ${fs_type}' 
    

