#!/bin/bash

if [[ $(pamixer --get-mute) == "true" ]]; then
   echo muted
else
   echo "$(pamixer --get-volume)%"
fi
