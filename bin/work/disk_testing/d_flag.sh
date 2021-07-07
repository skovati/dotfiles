#!/bin/bash

d_flag=false

echo_usage() {
  echo "Use the -d flag followed by the disk number to select just that disk"
}

while getopts 'd' flag; do
  case "${flag}" in
    d) d_flag=true ;;
    *) echo_usage
       exit 1 ;;
  esac
done
if [ $d_flag = true ]
then 
return 0
fi 
return 1
