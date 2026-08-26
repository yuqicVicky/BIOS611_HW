#!/bin/bash

for cmd in man ls find
do
  lines=$(man "$cmd" | wc -l)
  echo "$cmd,$lines"
done | sort -t, -k2 -g -r
