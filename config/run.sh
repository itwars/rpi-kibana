#!/bin/bash

SERVER="elasticsearch:9200"

# wait for elastic search to boot up
while true; do
  echo "-- Curling $SERVER to see if it is up already"
  curl -s $SERVER
  if [ $? -eq 0 ]; then
    echo "-- Got curl connection! Done"
    break
  fi
  # wait 5 more seconds
  echo "-- not yet, waiting 5s"
  sleep 5
done

# set -e

# KIBANA_ES_URL=${KIBANA_ES_URL:-http://localhost:9200}
# KIBANA_INDEX=${KIBANA_INDEX:-kibana-int}
#
# sed -i "s;^elasticsearch_url:.*;elasticsearch_url: ${KIBANA_ES_URL};" "/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"
# sed -i "s;^kibana_index:.*;kibana_index: ${KIBANA_INDEX};" "/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"

# mesos-friendly change
unset HOST
unset PORT

exec /kibana/bin/kibana -c /kibana/config/kibana.yml
