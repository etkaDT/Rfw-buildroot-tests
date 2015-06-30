# Rfw-buildroot
Sample tests for buildroot using robotframework

Tests for python and ext file systems.

The suite for python works fine, I did not ran the file system tests because 
of a lack of images on my computer

You may find keywords used for tests inside the resource directory's .robot 
files (called resource files) and python files (called Libraries).

I did not create the keyword that builds buildroot nor anything related to that.
I did, however, create the keyword that launches qemu

To communicate with qemu I use the Robot Framework telnet library (provided 
with robotframework)
http://robotframework.org/robotframework/latest/libraries/Telnet.html

However this library is not fully complete, it lacks the support of logging in
with a user that has no password so I wrote my own login keyword.
That could be change by adding "if password:" at line 749 of 
http://github.com/robotframework/robotframework/blob/master/src/robot/libraries/Telnet.py

Another issue is that its "Execute Command" keyword does not get return code
But I have created a keyword for this "Execute Command With Return Code"

What could be usefull for testing Buildroot would be to use the SSHLibrary
wich is great but is not packaged with robotframework:
http://robotframework.org/SSHLibrary/latest/SSHLibrary.html


To run all the test, just type:
pybot . in this directory


Other useful links:
How to write good test cases:
https://code.google.com/p/robotframework/wiki/HowToWriteGoodTestCases

Robot Framework Dos and Don'ts:
http://www.slideshare.net/pekkaklarck/robot-framework-dos-and-donts

Builtin Keywords:
http://robotframework.org/robotframework/latest/libraries/BuiltIn.html

Operating Sytem:
http://robotframework.org/robotframework/latest/libraries/OperatingSystem.html

Process:
http://robotframework.org/robotframework/latest/libraries/Process.html


