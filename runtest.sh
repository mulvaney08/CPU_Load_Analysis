#!/bin/bash

echo -e "CO\tN\tidle" > results.dat
completions=0
for i in {1..10}
do
	#runTime=`$RANDOM % 10 + 1 | bc`
	./loadtest $i &
	sleep 5
	idleTime=`mpstat -o JSON | jq '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'`
	echo -e "5\t$i\t$idleTime" >> results.dat
	pkill loadtest	
done
