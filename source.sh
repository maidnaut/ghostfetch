#!/bin/bash

color="white"
logo=""

for arg in "$@"; do
    case $arg in
        -c=*)
            color="${arg#*=}"
            shift
            ;;
        -color=*)
            color="${arg#*=}"
            shift
            ;;

        -t=*)
            text="${arg#*=}"
            shift
            ;;
        -text=*)
            text="${arg#*=}"
            shift
            ;;
    esac
done

# Check if color code was provided
case $color in
    white) echo -e "\e[97m" ;;
    black) echo -e "\e[30m" ;;
    red) echo -e "\e[31m" ;;
    green) echo -e "\e[32m" ;;
    yellow) echo -e "\e[33m" ;;
    blue) echo -e "\e[34m" ;;
    magenta) echo -e "\e[35m" ;;
    cyan) echo -e "\e[36m" ;;
    gray) echo -e "\e[90m" ;;
    light-gray) echo -e "\e[37m" ;;
    light-red) echo -e "\e[91m" ;;
    light-green) echo -e "\e[92m" ;;
    light-yellow) echo -e "\e[93m" ;;
    light-blue) echo -e "\e[94m" ;;
    light-magenta) echo -e "\e[95m" ;;
    light-cyan) echo -e "\e[96m" ;;
    *) echo -e "\e[97m" ;; # default to white
esac

# Do text thingy
if [[ -n $text ]]; then
    # Text was provided instead, figlet it
    printf '%s\n' "$text" | figlet -f slant
else
    # Nothing was provided, so figlet the os name
    cat /etc/*-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/"//g' | figlet -f slant
fi
