FROM cider-ci/server-install

MAINTAINER “Tom Schank” <DrTom@schank.ch>

RUN yum -y install openssl apg && yum clean all

COPY . /cider-ci/docker-deploy

RUN cd /cider-ci/docker-deploy/ansible && ansible-playbook play_setup-server-services.yml
