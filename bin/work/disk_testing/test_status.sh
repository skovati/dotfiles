#!/bin/bash

for ((i=0; i<=$((`lsblk | grep disk | wc -l`-2)); i++)) do

TEST=`sudo smartctl -a -d megaraid,$i /dev/sdb | grep -A 1 "Self-test execution"`
echo "=================================================================================================="
echo "DRIVE: $i"
echo "$TEST"

done


