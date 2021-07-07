#!/bin/bash

disk=''
d_flag=false

echo_usage() {
  echo "Use the -d flag followed by the disk number to select just that disk"
}

while getopts 'd:' flag; do
  case "${flag}" in
    d) d_flag=true
       disk="${OPTARG}" ;;
    *) echo_usage
       exit 1 ;;
  esac
done


ans=1
echo "======================================================================================================================================
Welcome to Luke's Disk Testing Script!"

while [ $ans -ne 0 ]; do

echo "======================================================================================================================================"
case $d_flag in
  (true)    echo "You have selected disk #$disk";;
  (false)   echo "You have selected all connected disks";;
esac
echo "What would you like to do? (0 to exit):
1: Initialize disks in raid0
2: Run a health check
3: Run short tests
4: Run extended test 
5: Show current testing status
6: Cancel current running tests"
read ans

case $ans in
1)
echo "You have chosen to initialize disks"
./perc_init.sh 
;;
2)
echo "You have chosen to run a health check"
./list_health.sh
;;
3) 
echo "You have chosen to run short tests"
./short_test.sh
;;
4)
echo "You have chosen to run extended tests"
./extended_test.sh
;;
5)
echo "You have chosen to cancel all running tests"
./test_status.sh
;;
6)
echo "You have chosen to show current testing status"
;;
esac
done
echo "Exiting... Come Again!"


