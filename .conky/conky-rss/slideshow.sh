#!/bin/bash
R=3
HOUR=`date +%H`
MINUTE=`date +%M`
TIME=`expr 60 \* $HOUR + $MINUTE`
files=(~/Pictures/*.*)
N=${#files[@]} 
file=${files[$TIME%$N]} 
echo '${image '$file' -p 3,3 -s 315x190}'
for I in {1..6}
   do
      file1=${files[$TIME%$N+$I]}
      echo '${image '$file1' -p '$R',199 -s 50x31}'
      R=`expr $R + 53`
   done






