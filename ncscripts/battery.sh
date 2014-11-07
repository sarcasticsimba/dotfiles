full=$(pmset -g batt | { read; read n full; echo "$full"; })
batt=$(echo "$full" | cut -d';' -f1 | tr -d '%')
status=$(echo "$full" | cut -d';' -f2 | tr -d ' ')
time=$(echo "$full" | cut -d';' -f3 | sed 's/^ *//')
noc=$'\e[39m'

if   (($batt >= 66)); then battc=$'\e[32m';
elif (($batt >= 33)); then battc=$'\e[33m';
else                       battc=$'\e[31m';
fi;

if [ "$status" == "discharging" ]; then
    statc=$'\e[31m';
elif [ "$status" == "charging" ]; then
    statc=$'\e[32m';
elif [ "$status" == "charged" ]; then
    statc=$'\e[32m';
else
    statc=$'\e[33m';
fi

echo "$battc$batt%$noc | $statc$status$noc | $time"
