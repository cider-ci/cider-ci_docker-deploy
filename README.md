# Docker Deploy

Deploy the Cider-CI server to a docker container.

## Docker



    docker run -d -t --privileged=true -p 8080:80 \
      --name cider-ci_server  \
      -v '/Users/thomas/Programming/CIDER-CI/cider-ci_v4/server-container/bin:/cider-ci/bin' \
      -v '/Users/thomas/Programming/CIDER-CI/cider-ci_v4/server-container/ansible:/cider-ci/ansible' \
      cider-ci/server

    docker exec -ti cider-ci_server bash



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
