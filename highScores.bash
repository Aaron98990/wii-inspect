#!/bin/bash                                                       

# Allow tactig ussage
mkdir -p ~/.wii
echo "ab01b9d8e1622b08afbad84dbfc2a55d" > ~/.wii/sd-key
echo "216712e6aa1f689f95c5a22324dc6a98" > ~/.wii/sd-iv
echo "0e65378199be4517ab06ec22451a5793" > ~/.wii/md5-blanker
xxd -r -p ~/.wii/sd-key ~/.wii/sd-key
xxd -r -p ~/.wii/sd-iv ~/.wii/sd-iv
xxd -r -p ~/.wii/md5-blanker ~/.wii/md5-blanker

# Exits program if first argument is empty
if [ -z "$1" ]; then
	echo bash highScores.bash FILE
	echo FILE should be: Sports2.dat OR data.bin
	exit 1
# Exits program if file does not exist.
elif [ ! -f "$1" ]; then
	    echo "$1: No such file"
	    exit 2
elif [ "${1: -3}" == "bin" ]; then
tachtig "$1"
hex=$(xxd -p -c 1000000 00010000525a5445/Sports2.dat)
else
hex=$(xxd -p -c 1000000 $1)
fi
# Colors
DARKGRAY='\033[1;30m'
RED='\033[0;31m'    
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'    
YELLOW='\033[1;33m'
BLUE='\033[0;34m'    
PURPLE='\033[0;35m'    
LIGHTPURPLE='\033[1;35m'
CYAN='\033[0;36m'    
WHITE='\033[1;37m'
SET='\033[0m'
echo -e "${RED}Wii ${BLUE}Sports ${PURPLE}Resort ${GREEN}Records${SET}"

twos() { x=$((16#$1)); [ "$x" -gt 32767 ] && ((x=x-65536)); printf "%+d " $x; }
secs() { printf "%d:%02d" $(($1/60)) $(($1%60));}
toDec() { printf "%d.%01d" $((16#$1/$2)) $((16#$1%$2));}
doc() { x=$((16#$1)); printf "%d" $(($x*2));}
hexToAscii() { 
	input=$1
	x=""
	x+=$(echo ${input:2:2} | xxd -r -p)
	x+=$(echo ${input:6:2} | xxd -r -p)
	x+=$(echo ${input:10:2} | xxd -r -p)
	x+=$(echo ${input:14:2} | xxd -r -p)
	x+=$(echo ${input:18:2} | xxd -r -p)
	x+=$(echo ${input:22:2} | xxd -r -p)
	x+=$(echo ${input:26:2} | xxd -r -p)
	x+=$(echo ${input:30:2} | xxd -r -p)
	x+=$(echo ${input:34:2} | xxd -r -p)
	names+=($x)
}
declare -a startOfNames=(`doc ffe` `doc 1014` `doc 102a` `doc 1040` `doc 1056` `doc 106c` `doc 1406` `doc 141c` `doc 1432` `doc 180e` `doc 1c16` `doc 201e` `doc 2426` `doc 282e` `doc 2c36` `doc 2c4c` `doc 2c62` `doc 303e` `doc 3446` `doc 345c` `doc 3472` `doc 3c40` `doc 3c56` `doc 3c6c` `doc 3c82` `doc 3c98` `doc 3cae` `doc 3cc4` `doc 3cda` `doc 3d1c` `doc 4048` `doc 408a` `doc 40b6` `doc 40cc` `doc 40e2` `doc 4124` `doc 4466` `doc 447c` `doc 4492` `doc 4492` `doc 44a8` `doc 44be` `doc 44ea` `doc 4500` `doc 4516` `doc 486e`)



names=()
# Read first five  characters in the name $1
for x in "${startOfNames[@]}"; do
	hexToAscii ${hex:${x}:20}
done

# printf(“\033[0;31m”); //Set the text to the color red
# printf(“Hello\n”); //Display Hello in red
# printf(“\033[0m”); //Resets the text to default color

# echo $((0x${hex:6572:4}))  
#doc cd6
printf 'Power Crusing: %s %s %s %s %s %s\n' `toDec ${hex:6572:4} 10` `toDec ${hex:6580:4} 10` `toDec ${hex:6588:4} 10` `toDec ${hex:6596:4} 10` `toDec ${hex:6604:4} 10` `toDec ${hex:6612:4} 10`
printf 'Archery: %d %d %d\n' 0x${hex:8636:4} 0x${hex:8644:4} 0x${hex:8652:4}
printf 'Frisbee Dog: %d\n' 0x${hex:10700:4}
printf '3 Point Contest: %s\n' `toDec ${hex:12764:4} 10`
printf 'Bowling: %d %d %d\n' 0x${hex:14828:4} 0x${hex:16892:4} 0x${hex:18956:4} 
printf 'Canoeing: %s %s %s\n' `toDec ${hex:21020:4} 100` `toDec ${hex:21028:4} 100` `toDec ${hex:21032:4} 100`
printf 'Return Ping Pong: %d\n' 0x${hex:23084:4}
printf 'Wakeboarding: %d %d %d\n' 0x${hex:25148:4} 0x${hex:25156:4} 0x${hex:25164:4}
printf 'Golf: '
twos ${hex:29276:4};
twos ${hex:29284:4};
twos ${hex:29292:4};
twos ${hex:29300:4};
twos ${hex:29308:4};
twos ${hex:29316:4};
twos ${hex:29324:4};
twos ${hex:29332:4};
twos ${hex:29340:4};
twos ${hex:29348:4};
printf '\n'
printf 'Frisbee Golf: '
twos ${hex:31340:4}
twos ${hex:31348:4}
twos ${hex:31356:4}
twos ${hex:31364:4}
twos ${hex:31372:4}
twos ${hex:31380:4}
twos ${hex:31388:4}
twos ${hex:31396:4}
twos ${hex:31404:4}
twos ${hex:31412:4}
printf '\n'
c1=${hex:33403:5}
c1h=$((16#${c1}))
c1s=${c1h:0:3}
c1ms=${c1h:3:2}
c2=${hex:33411:5}
c2h=$((16#${c2}))
c2s=${c2h:0:3}
c2ms=${c2h:3:2}
c3=${hex:33419:5}
c3h=$((16#${c3}))
c3s=${c3h:0:3}
c3ms=${c3h:3:2}
c4=${hex:33427:5}
c4h=$((16#${c4}))
c4s=${c4h:0:3}
c4ms=${c4h:3:2}
c5=${hex:33435:5}
c5h=$((16#${c5}))
c5s=${c5h:0:3}
c5ms=${c5h:3:2}
c6=${hex:33443:5}
c6h=$((16#${c6}))
c6s=${c6h:0:3}
c6ms=${c6h:3:2}
c7=${hex:33451:5}
c7h=$((16#${c7}))
c7s=${c7h:0:3}
c7ms=${c7h:3:2}
c8=${hex:33459:5}
c8h=$((16#${c8}))
c8s=${c8h:0:3}
c8ms=${c8h:3:2}
c9=${hex:33467:5}
c9h=$((16#${c9}))
c9s=${c9h:0:3}
c9ms=${c9h:3:2}
printf 'Cycling: %d %s.%02d, %d %s.%02d, %d %s.%02d, %d %s.%02d, %d %s.%02d, %d %s.%02d\n' 0x${hex:33401:2} `secs ${c1s}` ${c1ms} 0x${hex:33409:2} `secs ${c2s}` ${c2ms} 0x${hex:33417:2} `secs ${c3s}` ${c3ms} 0x${hex:33425:2} `secs ${c4s}` ${c4ms} 0x${hex:33433:2} `secs ${c5s}` ${c5ms} 0x${hex:33441:2} `secs ${c6s}` ${c6ms} 
printf 'Cycling (3a,3b,6): %d %s.%02d, %d %s.%02d, %d %s.%02d\n' 0x${hex:33449:2} `secs ${c7s}` ${c7ms} 0x${hex:33457:2} `secs ${c8s}` ${c8ms} 0x${hex:33465:2} `secs ${c9s}` ${c9ms} 
printf 'Skydiving: %d\n' 0x${hex:35468:4}
echo -e "${RED}Most ${BLUE}High ${PURPLE}Scores${SET}"
(IFS=$'\n'; sort <<< "${names[*]}") | uniq -c
