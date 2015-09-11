from robot.libraries import Process

class QemuAlreadyStarted(RuntimeError):
        ROBOT_CONTINUE_ON_FAILURE = True

class Qemu(object):
    """ RobotFramework Qemu Library

        Expands the qemu.robot resource file.
        Contains usefull keywords for booting a Qemu target
    """
    def __init__(self):
        self._process = Process.Process()
        self.qemu_process = None

    def boot_qemu(self, arch, kernel=None, options=None, append=None):
        """ Determine the command line that starts qemu with the current
            configuration. And starts Qemu
        """
        if self.qemu_process:
            print('hohoho')
            raise QemuAlreadyStarted('A Qemu instance is already running')
        print self.qemu_process
        qemu_cmd = ""
        qemu_args = []
        qemu_arch = arch
        kappend = []

        if kernel:
            qemu_args += ["-kernel", kernel]

        if append:
            kappend += append

        if kappend:
            qemu_args += ["-append", " ".join(kappend)]

        if options:
            qemu_args += options
        qemu_cmd = ["qemu-system-%s" % qemu_arch,
                    "-display", "none"] + qemu_args
        self.qemu_process = self._process.start_process(*qemu_cmd)
        print self.qemu_process

    def stop_qemu(self):
        """
        Stop a previously started Qemu instance
        """
        print self.qemu_process
        self._process.terminate_process(self.qemu_process)
        self.qemu_process = None
