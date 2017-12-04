#!/bin/bash
#Echo the title for the output table to file named results.dat
echo -e "CO\tN\tidle" > results.dat
#re-set the counter for the number of completions of the loadtest
completions=0
#for loop to increase the number of concurrent users every loop
for i in {1..50}
do
        #run the loadtest in the background for 5 seconds
        ./loadtest $i &
        sleep 5
        #set the number of completions for this loadtest
        completions=`wc -l < synthetic.dat`
        #set variable idleTime to be equal to the system idle time during the loadtest
        idleTime=`mpstat -o JSON | jq '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'`
        #output the number of completions, number of concurrent users and the system idle time for each loa$
        echo -e "$completions\t$i\t$idleTime" >> results.dat
        #kill the loadtest process
        pkill loadtest  
done
