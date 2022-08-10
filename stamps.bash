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
	echo bash stamps.bash FILE
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
echo -e "${RED}Wii ${BLUE}Sports ${PURPLE}Resort ${GREEN}Stamps${SET}"

doc() { x=$((16#$1)); printf "%d" $(($x*2));}
hexToDec() { x=$((16#$1)); printf "%d" $(($x));}
hexToBin() {
x=`toUpper $1`
BIN=$(echo "obase=2; ibase=16; $x" | bc )
echo $BIN
}
binToDec() {
BIN=$(echo "obase=10; ibase=2; $1" | bc )
echo $BIN
}
#twos compliment works on four digits only
twos() { x=$((16#$1)); [ "$x" -gt 32767 ] && ((x=x-65536)); printf "%+d " $x; }
secs() { printf "%d:%02d" $(($1/60)) $(($1%60));}
OneDate() {
x=`doc $1`
name_dec_pos=$((x+44))
hiOrRec=$((x+828))
new=$((x+832))
old=$((x+840))
min=${hex:x:8}
x=$((x-16))
y=$((x+28))
z=$((x+36))
a=$((x+44))
figureout=$((x+860))
if [ "${hex:x:8}" == "55705363" ] && [ "${hex:hiOrRec:4}" == "0000" ]; then
#readable="UpSc"
readable="Wii Record            "
elif [ "${hex:x:8}" == "55705363" ] && [ "${hex:hiOrRec:4}" == "0001" ]; then
#readable="UpSc"
readable="Personal Record       "
elif [ "${hex:x:8}" == "47556e69" ]; then
#readable="GUni"
readable="Stamp                 "
elif [ "${hex:x:8}" == "4d646c45" ] && [ "${hex:figureout:20}" == "00000000000300000001" ]; then
#readable="Mdle"
readable="All Pro Class         "
elif [ "${hex:x:8}" == "4d646c45" ] && [ "${hex:figureout:20}" == "00000000000400000000" ]; then
#readable="Mdle"
readable="Superstar Class       "
elif [ "${hex:x:8}" == "4d646c45" ] && [ "${hex:figureout:20}" == "00000000000400000001" ]; then
#readable="Mdle"
readable="All Superstar Class   "
elif [ "${hex:x:8}" == "4d646c45" ] ; then
#readable="Mdle"
readable="Pro Class             "
elif [ "${hex:x:8}" == "506c6179" ]; then
readable="Last Sport Played     "
else
readable=${hex:x:8}
fi
if [ "${hex:y:4}" == "0001" ] &&  [ "${hex:a:4}" == "0000" ]; then
sportin="Power Cruising - Beach"
elif [ "${hex:y:4}" == "0001" ]; then
sportin="Power Cruising"
elif [ "${hex:y:4}" == "0000" ]; then
sportin="Swordplay"
elif [ "${hex:y:4}" == "0002" ]; then
sportin="Archery"
elif [ "${hex:y:4}" == "0003" ]; then
sportin="Frisbee Dog"
elif [ "${hex:y:4}" == "0004" ] && [ "${hex:a:4}" == "0002" ]; then
	sportin="3 Point Contest"
elif [ "${hex:y:4}" == "0004" ]; then
sportin="Basketball"
elif [ "${hex:y:4}" == "0005" ] && [ "${hex:z:4}" == "0002" ]; then
	sportin="Standard Bowling"
elif [ "${hex:y:4}" == "0005" ] && [ "${hex:z:4}" == "0004" ]; then
	sportin="Spin Control Bowling"
elif [ "${hex:y:4}" == "0005" ]; then
	sportin="Bowling"
elif [ "${hex:y:4}" == "0006" ]; then
sportin="Canoeing"
elif [ "${hex:y:4}" == "0007" ]; then
sportin="Table Tennis"
elif [ "${hex:y:4}" == "0008" ] && [ "${hex:a:4}" == "0000" ]; then
sportin="Wakeboarding - Beginner"
elif [ "${hex:y:4}" == "0008" ]; then
sportin="Wakeboarding"
elif [ "${hex:y:4}" == "0009" ]; then
sportin="Island Flyover"
elif [ "${hex:y:4}" == "000a" ]; then
sportin="Golf"
elif [ "${hex:y:4}" == "000b" ]; then
sportin="Frisbee Golf"
elif [ "${hex:y:4}" == "000c" ]; then
sportin="Cycling"
elif [ "${hex:y:4}" == "000d" ] && [ "${hex:z:4}" == "0001" ]; then
	sportin="Skydiving"
elif [ "${hex:y:4}" == "000d" ]; then
	sportin="Air Sports"
elif [ "${hex:y:4}" == "000e" ]; then
sportin="000e Please look at your wii, identify the sport, and open an issue on GitHub."
elif [ "${hex:y:4}" == "000f" ]; then
sportin="000f Please look at your wii, identify the sport, and open an issue on GitHub."
fi

printf "%s %s %s " `hexToDate $min` " " "$readable" `hexToAscii ${hex:name_dec_pos:20}` $sportin
if [ "${hex:x:8}" == "55705363" ] && [ "${hex:y:4}" == "000a" ]; then
# Trying to show negative numbers for Golf
twos ${hex:((new+4)):4}
printf "<- "
twos ${hex:((old+4)):4}
elif [ "${hex:x:8}" == "55705363" ] && [ "${hex:y:4}" == "000b" ]; then
# Trying to show negative numbers for Frisbee/Golf
	twos ${hex:((new+4)):4} 
printf "<- "
twos ${hex:((old+4)):4}
elif [ "${hex:x:8}" == "55705363" ] && [ "${hex:y:4}" == "000c" ]; then
	#Cyling formatting the score
c1=${hex:((old+3)):5}
c1h=$((16${c1}))
c1s=${c1h:0:333}
c1ms=${c1h:3:2}
printf "%d %s.%02w" 0x${hex:((old+1)):2} `secs ${c1s}` ${c1ms}
	printf "<- "
c1=${hex:((new+3)):5}
c1h=$((16${c1}))
c1s=${c1h:0:333}
c1ms=${c1h:3:2}
printf "%d %s.%02w" 0x${hex:((new+1)):2} `secs ${c1s}` ${c1ms}
echo "untested: make an issue for cycling if scores do not make sense"
elif [ "${hex:x:8}" == "55705363" ]; then
printf "%d %s %d" `hexToDec ${hex:new:8}` "<-" `hexToDec ${hex:old:8}`
fi
echo
}
sport() {
printf "%s:\t" "$1" 
x=$((offset+`doc $2`))
	for i in 1 2 3 4 5
	do
min=${hex:x:8}
if [ "$min" != "00000000" ]; then
countStamps=$((countStamps+1))
fi
printf "%s %s  " `hexToDate $min`
x=$((x+8))
	done
echo
}
hexToAscii() { 
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
hexToDate() { #printf "%s:\n" $1; 
if [ "$1" == "00000000" ]; then
printf "==============="
else
x=`hexToBin $1`
min=${x:25:6}
hour=${x:20:5}
day=${x:15:5}
month=${x:11:4}
year=${x:0:11}
#echo `binToDec $min`
#echo `binToDec $hour`
#echo `binToDec $day`
#echo `binToDec $month`
#echo `binToDec $year`
m=$((`binToDec $month`+1))
printf "%02d/%02d/%04d %02d:%02d  " $m `binToDec $day` `binToDec $year` `binToDec $hour` `binToDec $min`
fi
}
toUpper() {
echo ${1^^}
}

offset=0
for i in {1..12}
do

	z=$((offset+`doc 82c0`))
	name=`hexToAscii ${hex:z:30}`
  if [ -z "$name" ]; then
		break
	fi  
echo -e "${RED}${name}${SET}"
sport "Showdown           " "8cec"
sport "Swordplay Duel     " "8d00"
sport "Speed Slice        " "8d14"
sport "Power Crusing      " "8d28"
sport "Archery            " "8d50"
sport "Frisbee Dog        " "8d64"
sport "3 Point Contest    " "8d78"
sport "Pickup Basketball  " "8d8c"
sport "Standard Bowling   " "8d9c"
sport "100 Pin Bowling    " "8db4"
sport "Spin Control       " "8dc8"
sport "Frisbee Golf       " "8df0"
sport "Return Table Tennis" "8e04"
sport "Table Tennis Match " "8e18"
sport "Wakeboarding       " "8e2c"
sport "Island Flyover     " "8e40"
sport "Golf               " "8e68"
sport "Canoeing           " "8e7c"
sport "Cycling            " "8ea4"
sport "Skydiving          " "8eb8"
#Code by Aaron Feleke
echo $countStamps "/100" "Stamps total for above player"
countStamps=0


#echo
#echo -e "${GREEN}Recent Skill Levels${SET} - In beta. Report errors using GitHub Issues on Aaron98990/wii-inspect"
#x=`doc 8649`
#x=$((x+offset))
#printf "3 Point Contest: "
#	for i in {1..15}
#	do		
#printf "%s " ${hex:x:3}
#		x=$((x+6))
#done



#	printf "Count Sbowl %s Skydive %s BB 3 Con %s Island Fly %s" ${hex:$((offset+`doc 4d7e`)):4} ${hex:$((offset+`doc 4db6`)):4} ${hex:$((offset+`doc 4dda`)):4} ${hex:$((offset+`doc 4e02`)):4}


interval=`doc df4`
offset=$((offset+interval))
echo
done
# For more players, get the last player and add 0xDE4 to all values.

# 25 Records of Recent history
echo -e "${GREEN}25 Recent Plays${SET} - Instead of clicking A & B to start game, just wait to see the plays or use the + or - button the Wiimote."
OneDate "4e34"
OneDate "4ffc"
OneDate "51c4"
OneDate "538c"
OneDate "5554"
OneDate "571c"
OneDate "58e4"
OneDate "5aac"
OneDate "5c74"
OneDate "5e3c"
OneDate "6004"
OneDate "61cc"
OneDate "6394"
OneDate "655c"
OneDate "6724"
OneDate "68ec"
OneDate "6ab4"
OneDate "6c7c"
OneDate "6e44"
OneDate "700c"
OneDate "71d4"
OneDate "739c"
OneDate "7564"
OneDate "772c"
OneDate "78f4"



