FROM cider-ci/server-services:latest

MAINTAINER “Tom Schank” <DrTom@schank.ch>

RUN yum -y install python-psycopg2 \\
  && yum clean all

COPY rbenv.sh /etc/profile.d/rbenv.sh

