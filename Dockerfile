# Arch Linux baseline docker container extended to build (AUR) packages
FROM greyltc/archlinux 

# copy install and build script
ADD build_package /usr/bin/build_package

ADD setup /
RUN chmod +x /setup

# installs sudo and (runtime) dependencies for makepkg and do some configuration
RUN /setup && rm /setup
    
# set default environment variables for the entrypoint
ENV USER_NAME="pkgbuilder" \
    USER_ID="1000" \
    GROUP_NAME="users" \
    GROUP_ID="100" \
    REPO_NAME="" \
    REPO="" \
    REPO_SIG=""
    
ENTRYPOINT /usr/bin/build_package
