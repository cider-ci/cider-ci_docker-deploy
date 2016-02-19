FROM cider-ci/ubuntu_15-10:v0

MAINTAINER Tom Schank <drtom@schank.ch>

ENV container docker
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive


### stuff #####################################################################

RUN apt-get update
RUN apt-get install vim-nox bash-completion ca-certificates openjdk-7-jdk python git git-all build-essential libreadline-gplv2-dev libssl-dev libxml2 libxml2-dev libxslt1-dev tklib zlib1g-dev

### cleanup ###################################################################

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
