# Docker Deploy

Deploy the Cider-CI server to a docker container.

## Docker



    docker build -t cider-ci/base:v0 base

    docker run -p 2222:22 -p 8080:80 -i -t --privileged=true -v /Users/thomas/Programming/CIDER-CI/cider-ci_v3/docker-deploy:/cider-ci/docker-deploy cider-ci/wip02

    docker exec  -ti $NAME /bin/bash



## Systemctl Script Dependency Demo

### Test

setup:
~~~
ln -s /cider-ci/docker/demo/test.service /etc/systemd/system/test.service
ln -s /cider-ci/docker/demo/test-dependant.service /etc/systemd/system/test-dependant.service
systemctl daemon-reload
~~~

now:

~~~
systemctl start test-dependant.service
journalctl --full --all --no-pager -n 15
~~~
