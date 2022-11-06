#!/bin/sh

DIR=$HOME/.temp-log
FILE=$DIR/$(who -b | sed -rn "s/.*boot\\s+(.*)/\\1/p" | sed "s/ /_/").log
TEMP_FILE=temp.log

mkdir -p $DIR

for i in {1..59}; do
	sensors > $TEMP_FILE
	[ -f $FILE ] || touch $FILE
	[ -s $TEMP_FILE ] && rm $FILE && mv $TEMP_FILE $FILE && free -h >> $FILE
	sleep 1
done

