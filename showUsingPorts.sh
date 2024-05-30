#!/bin/bash

ports=$(ss -tulpn | grep LISTEN | awk '{ print $5 }' | awk -F: '{ print $NF }' | sort -n | uniq)

echo -e ""
echo "#######################"
echo "      Using ports     "
echo "#######################"

for port in $ports; do
  echo $port
done

echo -e ""
