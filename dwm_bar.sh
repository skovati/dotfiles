#!/bin/bash

dwm_ip () {
    printf "ip:"
    printf $(curl -s ifconfig.io) 
    printf " | "
}

dwm_mem () {
    printf "mem:"
    printf $(free -m | grep Mem: | cut -f 2 -d ":" | awk '{$1=$1};1' | cut -f 2 -d " ")
    printf "mb | "
}

dwm_cpu () {
    printf "cpu:"
    printf $(top -bn1 | grep %Cpu | tr -s " " | cut -d " " -f2)
    printf "%% | "
}

dwm_date () {
    printf $(date +%T)
    printf " "

}



while true
do
    xsetroot -name "$(dwm_ip)$(dwm_mem)$(dwm_cpu)$(dwm_date)"
            sleep 1
        done
