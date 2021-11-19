#! /bin/bash

for ((i=0; i<=$((`lsblk | grep disk | wc -l`-2)); i++)) do

TEST=`sudo smartctl -X -d megaraid,$i /dev/sdb | grep "Self-testing aborted!"`
echo "=================================================================================================="
echo "DRIVE: $i: $TEST"
	
done
