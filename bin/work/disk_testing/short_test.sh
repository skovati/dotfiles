#!/bin/bash

for ((i=0; i<=$((`lsblk | grep disk | wc -l`-2)); i++)) do

TEST=`sudo smartctl -t short -d megaraid,$i /dev/sdb | grep -A 3 "Testing has begun"`
echo "========================================================================================================="
echo "DRIVE: $i"
echo "$TEST" 
	
done
