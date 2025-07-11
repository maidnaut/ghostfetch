#!/bin/bash

# Colors
RESET='\033[0m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

#maybe a section to comment/uncomment things is a rather easy and straight-forward format that alters the fetch for quick customization.

# Theme Colors: reminder to add commands to change colors with simple flags maybe
THEME_BORDER=$MAGENTA
THEME_LOGO=$MAGENTA
THEME_LABEL=$GREEN
THEME_VALUE=$WHITE

# Get system information: I'd like to make this snarkier or add a twist to how they're labeled. Short and sweet is nice but need originality and maybe unique yet non-vuln sys-info

HOSTNAME=$(hostnamectl --static)
USER=$(whoami)
OS=$(uname -s)
KERNEL=$(uname -r)
DISTRO=$(grep ^PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
UPTIME=$(uptime -p)
BOOT_TIME=$(systemd-analyze | grep 'Startup finished')
CPU=$(lscpu | grep "Model name" | sed 's/Model name:\s*//')
MEMORY=$(free -h | grep Mem | awk '{print $3 " / " $2}')
DISK=$(df -h / | grep / | awk '{print $3 " / " $2}')

# Simplified GPU output: This part sucked.
GPU=$(lspci | grep -i VGA | sed -E 's/.*\[(.*)\] (.*) \[.*\]/[\1] \2/' | sed 's/ \(rev.*\)//' | head -n 1)

if [[ -z "$GPU" ]]; then
    GPU="No GPU found"
fi

PROCESSES=$(ps aux --no-heading | wc -l)
SHELL=$SHELL

# ====== ASCII Logo ======: I don't hate this but I also don't love it. My find a new logo or style
ascii_logo() {
    local user=$1
    local host=$2
    local logo="
      
      ██████╗  ██╗  ██╗  ██████╗  ███████╗ ████████╗
       ██╔════╝  ██║  ██║ ██╔═████╗ ██╔════╝ ╚══██╔══╝
        ██║  ███╗ ███████║ ██║██╔██║ ███████╗    ██║   
	 ██║   ██║ ██╔══██║ ████╔╝██║ ╚════██║    ██║   
	  ╚██████╔╝ ██║  ██║ ╚██████╔╝ ███████║    ██║   
	    ╚═════╝  ╚═╝  ╚═╝  ╚═════╝  ╚══════╝    ╚═╝   
      ${user}@${host}
"
    # Print the ASCII logo
    echo -e "${THEME_LOGO}$logo${RESET}"
}

# Format and print the information
print_line() {
    printf "${THEME_BORDER}%-60s${RESET}\n" "------------------------------------------------------------"
}

print_footer() {
    printf "${THEME_BORDER}%-60s${RESET}\n" "------------------------------------------------------------"
}

# Main Function to Display Info
main() {
    # Print the ASCII logo
    ascii_logo "$USER" "$HOSTNAME"
    
    
    print_line
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Hostname" "$HOSTNAME"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Distro:" "$DISTRO"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Kernel:" "$KERNEL"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Uptime:" "$UPTIME"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Boot Time:" "$BOOT_TIME"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "CPU:" "$CPU"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Memory:" "$MEMORY"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Disk:" "$DISK"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "GPU:" "$GPU"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Processes:" "$PROCESSES"
    printf "${THEME_LABEL}%-12s${RESET}%-48s\n" "Shell:" "$SHELL"
    print_line
    print_footer
}

# Run the main function
main
