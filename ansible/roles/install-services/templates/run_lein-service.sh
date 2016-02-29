#!/usr/bin/env bash
set -eux
cd {{service_dir}}

MEMORY_TOTAL_MB=$(free -m | awk '/^Mem:/{print $2}')
XMX_MB=$(echo "($MEMORY_TOTAL_MB * 0.05)/1" | bc)
export JAVA_OPTS="-Xmx${XMX_MB}m"

export CLASSPATH={{classpath}}
java {{service.main}}
