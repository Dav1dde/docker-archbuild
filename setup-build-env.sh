#!/usr/bin/bash -xe

# installs sudo and (runtime) dependencies for makepkg
pacman -Syyu --noconfirm --noprogressbar base-devel

# Build directory (mount PKGBUILD here)
mkdir -p /home/build

# Setup the build script
cat <<EOF > /usr/bin/build_package
#!/bin/bash -ex

cd /home/build

pacman -Syyu --noconfirm --noprogressbar

uid=\${USER:-nobody}
gid=\${GROUP:-\${USER_ID}}
groupadd -f \${gid}
useradd -M -g \${gid} \${uid}

sudo -u \${uid} makepkg --nosign --syncdeps --noconfirm --force

userdel -f \${uid}
EOF
chmod 755 /usr/bin/build_package

# Allow makepkg to update and install packages
echo "ALL ALL=(ALL) NOPASSWD: /usr/bin/pacman" >> /etc/sudoers


