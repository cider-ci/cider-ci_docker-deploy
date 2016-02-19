#!/usr/bin/env bash
set -eux
cd {{server_dir}}{{item.value.path}}

# ruby
source /etc/profile.d/rbenv.sh
rbenv shell {{ruby_version}}
export RAILS_ENV=production
export RAILS_RELATIVE_URL_ROOT={{web_context}}{{item.value.context}}

export MEMORY_TOTAL_MB=$(free -m | awk '/^Mem:/{print $2}')
export XMX_MB=$(echo "($MEMORY_TOTAL_MB * {{item.value.max_memory_fraction}})/1" | bc)
export JRUBY_OPTS="-J-Xmx${XMX_MB}m"
export CACHE_STORE_SIZE_MB=$(echo "($MEMORY_TOTAL_MB * {{item.value.cache_store_size_fraction}})/1" | bc)

bundle exec puma config.ru -t 4:40 -b tcp://localhost:{{item.value.http_port}}
