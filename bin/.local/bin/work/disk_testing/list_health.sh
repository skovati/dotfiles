#!/bin/bash

for ((i=0; i<=$((`lsblk | grep disk | wc -l`-2)); i++)) do

	INFO=`sudo smartctl -H -d megaraid,$i /dev/sdb | grep "SMART overall-health"`
	SHORT=`sudo smartctl -a -d megaraid,$i /dev/sdb | grep -m2 Short | tail -n1`
	EXTENDED=`sudo smartctl -a -d megaraid,$i /dev/sdb | grep -m2 Extended | tail -n1`
	echo "================================================================================================="
	echo "DRIVE: $i"
	echo "$INFO"
	echo "$SHORT" 
	echo "$EXTENDED"
done
