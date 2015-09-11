from robot.libraries.BuiltIn import BuiltIn


class TelnetHack(object):
    def __init__(self):
        pass

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
        new_line = connection.set_newline('\n')
        connection.set_newline(new_line)
        output = connection.read_until(login_prompt, 'TRACE')
        # _newline is private, no other way to get it than to set it once and
        # set it back
        connection.write_bare(username + new_line)
        output = connection.read_until('#')
        return output

    def execute_command_with_return_code(self,
                                         command,
                                         loglevel=None,
                                         strip_prompt=False):
        """
        Expands the telnet library Execute Command by getting return code
        """
        connection = BuiltIn().get_library_instance('Telnet')
        out = connection.execute_command(command, loglevel=loglevel,
                                         strip_prompt=strip_prompt)
        print(out)
        ret = connection.execute_command('echo $?', strip_prompt=True)
        return out, ret

    def command_return_code_should_be(self, expected_code, command):
        out, ret = self.execute_command_with_return_code(command)
        builtin = BuiltIn().get_library_instance('BuiltIn')
        builtin.should_be_equal_as_integers( expected_code, ret)
