#!/bin/bash

RESET_STYLE="\033[0m"
RED_COLOR="\033[0;31m"
GREEN_COLOR="\033[0;32m"
RED_BACKGROUND="\033[0;41m"
GREEN_BACKGROUND="\033[0;42m"

echo ""
echo "##############################"
echo "     check port available     "
echo "##############################"
echo ""

inputPort=$1

if [ -z "$inputPort" ]; then
  echo -e "${RED_BACKGROUND} ERROR ${RESET_STYLE}"
  echo -e "${RED_COLOR}Please pass the port you want to check.${RESET_STYLE}"
  echo -e "${RED_COLOR}Usage: ./checkPortAvailable [port]${RESET_STYLE}"
  echo ""
  exit 1
fi

ports=$(ss -tulpn | grep LISTEN | awk '{ print $5 }' | awk -F: '{ print $NF }' | sort -n | uniq)

for port in $ports; do
  if [ "$inputPort" = "$port" ]; then
    echo -e "${RED_BACKGROUND} FAILED ${RESET_STYLE}"
    echo -e "${RED_COLOR}This port $inputPort is currently in use!${RESET_STYLE}"
    echo ""
    exit 1
  fi
done

echo -e "${GREEN_BACKGROUND} OK! ${RESET_STYLE}"
echo -e "${GREEN_COLOR}This port $inputPort is available!${RESET_STYLE}"
echo ""
