#!/usr/bin/bash -xe

# installs sudo and (runtime) dependencies for makepkg
pacman -Syyu --noconfirm --noprogressbar base-devel

# Build directory (mount PKGBUILD here)
mkdir -p /home/build

# Setup the build script
cat <<EOF > /usr/bin/build_package
#!/bin/bash -ex

groupadd -f -g \${GROUP_ID} \${GROUP_NAME}
useradd -M -g \${GROUP_NAME} -u \${USER_ID} \${USER_NAME}

pacman -Syyu --noconfirm --noprogressbar

cd /home/build
chown -R \${USER_NAME}:\${GROUP_NAME} /home/build
sudo -u \${USER_NAME} makepkg --nosign --syncdeps --noconfirm --force

userdel -f \${uid}
EOF
chmod 755 /usr/bin/build_package

# Allow makepkg to update and install packages
echo "ALL ALL=(ALL) NOPASSWD: /usr/bin/pacman" >> /etc/sudoers


