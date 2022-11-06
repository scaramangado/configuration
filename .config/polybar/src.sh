#!/bin/sh

MAIN_LB_URL='https://www.speedrun.com/api/v1/runs?status=new&game=j1l9qz1g&max=100'
EXT_LB_URL='https://www.speedrun.com/api/v1/runs?status=new&game=76rkv4d8&max=100'

MAIN_JSON=$(curl -s $MAIN_LB_URL)
EXT_JSON=$(curl -s $EXT_LB_URL)

MAIN_COUNT=$(echo $MAIN_JSON | jq .pagination.size 2>/dev/null)
EXT_COUNT=$(echo $EXT_JSON | jq .pagination.size 2>/dev/null)

COUNT=$(( $MAIN_COUNT + $EXT_COUNT ))

[[ COUNT -ne 14 ]] && echo "🏆 $COUNT" || echo ""
exit 0
