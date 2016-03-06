FROM drtom/server-dependencies
MAINTAINER “Tom Schank” <DrTom@schank.ch>

COPY ansible /cider-ci/ansible
COPY bin /cider-ci/bin

COPY tmp/server /cider-ci/server

RUN cd /cider-ci/ansible && ansible-playbook play_build-server.yml
