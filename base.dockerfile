FROM centos:latest
MAINTAINER “Tom Schank” <DrTom@schank.ch>

### PREPARE & UTILS ###########################################################

RUN yum -y update

RUN yum -y install vim-enhanced bash-completion epel-release \
  bc apg openssl \
  && yum clean all


### DEV #######################################################################

RUN yum -y groupinstall "Development Tools" \
  && yum clean all

RUN yum -y install zlib zlib-devel gcc-c++ patch \
  readline readline-devel libyaml-devel libffi-devel \
  openssl-devel make bzip2 autoconf automake libtool \
  bison curl sqlite-devel ruby \
  && yum clean all


### GIT #######################################################################

RUN yum -y remove git
RUN yum -y install \
  http://opensource.wandisco.com/centos/7/git/x86_64/git-2.7.0-1.WANdisco.284.x86_64.rpm \
  http://opensource.wandisco.com/centos/7/git/x86_64/perl-Git-2.7.0-1.WANdisco.284.noarch.rpm \
  && yum clean all


### NODEJS ####################################################################

RUN curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -
RUN yum -y install nodejs \
  && yum clean all


### JDK8 ######################################################################

RUN curl -L --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
  -o /tmp/jdk8.rpm http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.rpm  \
  && yum -y localinstall /tmp/jdk8.rpm && rm /tmp/jdk8.rpm \
  && yum clean all


### ANSIBLE ###################################################################

RUN yum -y install python-pip python-devel python-psycopg2 \
  && yum clean all
RUN pip install --upgrade pip
RUN pip install ansible==2.0.0.2


### LEIN ######################################################################

RUN curl -L -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
  && chmod a+x /usr/local/bin/lein \
  && ansible localhost -m lineinfile -a 'dest=/root/.bash_profile line="export LEIN_ROOT=yes"'

RUN lein


### RBENV & RUBY ##############################################################

RUN curl https://raw.githubusercontent.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
COPY rbenv.sh /etc/profile.d/rbenv.sh
# RUN source /etc/profile.d/rbenv.sh && rbenv install 2.2.4
# RUN source /etc/profile.d/rbenv.sh && rbenv global 2.2.4 && gem install bundler


### SYSTEMD ###################################################################

ENV CONTAINER docker
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ “/sys/fs/cgroup” ]
ENTRYPOINT ["/lib/systemd/systemd"]


### CEANUP ####################################################################

RUN rm -rf /tmp/*
RUN yum clean all
