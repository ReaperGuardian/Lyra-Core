#!/bin/bash

# --- ARASAKA CORE CONFIG ---
tput civis
# This ensures that when you exit, your terminal returns to normal
trap "tput cnorm; clear; exit" SIGINT SIGTERM

CYAN="\033[1;36m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
WHITE="\033[1;37m"
DIM="\033[1;30m"
RESET="\033[0m"

# --- UI FUNCTIONS ---
center() {
    local text="$1"
    local width=$(tput cols)
    local raw=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    local len=${#raw}
    local pad=$(( (width - len) / 2 ))
    [ $pad -lt 0 ] && pad=0
    printf "%${pad}s%b\n" "" "$text"
}

run_tool() {
    tput cnorm
    local cmd=$1; local pkg=$2; shift 2
    if ! command -v $cmd &> /dev/null; then
        echo -e "${YELLOW}[!] HEALING SYSTEM: INSTALLING $pkg...${RESET}"
        pkg install $pkg -y > /dev/null 2>&1
    fi
    $cmd "$@"
    echo -e "\n${GREEN}[+] Session Ended. Returning to HUD...${RESET}"
    sleep 2
    tput civis
}

# --- MAIN HUD LOOP ---
while true; do
    T_COLS=$(tput cols)
    IP_ADDR=$(ifconfig wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' | head -n 1 || echo "OFFLINE")
    
    # TELEMETRY DATA
    BATT=$(termux-battery-status 2>/dev/null | grep "percentage" | awk '{print $2}' | sed 's/,//')
    TEMP_RAW=$(termux-battery-status 2>/dev/null | grep "temperature" | awk '{print $2}' | sed 's/,//')
    [ -z "$TEMP_RAW" ] && TEMP_DIS="--" || TEMP_DIS=$(($TEMP_RAW / 10)).$(($TEMP_RAW % 10))
    SIG=$(termux-wifi-connectioninfo 2>/dev/null | grep "rssi" | awk '{print $2}' | sed 's/,//' || echo "0")

    # DYNAMIC BOX BORDERS
    TOP_LINE="┌$(printf '%.0s─' $(seq 1 $((T_COLS - 2))))┐"
    MID_LINE="├$(printf '%.0s─' $(seq 1 $((T_COLS - 2))))┤"
    BOT_LINE="└$(printf '%.0s─' $(seq 1 $((T_COLS - 2))))┘"

    clear
    echo -e "${CYAN}${TOP_LINE}"
    center "██╗     ██╗   ██╗██████╗  █████╗ "
    center "██║     ╚██╗ ██╔╝██╔══██╗██╔══██╗"
    center "██║      ╚████╔╝ ██████╔╝███████║"
    center "██║       ╚██╔╝  ██╔══██╗██╔══██║"
    center "███████╗   ██║   ██║  ██║██║  ██║"
    echo -e "${RED}"
    center "[ ARASAKA INTEL NET ]"
    echo -e "${CYAN}${MID_LINE}${RESET}"
    
    echo ""
    printf "  ${YELLOW}%-24s${RESET} ${RED}%-24s${RESET} ${GREEN}%-24s${RESET}\n" "0) [REBOOT]" "13) [STLTH]" "14) [UPD]"
    echo -e "\n  ${DIM}-----------------------  -----------------------  -----------------------${RESET}\n"
    
    printf "  %-24s %-24s %-24s\n" "1) [MSF] Metasploit" "5) [RNG] Ranger" "9) [HYD] Hydra"
    printf "  %-24s %-24s %-24s\n" "2) [BTP] Btop" "6) [LYR] Diagnostic" "10) [GIT] Git"
    printf "  %-24s %-24s %-24s\n" "3) [JHN] John" "7) [SQL] SQLmap" "11) [AIR] Aircrack"
