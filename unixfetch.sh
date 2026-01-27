#!/bin/bash
#
## Made by: sky
## Github: https://github.com/YetAnotherSky
## Codeberg: https://codeberg.org/YetAnotherSky

set -euo pipefail

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
VIOLET=$(tput setaf 13)
LIME=$(tput setaf 14)
RESET=$(tput sgr0)
DISTRIBUTION=$(cat /etc/os-release | grep -i PRETTY_NAME | cut -d '=' -f2 | tr -d '"')
KERNEL_VERSION=$(uname -r)
KERNEL=$(uname -s)
OS=$(uname -o)
BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
BATTERY_MODEL=$(cat /sys/class/power_supply/BAT0/model_name)
ARCHITECTURE=$(uname -m)
PROC_NUMBERS=$(nproc)
CPU=$(cat /proc/cpuinfo | grep -i "model name" | head -n  1 | cut -d ':' -f2)
SH=$(echo $SHELL)
UPTIME=$(uptime -p | cut -d 'p' -f2)
ACTUAL_BRIGHTNESS=$(cat /sys/class/backlight/*_backlight/actual_brightness)
BRIGHTNESS=$(cat /sys/class/backlight/*_backlight/max_brightness)
CURRENT_BRIGHTNESS=$(awk "BEGIN { printf(\"%.1f\", $ACTUAL_BRIGHTNESS / $BRIGHTNESS * 100) }" | cut -d '.' -f1)
USED_MEMORY=$(free -h | awk 'NR==2 {print $3}')
USED_MEM_VALUE=$(free -h | awk 'NR==2 {print $3}'| tr -d 'Gi')
TOTAL_MEM_VALUE=$(free -h | awk 'NR==2 {print $2}' | tr -d 'Gi')
TOTAL_MEMORY=$(free -h | awk 'NR==2 {print $2}')
AVG_MEMORY=$(awk "BEGIN { printf(\"%.1f\", $USED_MEM_VALUE / $TOTAL_MEM_VALUE * 100)}" | cut -d '.' -f1)
CURRENT_SWAP=$(free -h | awk 'NR==3 {print $3}')
SWAP=$(free -h | awk 'NR==3 {print $2}')
AVG_SWAP=$(awk "BEGIN {printf(\"%.1f\", $CURRENT_SWAP / $SWAP * 100)}" | cut -d '.' -f1)
DISK=$(df -h / | awk 'NR==2 {print $2}')
USED_DISK=$(df -h / | awk 'NR==2 {print $3}')
AVG_DISK=$(df -h / | awk 'NR==2 {print $5}')
CMP_DISK=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
SHELL_TYPE=$(basename $SHELL)
LOCAL_IP=$(ip route | awk 'NR==2 {print $9}')
PROTOCOL=$(ip route | awk 'NR==2 {print $3}')
DATE=$(date | cut -d '+' -f1)
INIT_SYSTEM=$(ps -p 1 -o comm=)
EDITOR=$(echo $EDITOR | cut -d '/' -f4)
PROCESSES=$(ps aux | wc -l)

pkg_count(){
  local pkg_manager="$1"
  local cmd_count="$2"

  if ! command -v "$pkg_manager" &>/dev/null; then
    return
  fi
  if output=$($cmd_count 2>&1); then
      count=$(echo "$output" | wc -l)
      printf "%s " "$count" "($pkg_manager)"
  fi
}

sys_info() {

  echo "$BLUE* OS:$RESET $DISTRIBUTION $ARCHITECTURE $OS"
  echo "$BLUE* Shell:$RESET $SHELL_TYPE"
  echo "$BLUE* Kernel:$RESET $KERNEL $KERNEL_VERSION"
  echo "$BLUE* Desktop:$RESET $DESKTOP_SESSION ($XDG_SESSION_TYPE)"
  echo "$BLUE* Uptime:$RESET $UPTIME"
  
  printf "%s" "$BLUE* Packages: $RESET"
  pkg_count "dpkg" "dpkg -l"
  pkg_count "rpm" "dnf list --installed"
  pkg_count "pacman" "pacman -Q"
  pkg_count "pkg" "pkg info"
  pkg_count "zypp" "zypper se --installed-only"
  pkg_count "emerge" "qlist -I"
  pkg_count "apk" "apk info"
  pkg_count "flatpak" "flatpak list"
  pkg_count "snap" "snap list"
  pkg_count "brew" "brew list"
  echo ""
  echo "$BLUE* Date:$RESET $DATE"
  echo "$BLUE* Terminal:$RESET $TERM"
  echo "$BLUE* Init System:$RESET $INIT_SYSTEM"
  
  if [ -z  $EDITOR ]; then
    return
  else
    echo "$BLUE* Editor:$RESET $EDITOR"
  fi

  if [ $CURRENT_BRIGHTNESS -gt 40 ]; then
    echo "$BLUE* Brightness:$RESET $GREEN$CURRENT_BRIGHTNESS%$RESET"
  elif [ $CURRENT_BRIGHTNESS -le 20 ]; then
    echo "$BLUE* Brightness:$RESET $RED$CURRENT_BRIGHTNESS%$RESET"
  else
    echo "$BLUE* Brightness:$RESET $YELLOW$CURRENT_BRIGHTNESS%$RESET"
  fi

  if [ $BATTERY -le 20 ]; then
    echo "$BLUE* Battery ($BATTERY_MODEL):$RESET $RED$BATTERY%$RESET [$RED$BATTERY_STATUS$RESET]"
  elif [ $BATTERY -gt 50 ]; then
    echo "$BLUE* Battery ($BATTERY_MODEL):$RESET $GREEN$BATTERY%$RESET [$GREEN$BATTERY_STATUS$RESET]"
  else
    echo "$BLUE* Battery ($BATTERY_MODEL):$RESET $YELLOW$BATTERY%$RESET [$YELLOW$BATTERY_STATUS$RESET]"
  fi

  echo "$BLUE* CPU:$RESET $CPU ($PROC_NUMBERS)"
  echo "$BLUE* Processes:$RESET $PROCESSES"

  if [ $AVG_MEMORY -ge  75 ]; then
    echo "$BLUE* Memory:$RESET $USED_MEMORY / $TOTAL_MEMORY ($RED$AVG_MEMORY%$RESET)"
  elif [ $AVG_MEMORY -ge 55 ]; then
    echo "$BLUE* Memory:$RESET $USED_MEMORY / $TOTAL_MEMORY ($YELLOW$AVG_MEMORY%$RESET)"
  else
    echo "$BLUE* Memory:$RESET $USED_MEMORY / $TOTAL_MEMORY ($GREEN$AVG_MEMORY%$RESET)"
  fi
 
  if [ $AVG_SWAP -ge 75 ]; then
    echo "$BLUE* Swap:$RESET $CURRENT_SWAP / $SWAP ($RED$AVG_SWAP%$RESET)"
  elif [ $AVG_SWAP -ge 55 ]; then
    echo "$BLUE* Swap:$RESET $CURRENT_SWAP / $SWAP ($YELLOW$AVG_SWAP%$RESET)"
  else
    echo "$BLUE* Swap:$RESET $CURRENT_SWAP / $SWAP ($GREEN$AVG_SWAP%$RESET)"
  fi

  if [ $CMP_DISK -ge 75 ]; then
    echo "$BLUE* Disk:$RESET $USED_DISK / $DISK ($RED$AVG_DISK$RESET)"
  elif [ $CMP_DISK -ge 55 ]; then
    echo "$BLUE* Disk:$RESET $USED_DISK / $DISK ($YELLOW$AVG_DISK$RESET)"
  else
    echo "$BLUE* Disk:$RESET $USED_DISK / $DISK ($GREEN$AVG_DISK$RESET)"
  fi

  echo "$BLUE* Local IP ($PROTOCOL):$RESET $LOCAL_IP"
  echo "$BLUE* Locale:$RESET $LANG"
}

# Calling sys_info and appending a pipe on each output
cat <<-EOF
  -- $USER@$(hostname) --
+
$(sys_info | sed 's/^/| /')
+
EOF

