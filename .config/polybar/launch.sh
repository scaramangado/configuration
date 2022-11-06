#!/bin/bash

killall polybar
polybar $(lsb_release -si)
