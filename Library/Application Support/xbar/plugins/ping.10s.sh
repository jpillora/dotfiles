#!/bin/bash
# <xbar.title>CF Ping</xbar.title>
# <xbar.version>v1.0</xbar.version>
MS=$(ping -c1 1.1.1.1 | perl -ne '/time=([\d\.]+) ms/ && printf "%.0f\n", $1')
# if MS is blank
if [ -z "$MS" ]; then
  echo "Offline | color=red"
elif [ $MS -lt 100 ]; then
  echo "${MS}ms | color=#88FF33"
else
  echo "${MS}ms | color=orange"
fi
