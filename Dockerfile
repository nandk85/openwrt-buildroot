FROM ubuntu:16.04

RUN apt-get update &&\
    apt-get install -y sudo time git-core subversion build-essential gcc-multilib \
                       libncurses5-dev python3 curl vim libssl-dev zlib1g-dev gawk flex gettext wget unzip python &&\
    apt-get clean

# Add "repo" tool (used by many Yocto-based projects)
RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo &&\
    chmod a+x /usr/local/bin/repo

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash &&\
    apt-get install -y nodejs

RUN npm install --global gulp preact preact-compat
RUN npm install gulp preact preact-compat

# Default sh to bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN useradd -m openwrt &&\
    echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt

USER openwrt
WORKDIR /home/openwrt

CMD ["/bin/bash"]
