#!/bin/bash
if [ "$#" -ne 2 ]; then

	echo "Wrong number of parameters"
else
	./loadtest $1 &
	sleep $2
	pkill loadtest
fi
