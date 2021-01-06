#!/bin/bash

percent=$(amixer | grep -m1 -P -wo "\d{1,3}%")
if [ $percent == "0%" ]; then
   echo " muted"
else
   echo " $percent"
fi
