#!/bin/sh

sleep 5

MAIN_LB_URL='https://www.speedrun.com/api/v1/runs?status=new&game=j1l9qz1g&max=100'
EXT_LB_URL='https://www.speedrun.com/api/v1/runs?status=new&game=76rkv4d8&max=100'

MAIN_JSON=$(curl -s $MAIN_LB_URL)
EXT_JSON=$(curl -s $EXT_LB_URL)

MAIN_COUNT=$(echo $MAIN_JSON | tr -d '\r\n' | jq .pagination.size 2>/dev/null || echo "0" )
EXT_COUNT=$(echo $EXT_JSON | tr -d '\r\n' | jq .pagination.size 2>/dev/null || echo "0" )

COUNT=$(( $MAIN_COUNT + $EXT_COUNT ))

[[ "$COUNT" > "0" ]] && echo "🏆 $COUNT" || echo ""
exit 0

