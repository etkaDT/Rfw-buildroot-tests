from robot.libraries.BuiltIn import BuiltIn
class Buildroot(object):
    """ RobotFramework Buildroot Library

        Expands the buildroot.robot resource file

        Should Contain all methods that are not trivial enough to be written
        with ordinary robotframework syntax (i.e. if you have a lot of ifs and
        fors).
    """
    def __init__(self):
        pass

    def qemu_args(self, arch, kernel=None, options=None, append=None):
        """ Determine the command line that starts qemu with the current
            configuration

            This is mainly a copypaste from system.py's boot function except
            that this one does not boot qemu and merely provides the args

        """
        qemu_cmd = ""
        qemu_args = []
        qemu_arch = arch
        kappend = []

        if kernel:
            machine = None
            if kernel == "builtin":
                if arch == "armv7":
                    kernel = "kernels/kernel-vexpress"
                    machine = "vexpress-a9"
                    kappend.append("console=ttyAMA0")
                    qemu_args += [ "-dtb", "kernels/vexpress-v2p-ca9.dtb"]
                    qemu_arch = "arm"
                elif arch == "armv5":
                    kernel = "kernels/kernel-versatile"
                    machine = "versatilepb"
                    kappend.append("console=ttyAMA0")
                    qemu_arch = "arm"

            qemu_args += ["-kernel", kernel]
            if machine:
                qemu_args += ["-M", machine]

        if append:
            kappend += append

        if kappend:
            qemu_args += ["-append", " ".join(kappend)]

        if options:
            qemu_args += options
        qemu_cmd = ["qemu-system-%s" % qemu_arch,
                    "-serial", "telnet::1234,server",
                    "-display", "none"] + qemu_args

        return qemu_cmd


    def login(self, username, password=None, login_prompt='login: ',
              password_prompt='Password: ', login_timeout='1 second',
              login_incorrect='Login incorrect'):
        """
        This is a hack of the robotframework telnet library's login function
        because that library does not support login without password.

        Just one test is needed inside _submit_credentials
        https://github.com/robotframework/robotframework/blob/master/src/robot/libraries/Telnet.py
        to test if password is None and There would be no need for this code.
        I did not take the time to submit a pull request to robotframework.
        """
        connection = BuiltIn().get_library_instance('Telnet')
        if password:
            out = connection.login(username, password,
                                   login_prompt=login_prompt,
                                   password_prompt=password_prompt,
                                   login_timeout=login_timeout,
                                   login_incorrect=login_incorrect)
            return out
        output = connection.read_until(login_prompt, 'TRACE')
        #_newline is private, no other way to get it than to set it once and set it back
        new_line = connection.set_newline('\n')
        connection.set_newline(new_line)
        connection.write_bare(username  + new_line)
        output = connection.read_until_prompt()
        return output




