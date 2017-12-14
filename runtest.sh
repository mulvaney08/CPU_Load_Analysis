#!/bin/bash
#All work completed by Aaron Mulvaney - X00118910
#Echo the title for the output table to file named results.dat
echo -e "CO\tN\tidle" > results.dat

#Some output to let the user know what is happening
echo "Each loadtest will terminate after a 5 second run time"
echo "This may take a few minutes..."

#for loop to increase the number of concurrent users every loop starting at 1 up to 50
for i in {1..50}
do
        #run the loadtest in the background
        ./loadtest $i &
        #set variable idleTime to be equal to the system idle time after the loadtest has ran for 5 seconds
        idleTime=`mpstat 5 1 -o JSON | jq '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'`
        #kill the loadtest process
        pkill loadtest
        #set the number of completions for this loadtest
        completions=`wc -l < synthetic.dat`
        #output the number of completions, number of concurrent users and the system idle time for each loadtest
        echo -e "$completions\t$i\t$idleTime" >> results.dat
done

echo "Loadtest complete for 1..50 users, please see results.dat for the results of this test"
