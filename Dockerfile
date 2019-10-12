FROM ubuntu:16.04

RUN apt-get update &&\
    apt-get install -y sudo time git-core subversion build-essential gcc-multilib \
                       libncurses5-dev python3 curl vim libreadline-dev libssl-dev \
                       zlib1g-dev gawk flex gettext wget xz-utils unzip python autotools-dev \
                       perl libxml-parser-perl rpcbind nfs-common &&\
    apt-get clean

# Add "repo" tool (used by many Yocto-based projects)
RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo &&\
    chmod a+x /usr/local/bin/repo

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash &&\
    apt-get install -y nodejs

RUN npm install --global gulp preact@8.2.7 preact-compat preact-cli preact-material-components@1.5.2 webpack react gulp-cli
RUN npm install gulp preact@8.2.7 preact-compat preact-cli preact-material-components@1.5.2 webpack react gulp-cli

# Default sh to bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN useradd -m openwrt &&\
    echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt

USER openwrt
WORKDIR /home/openwrt

CMD ["/bin/bash"]
