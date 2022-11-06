#!/bin/sh

DIR=$HOME/.temp-log
FILE=$DIR/$(who -b | sed -rn "s/.*boot\\s+(.*)/\\1/p" | sed "s/ /_/").log

mkdir -p $DIR

for i in {1..59}; do
	sensors > $FILE
	sleep 1
done

