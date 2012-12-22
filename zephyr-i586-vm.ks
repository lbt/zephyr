# -*-mic2-options-*- -f livecd --record-pkgs=name --pkgmgr=yum --arch=i686 -*-mic2-options-*-
# 
# Do not Edit! Generated by:
# kickstarter.py
# 

lang en_US.UTF-8
keyboard us
timezone --utc UTC
part / --size 3000 --ondisk sda --fstype=ext3
rootpw nemo 
xconfig --startxonboot
bootloader  --timeout=0  --append="quiet video=vesafb:mtrr:3 vga=864 vt.global_cursor_default=0" 
user --name nemo  --groups audio,video --password nemo 

repo --name=mer-core --baseurl=http://releases.merproject.org/releases/latest/builds/i586/packages --save --debuginfo
repo --name=ce-adaptation-x86-generic --baseurl=http://repo.pub.meego.com/CE:/Adaptation:/x86-generic/Mer_Core_i586/ --save
repo --name=zephyr --baseurl=http://repo.merproject.org/zephyr:/devel:/mw/latest_i586/ --save
repo --name=kernel --baseurl=http://repo.pub.meego.com/home:/stskeeps:/fbdev-kernel/Mer_Core_i586/ --save --debuginfo
%packages
@Mer Graphics Common
@Mer Connectivity
@Mer Core

kernel-adaptation-pc

acpid
linux-firmware
installer-shell
mesa-llvmpipe-libEGL
mesa-llvmpipe-libGLESv2
openssh-clients
openssh-server
vim-enhanced
-uxlaunch

qt5-plugin-imageformat-jpeg
qt5-plugin-platform-eglfs
qt5-qtdeclarative-qmlscene
qt5-qtdeclarative-import-qtquick2plugin
qt5-qtwayland-wayland_egl <= 5
qt5-qtdeclarative-import-window2
qt5-plugin-generic-evdev
zephyr-session
xkeyboard-config
liberation-sans-fonts

%end

%post
# rpm-rebuilddb.post from mer-kickstarter-configs package
# Rebuild db using target's rpm
echo -n "Rebuilding db using target rpm.."
rm -f /var/lib/rpm/__db*
rpm --rebuilddb
echo "done"
## end rpm-rebuilddb.post

## prelink.post from mer-kickstarter-configs package
# Prelink can reduce boot time
if [ -x /usr/sbin/prelink ]; then
   echo -n "Running prelink.."
   /usr/sbin/prelink -aRqm
   echo "done"
fi
## end prelink.post


%end

%post --nochroot
if [ -n "$IMG_NAME" ]; then
    echo "BUILD: $IMG_NAME" >> $INSTALL_ROOT/etc/meego-release
fi


%end
