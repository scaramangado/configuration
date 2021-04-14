#!/bin/sh

URL='https://racetime.gg/oot/races/data'

JSON=$(curl -s $URL)

COUNT=$(echo $JSON | jq -s '.[0].races | map(select(.recorded == false and .recordable == true and .status.value == "finished")) | length')

[[ COUNT -ne 0 ]] && echo "⏱️ $COUNT"
exit 0

