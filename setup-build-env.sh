#!/usr/bin/bash -xe

# installs sudo and (runtime) dependencies for makepkg
pacman -Syyu --noconfirm --noprogressbar base-devel

# Build directory (mount PKGBUILD here)
mkdir -p /home/build

# Setup the build script
cat <<EOF > /usr/bin/build_package
#!/bin/bash -ex

uid=\${USER_ID:-nobody}
gid=\${GROUP_ID:-\${USER_ID}}
groupadd -f \${gid}
useradd -M -g \${gid} \${uid}

pacman -Syyu --noconfirm --noprogressbar

cd /home/build
chown -R \${uid}:\${gid} /home/build
sudo -u \${uid} makepkg --nosign --syncdeps --noconfirm --force

userdel -f \${uid}
EOF
chmod 755 /usr/bin/build_package

# Allow makepkg to update and install packages
echo "ALL ALL=(ALL) NOPASSWD: /usr/bin/pacman" >> /etc/sudoers


