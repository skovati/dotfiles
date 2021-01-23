#!/bin/bash

percent=$(amixer | grep -m1 -P -wo "\d{1,3}%")
muted=$(amixer | grep "off" | wc -l)
if [ $percent == "0%" ] || [ $muted -eq 4 ]; then
   echo " muted"
else
   echo " $percent"
fi
