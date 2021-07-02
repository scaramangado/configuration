#!/bin/bash

local distro=""
local color=""

case $(lsb_release -si || echo "") in
	Debian) distro= ; color=#d70a53 ;;
	Arch) distro= ; color=#1793d1 ;;
	*) distro= ; color=#ffffff ;;
esac


killall polybar
rm /tmp/polybar_*.pid

MONITOR=DisplayPort-0 \
POLY_DISTRO=$distro \
POLY_DISTRO_COLOR=$color \
GDK_SCALE=1 \
GDK_DPI_SCALE=1 \
polybar primary &

echo "$!" > /tmp/polybar_DisplayPort-0.pid

MONITOR=DisplayPort-0 \
POLY_DISTRO=$distro \
POLY_DISTRO_COLOR=$color \
GDK_SCALE=1 \
GDK_DPI_SCALE=1 \
polybar secondary &

echo "$!" > /tmp/polybar_DisplayPort-1.pid

