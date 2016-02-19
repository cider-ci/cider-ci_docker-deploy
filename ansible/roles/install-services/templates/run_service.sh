#!/usr/bin/env bash
set -eux
cd {{service_dir}}
export CLASSPATH={{service_classpath}}
java {{service.main}}
