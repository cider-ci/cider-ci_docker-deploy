FROM drtom/server-dependencies
MAINTAINER “Tom Schank” <DrTom@schank.ch>

COPY . /cider-ci/docker-deploy

RUN cd /cider-ci/docker-deploy/ansible && ansible-playbook play_server_install-services.yml
