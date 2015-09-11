"""
Variable file for booting qemu
"""
arch='x86_64'
tel_port = '1234'
options = ['-serial','telnet::' + tel_port + ',server']
options += ['-enable-kvm']
rootfs_path = 'images/rootfs.ext2'
options += ['-hda', rootfs_path]
kernel_path = 'images/bzImage'
append = ['console=ttyS0','root=/dev/sda']
