FROM drtom/base:latest
MAINTAINER “Tom Schank” <DrTom@schank.ch>

COPY ansible /cider-ci/ansible

RUN cd /cider-ci/ansible && ansible-playbook play_server-dependencies.yml
