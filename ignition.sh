#!/bin/bash
tput civis
trap "tput cnorm; clear; exit" SIGINT SIGTERM
CYAN="\033[1;36m"; RED="\033[1;31m"; YELLOW="\033[1;33m"; GREEN="\033[1;32m"; RESET="\033[0m"
center() { local text="$1"; local width=$(tput cols); local raw=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g'); local pad=$(( (width - ${#raw}) / 2 )); [ $pad -lt 0 ] && pad=0; printf "%${pad}s%b\n" "" "$text"; }
run_tool() { tput cnorm; local cmd=$1; local pkg=$2; shift 2; if ! command -v $cmd &> /dev/null; then pkg install $pkg -y > /dev/null 2>&1; fi; $cmd "$@"; sleep 2; tput civis; }
while true; do
T_COLS=$(tput cols); IP=$(ifconfig wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}' | head -n 1 || echo "OFFLINE")
BATT=$(termux-battery-status 2>/dev/null | grep "percentage" | awk '{print $2}' | sed 's/,//')
clear; echo -e "${CYAN}┌$(printf '%.0s─' $(seq 1 $((T_COLS - 2))))┐"
center "██╗     ██╗   ██╗██████╗  █████╗ "; center "██║     ╚██╗ ██╔╝██╔══██╗██╔══██╗"
center "██║      ╚████╔╝ ██████╔╝███████║"; center "██║       ╚██╔╝  ██╔══██╗██╔══██║"
center "███████╗   ██║   ██║  ██║██║  ██║"; echo -e "${RED}"; center "[ ARASAKA INTEL NET ]"
echo -e "${CYAN}├$(printf '%.0s─' $(seq 1 $((T_COLS - 2))))┤${RESET}"
printf "  ${YELLOW}%-20s${RESET} ${RED}%-20s${RESET} ${GREEN}%-20s${RESET}\n" "0) [REBOOT]" "13) [STLTH]" "14) [UPD]"
printf "  %-20s %-20s %-20s\n" "1) [MSF] Meta" "5) [RNG] Rang" "9) [HYD] Hydr" "2) [BTP] Btop" "6) [LYR] Diag" "10) [GIT] Git" "3) [JHN] John" "7) [SQL] SQLm" "11) [AIR] Air" "4) [NMP] Nmap" "8) [BET] Bett" "12) [GHT] Ghst"
echo -e "\n${CYAN}├$(printf '%.0s─' $(seq 1 $((T_COLS - 2))))┤\n  NODE: $IP | PWR: ${BATT}%\n└$(printf '%.0s─' $(seq 1 $((T_COLS - 2))))┘${RESET}"
read -p "  ACCESS CODE: " choice
input=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
case $input in
0|reboot) tput cnorm; exec bash ~/scripts/ignition.sh ;;
1|msf) run_tool "msfconsole" "metasploit" ;;
2|btp) run_tool "btop" "btop" ;;
3|john) run_tool "john" "john" ;;
4|nmap) run_tool "nmap" "nmap" "-v" ;;
5|ranger) run_tool "ranger" "ranger" ;;
6|lyra) echo "System Nominal."; sleep 2 ;;
7|sqlmap) run_tool "sqlmap" "sqlmap" ;;
8|bettercap) run_tool "bettercap" "bettercap" ;;
9|hydra) run_tool "hydra" "hydra" ;;
10|git) run_tool "git" "git" ;;
11|aircrack) run_tool "aircrack-ng" "aircrack-ng" ;;
12|ghost) history -c && rm -rf ~/.bash_history; sleep 1 ;;
13|stealth) CYAN="${RED}"; sleep 1 ;;
14|update) tput cnorm; pkg update && pkg upgrade -y ;;
exit|quit) tput cnorm; clear; exit ;;
*) $input ;;
esac
done
