#!/bin/bash
P=335
I=1
C=1
B=`grep "<title type='html'>" ~/.cache/calendar.xml | grep -oP "(?<=<title type='html'>).*?(?=</title><summary)" | wc -l`
B2=$((B+0))
while [ $I -le $B2 ]
do
    R=`grep "<title type='html'>" ~/.cache/calendar.xml | grep -oP "(?<=<title type='html'>).*?(?=</title><summary)" | awk 'NR=='$I''`
    R2=`echo $R | cut -c -25`
    S=`grep "</summary><content" ~/.cache/calendar.xml | grep -oP "(?<=<content type='html'>).*?(?=$)" | awk 'NR=='$I'' | grep -oP "(?<=: ).*?(?=$)" | awk -F $(date +%Y) '{print $1 '$(date +%Y)'}'`
    M=${#R} 
    M2=$((M+0))
    if [ $M2 -gt 25 ]; then 
       R2=''$R2'...' 
    fi
    case "$S" in
       *$(date +%b)*)
         echo '${voffset -4}${color2}${goto 30}'$S''
         echo '${voffset -2}${color4}${goto 30}${image ~/.conky/conky-calendar/dot.png -p 10,'$P' -s 6x6}'$R2'${voffset 12}'
         P=`expr $P + 40`
         C=$(( $C + 1 ))
         if [ $C -gt 8 ]; then 
            break
         fi
       ;;
    esac
    I=$(( $I + 1 ))
done
