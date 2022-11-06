#!/bin/bash

local distro=""
local color=""

case $(lsb_release -si || echo "") in
	Debian) distro= ; color=#d70a53 ;;
	Arch) distro= ; color=#1793d1 ;;
	*) distro= ; color=#ffffff ;;
esac


killall polybar
POLY_DISTRO=$distro \
POLY_DISTRO_COLOR=$color \
GDK_SCALE=1 \
GDK_DPI_SCALE=1 \
polybar status
