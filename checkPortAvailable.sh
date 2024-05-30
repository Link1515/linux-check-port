#!/bin/bash

RESET_STYLE="\033[0m"
RED_COLOR="\033[0;31m"
GREEN_COLOR="\033[0;32m"
YELLOW_COLOR="\033[0;33m"
RED_BACKGROUND="\033[0;41m"
GREEN_BACKGROUND="\033[0;42m"
YELLOW_BACKGROUND="\033[0;43m"

echo ""

inputPort=$1

if [[ -z "$inputPort" ]]; then
  echo -e "${RED_BACKGROUND} ERROR ${RESET_STYLE}"
  echo -e "${RED_COLOR}Please pass the port you want to check.${RESET_STYLE}"
  echo -e "${RED_COLOR}Usage: ./checkPortAvailable.sh [port]${RESET_STYLE}"
  echo ""
  exit 1
fi

if [[ ! $inputPort =~ ^[0-9]+$ ]]; then
  echo -e "${RED_BACKGROUND} ERROR ${RESET_STYLE}"
  echo -e "${RED_COLOR}Port must be a number.${RESET_STYLE}"
  echo ""
  exit 1
fi

if (($inputPort > 65535 || $inputPort < 0)); then
  echo -e "${RED_BACKGROUND} ERROR ${RESET_STYLE}"
  echo -e "${RED_COLOR}Port must between 0 and 65535.${RESET_STYLE}"
  echo ""
  exit 1
fi

if (($inputPort < 1024 && $inputPort >= 0)); then
  echo -e "${YELLOW_BACKGROUND} WARNING ${RESET_STYLE}"
  echo -e "${YELLOW_COLOR}Port 0~1023 is usually reserved for system use.${RESET_STYLE}"
  echo ""
fi

ports=$(ss -tulpn | grep LISTEN | awk '{ print $5 }' | awk -F: '{ print $NF }' | sort -n | uniq)

for port in $ports; do
  if [ "$inputPort" = "$port" ]; then
    echo -e "${RED_BACKGROUND} ERROR ${RESET_STYLE}"
    echo -e "${RED_COLOR}Port $inputPort is currently in use!${RESET_STYLE}"
    echo ""
    exit 1
  fi
done

echo -e "${GREEN_BACKGROUND} OK! ${RESET_STYLE}"
echo -e "${GREEN_COLOR}Port $inputPort is available!${RESET_STYLE}"
echo ""
