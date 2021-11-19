#!/bin/bash

echo "Warning!! This will delete all data on connected disks!! Press 1 to continue or 0 to exit"
read ans
if [ $ans -eq 1 ]
then
	cd /opt/MegaRAID/perccli
	#DISK_COUNT=$((`sudo ./perccli64 /c0 show | grep "32:" | wc -l`-5))

	sudo ./perccli64 /c0/fall delete
	echo "Foreign config deleted!" 
	sleep 1
	echo "===================================================================================================="
	#for ((i=0; i<=$DISK_COUNT; i++)) do
	for ((i=0; i<=11; i++)) do
	sudo ./perccli64 /c0 add vd type=raid0 drives=32:$i
	echo "Added PD #$i to VD #$i"
	echo "===================================================================================================="
	done
fi
echo "Exiting..."

