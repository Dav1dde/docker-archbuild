# Arch Linux baseline docker container extended to build (AUR) packages
FROM greyltc/archlinux 

# copy in setup script
ADD setup-build-env.sh /usr/bin/setup-build-env

# perform build env setup
RUN setup-build-env

ENTRYPOINT /usr/bin/build_package
