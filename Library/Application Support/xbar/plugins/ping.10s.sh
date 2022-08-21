#!/bin/bash

MS=$(ping -c1 1.1.1.1 | perl -ne '/time=([\d\.]+) ms/ && printf "%.0f\n", $1')
echo "${MS}ms"
