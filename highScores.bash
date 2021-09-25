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

echo -e "${GREEN}Wii Records${SET}"
twos() { x=$((16#$1)); [ "$x" -gt 32767 ] && ((x=x-65536)); printf "%+d " $x; }
secs() { printf "%d:%02d" $(($1/60)) $(($1%60));}
toDec() { printf "%d.%01d" $((16#$1/$2)) $((16#$1%$2));}
toDec2() { printf "%d.%02d" $((16#$1/$2)) $((16#$1%$2));}
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
hexToAscii2() { 
	input=$1
	x=""
	for i in 2 6 10 14 18 22 26 30 34
	do
		if [ "${input:$i:2}" == "20" ]; then
	x+=" "
		elif [ "${input:$i:2}" == "00" ]; then
			x+=" "
		else
	x+=$(echo ${input:$i:2} | xxd -r -p)
		fi
done
	echo $x
}

# Missing about 5 positions for most high scores
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
printf 'Canoeing: %s %s %s\n' `toDec2 ${hex:21020:4} 100` `toDec2 ${hex:21028:4} 100` `toDec2 ${hex:21032:4} 100`
printf 'Return Ping Pong: %d\n' 0x${hex:23084:4}
printf 'Wakeboarding: %d %d %d\n' 0x${hex:25148:4} 0x${hex:25156:4} 0x${hex:25164:4}
printf 'Golf: '
nn=29276
for bb in {1..10}
do
if [[ "${hex:$((nn-4)):1}" == "0" ]]; then
	printf "x "
else
twos ${hex:nn:4};
fi
nn=$((nn+8))
done
printf '\n'
printf 'Frisbee Golf: '
z=31340
for aa in {1..10}
do
if [[ "${hex:$((z-4)):1}" == "0" ]]; then
	printf "x "
else
twos ${hex:z:4};
fi
z=$((z+8))
done
printf '\n'
printf 'Cycling: '
ll=33403
for z in {1..9}
do
c1=${hex:ll:5}
c1h=$((16#${c1}))
#Code by Aaron Feleke
c1s=${c1h:0:3}
c1ms=${c1h:3:2}
if [[ "$z" == "7" ]]; then
printf '\nCycling (3a,3b,6): '
fi
if [ "${hex:$((ll-3)):1}" == "0" ]; then
printf "x, "
else
printf '%d %s.%02d, ' 0x${hex:$((ll-2)):2} `secs ${c1s}` ${c1ms} 
fi
ll=$((ll+8))
done
echo
printf 'Skydiving: %d\n' 0x${hex:35468:4}


echo
echo -e "${GREEN}Most Wii Records${SET}"
(IFS=$'\n'; sort <<< "${names[*]}") | uniq -c
echo

offset=0
echo -e "${GREEN}Personal Records${SET}"
for i in {1..12}
do
i=$((offset+`doc 82c0`))
name=`hexToAscii2 ${hex:i:30}`
if [ -z "$name" ]; then
break
fi
echo -e "${GREEN}`hexToAscii2 ${hex:i:30}`${SET}"
	i=$((`doc 8a6e`+offset))
printf 'Power Crusing: %s %s %s %s %s %s\n' `toDec ${hex:i:4} 10` `toDec ${hex:$((i+8)):4} 10` `toDec ${hex:$((i+16)):4} 10` `toDec ${hex:$((i+24)):4} 10` `toDec ${hex:$((i+32)):4} 10` `toDec ${hex:$((i+40)):4} 10`
i=$((`doc 8a96`+offset))
printf 'Archery: %d %d %d\n' 0x${hex:i:4} 0x${hex:$((i+8)):4} 0x${hex:$((i+16)):4}
i=$((`doc 8abe`+offset))
printf 'Frisbee Dog: %d\n' 0x${hex:i:4}
i=$((`doc 8ae6`+offset))
printf '3 Point Contest: %s\n' `toDec ${hex:i:4} 10`
printf 'Bowling: %d %d %d\n' 0x${hex:$((`doc 8b0e`+offset)):4} 0x${hex:$((`doc 8b36`+offset)):4} 0x${hex:$((`doc 8b5e`+offset)):4}  
i=$((`doc 8b86`+offset))
printf 'Canoeing: %s %s %s\n' `toDec2 ${hex:i:4} 100` `toDec2 ${hex:$((i+8)):4} 100` `toDec2 ${hex:$((i+16)):4} 100` 
printf 'Canoeing Target Distance: %s %s %s\n' `toDec2 ${hex:$((i+24)):4} 100` `toDec2 ${hex:$((i+32)):4} 100` `toDec2 ${hex:$((i+40)):4} 100`
printf 'Return Table Tennis: %d\n' 0x${hex:$((offset+`doc 8bae`)):4}
i=$((`doc 8bd6`+offset))
printf 'Wakeboarding: %d %d %d\n' 0x${hex:i:4} 0x${hex:$((i+8)):4} 0x${hex:$((i+16)):4}
printf 'Golf: '
nn=$((`doc 8c26`+offset))
for bb in {1..10}
do
if [[ "${hex:$((nn-4)):1}" == "0" ]]; then
	printf "x "
else
twos ${hex:nn:4};
fi
nn=$((nn+8))
done
printf '\n'
printf 'Frisbee Golf: '
z=$((`doc 8c4e`+offset))
for aa in {1..10}
do
if [[ "${hex:$((z-4)):1}" == "0" ]]; then
	printf "x "
else
twos ${hex:z:4};
fi
z=$((z+8))
done
printf '\n'
printf 'Cycling: '
ll=$((`doc 8c75`+offset))
ll=$((ll+1))
for z in {1..9}
do
c1=${hex:ll:5}
c1h=$((16#${c1}))
c1s=${c1h:0:3}
c1ms=${c1h:3:2}
if [[ "$z" == "7" ]]; then
printf '\nCycling (3a,3b,6): '
fi
if [ "${hex:$((ll-3)):1}" == "0" ]; then
printf "x, "
else
printf '%d %s.%02d, ' 0x${hex:$((ll-2)):2} `secs ${c1s}` ${c1ms} 
fi
ll=$((ll+8))
done
echo
i=$((`doc 8c9e`+offset))
printf 'Skydiving: %d\n' 0x${hex:i:4}
printf 'Island Flyover in 5 minutes (iPoints, Baloons): %d %d\n' 0x${hex:$((offset+`doc 8bfe`)):4} 0x${hex:$((offset+`doc 8c02`)):4}
interval=`doc df4`
offset=$((offset+interval))
echo
done
