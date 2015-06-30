class Ext2fs(object):
    """Expends the fs_keywords.robot resource file
    """
    def __init__(self):
        pass

    def get_prop_of_ext_fs(self, out, prop):
        """Copy paste of dumpe2fs_getprop
        """
        for l in out:
            l = l.split(': ')
            if l[0] == prop:
                return l[1].strip()

