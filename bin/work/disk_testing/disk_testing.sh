#!/bin/bash

ans=1
echo "======================================================================================================================================
Welcome to Luke's Disk Testing Script!"

while [ $ans -ne 0 ]; do

echo "======================================================================================================================================
What would you like to do? (0 to exit):

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
echo "You have chosen to show current testing status"
./test_status.sh
;;
6)
echo "You have chosen to cancel all running tests"
./cancel_test.sh
;;
esac
done
echo "Exiting... Come Again!"


