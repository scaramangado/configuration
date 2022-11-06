#!/bin/sh

sleep 5

URL='https://racetime.gg/oot/races/data'

JSON=$(curl -s $URL)

COUNT=$(echo $JSON | jq -s '.[0].races | map(select(.recorded == false and .recordable == true and .status.value == "finished")) | length' 2>/dev/null)

[ ! "$COUNT" = "0" ] && echo "⏱️ $COUNT" || echo ""
exit 0

