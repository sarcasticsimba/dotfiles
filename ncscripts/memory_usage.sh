ps xmo rss=,pmem=,comm= | while read rss pmem comm; ((n++<5)); do

    size="$[rss/1024]";
    short=$[4-${#size}];
    size="(${size}M)";
    i=0;
    while ((i++ < short)); do size=" $size"; done;

    int=$pmem
    int="${int%%.*}"
    if   (($int >= 20)); then color=$'\e[31m';
    elif (($int >= 10)); then color=$'\e[33m';
    else                      color=$'\e[32m';
    fi;

    echo "$color$pmem% $size $(basename "$comm")"$'\e[0m'"";
done
