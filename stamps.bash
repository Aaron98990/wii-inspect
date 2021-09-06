#!/bin/bash                                                       

if [[ ! -d 00010000525a5445 ]]; then
	echo "Running tachtig. Make sure tachtig executable is in your path."
	tachtig data.bin
fi

if [ "$1" == "" ]; then
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

twos() { x=$((16#$1)); [ "$x" -gt 32767 ] && ((x=x-65536)); printf "%+d " $x; }
OneDate() {
printf "%s:\t" "$1" 
x=`doc $2`
name_dec_pos=$((x+44))
hiOrRec=$((x+828))
new=$((x+832))
old=$((x+840))
min=${hex:x:8}
x=$((x-16))
y=$((x+28))
if [ "${hex:x:8}" == "55705363" ] && [ "${hex:hiOrRec:4}" == "0000" ]; then
#readable="UpSc"
readable="Wii Record            "
elif [ "${hex:x:8}" == "55705363" ] && [ "${hex:hiOrRec:4}" == "0001" ]; then
#readable="UpSc"
readable="Personal Record       "
elif [ "${hex:x:8}" == "47556e69" ]; then
#readable="GUni"
readable="Stamp                 "
elif [ "${hex:x:8}" == "4d646c45" ] ; then
#readable="Mdle"
readable="Pro or Superstar Class"
elif [ "${hex:x:8}" == "506c6179" ]; then
readable="Last Sport Played     "
else
readable=${hex:x:8}
fi
if [ "${hex:y:4}" == "0001" ]; then
sportin="Power Cruising"
elif [ "${hex:y:4}" == "0000" ]; then
sportin="Swordplay"
elif [ "${hex:y:4}" == "0002" ]; then
sportin="Archery"
elif [ "${hex:y:4}" == "0003" ]; then
sportin="???"
elif [ "${hex:y:4}" == "0004" ]; then
sportin="Basketball"
elif [ "${hex:y:4}" == "0005" ]; then
	sportin="Bowling"
elif [ "${hex:y:4}" == "0006" ]; then
sportin="Canoeing"
elif [ "${hex:y:4}" == "0007" ]; then
sportin="Table Tennis"
elif [ "${hex:y:4}" == "0008" ]; then
sportin="Wakeboarding"
elif [ "${hex:y:4}" == "0009" ]; then
sportin="???"
elif [ "${hex:y:4}" == "000a" ]; then
sportin="Golf"
elif [ "${hex:y:4}" == "000b" ]; then
sportin="Frisbee Golf"
elif [ "${hex:y:4}" == "000c" ]; then
sportin="Cycling"
elif [ "${hex:y:4}" == "000d" ]; then
	sportin="Air Sports"
elif [ "${hex:y:4}" == "000e" ]; then
sportin="???"
elif [ "${hex:y:4}" == "000f" ]; then
sportin="???"
fi

printf "%s %s " `hexToDate $min`  "$readable" `hexToAscii ${hex:name_dec_pos:20}` ${hex:y:28} $sportin
if [ "${hex:x:8}" == "55705363" ] && [ "${hex:y:4}" == "000a" ]; then
# Trying to show negative numbers for Golf
twos ${hex:new:8}
twos ${hex:old:8}
elif [ "${hex:x:8}" == "55705363" ] && [ "${hex:y:4}" == "000b" ]; then
twos ${hex:new:8} 
twos ${hex:old:8}
elif [ "${hex:x:8}" == "55705363" ]; then
printf "%d %s %d" `hexToDec ${hex:new:8}` "<-" `hexToDec ${hex:old:8}`
fi
if [ "${hex:x:8}" == "4d646c45" ]; then
printf "%s %s %s" ${hex:new:4} "<-" ${hex:old:4}
fi
echo
}
TimesPlayed() {
printf "%s:\t" "$1" 
x=`doc $2`
min=${hex:$x:2}
echo `hexToDec $min`
}
sport() {
printf "%s:\t" "$1" 
x=`doc $2`
min=${hex:x:8}
if [ "$min" != "00000000" ]; then
countStamps=$((countStamps+1))
fi
printf "%s %s  " `hexToDate $min`
x=$((x+8))
min=${hex:x:8}
if [ "$min" != "00000000" ]; then
countStamps=$((countStamps+1))
fi
printf "%s %s  " `hexToDate $min`
x=$((x+8))
min=${hex:x:8}
if [ "$min" != "00000000" ]; then
countStamps=$((countStamps+1))
fi
printf "%s %s  " `hexToDate $min`
x=$((x+8))
min=${hex:x:8}
if [ "$min" != "00000000" ]; then
countStamps=$((countStamps+1))
fi
printf "%s %s  " `hexToDate $min`
x=$((x+8))
min=${hex:x:8}
if [ "$min" != "00000000" ]; then
countStamps=$((countStamps+1))
fi
printf "%s %s  " `hexToDate $min`
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

z=`doc 82c0`
echo `hexToAscii ${hex:z:30}`
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
echo $countStamps "/100" "Stamps total for above"
countStamps=0
echo
z=`doc 90b6`
echo `hexToAscii ${hex:z:30}`
sport "Showdown           " "9af4"
sport "Swordplay Duel     " "9b08"
sport "Speed Slice        " "9b1c"
sport "Power Crusing      " "9b30"
sport "Archery            " "9b58"
sport "Frisbee Dog        " "9b6c"
sport "3 Point Contest    " "9b80"
sport "Pickup Basketball  " "9b94"
sport "Standard Bowling   " "9ba8"
sport "100 Pin Bowling    " "9bbc"
sport "Spin Control       " "9bd0"
sport "Frisbee Golf       " "9bf8"
sport "Return Table Tennis" "9c0c"
sport "Table Tennis Match " "9c20"
sport "Wakeboarding       " "9c34"
sport "Island Flyover     " "9c48"
sport "Golf               " "9c70"
sport "Canoeing           " "9c84"
sport "Cycling            " "9cac"
sport "Skydiving          " "9cc0"

echo $countStamps "/100" "Stamps for above player"
countStamps=0
echo
z=`doc 9ea8`
echo `hexToAscii ${hex:z:30}`
sport "Showdown           " "a8d8"
sport "Swordplay Duel     " "a8e3"
sport "Speed Slice        " "a8fc"
sport "Power Crusing      " "a910"
sport "Archery            " "a938"
sport "Frisbee Dog        " "a94c"
sport "3 Point Contest    " "a960"
sport "Pickup Basketball  " "a974"
sport "Standard Bowling   " "a988"
sport "100 Pin Bowling    " "a99c"
sport "Spin Control       " "a9b0"
sport "Frisbee Golf       " "a9d8"
sport "Return Table Tennis" "a9ec"
sport "Table Tennis Match " "aa00"
sport "Wakeboarding       " "aa14"
sport "Island Flyover     " "aa28"
sport "Golf               " "aa50"
sport "Canoeing           " "aa64"
sport "Cycling            " "aa8c"
sport "Skydiving          " "aaa0"

echo $countStamps "This is countStamps Total"
countStamps=0
echo
# For more players, get the last player and add 0xDE4 to all values.

# 25 Records of Recent history
echo "25 Recent Plays - Instead of clicking A & B to start game, just wait to see the plays or use the + or - button the Wiimote."
OneDate "Skydiving          " "4e24"
OneDate "Skydiving          " "4e34"
OneDate "Skydiving          " "4ffc"
OneDate "Skydiving          " "51c4"
OneDate "Skydiving          " "538c"
OneDate "Skydiving          " "5554"
OneDate "Skydiving          " "571c"
OneDate "Skydiving          " "58e4"
OneDate "Skydiving          " "5aac"
OneDate "Skydiving          " "5c74"
OneDate "Skydiving          " "5e3c"
OneDate "Skydiving          " "6004"
OneDate "Skydiving          " "61cc"
OneDate "Skydiving          " "6394"
OneDate "Skydiving          " "655c"
OneDate "Skydiving          " "6724"
OneDate "Skydiving          " "68ec"
OneDate "Skydiving          " "6ab4"
OneDate "Skydiving          " "6c7c"
OneDate "Skydiving          " "6e44"
OneDate "Skydiving          " "700c"
OneDate "Skydiving          " "71d4"
OneDate "Skydiving          " "739c"
OneDate "Skydiving          " "7564"
OneDate "Skydiving          " "772c"
OneDate "Skydiving          " "78f4"


echo "Game Plays. Restarting or quitting does not count."
TimesPlayed "Dsadsa                    " "4d73"
TimesPlayed "Dsadsa                    " "4d77"
TimesPlayed "Dsadsa                    " "4d7b"
TimesPlayed "Standard Bowling          " "4d7f"
TimesPlayed "Dsadsa                    " "4d83"
TimesPlayed "Dsadsa                    " "4d87"
TimesPlayed "Dsadsa                    " "4d8b"
TimesPlayed "Dsadsa                    " "4d8f"
TimesPlayed "Dsadsa                    " "4d93"
TimesPlayed "Dsadsa                    " "4d97"
TimesPlayed "Dsadsa                    " "4d9b"
TimesPlayed "Dsadsa                    " "4d9f"
TimesPlayed "Dsadsa                    " "4da3"
TimesPlayed "Dsadsa                    " "4da7"
TimesPlayed "Dsadsa                    " "4dab"
TimesPlayed "Dsadsa                    " "4daf"
TimesPlayed "Cycling                   " "4db3"
TimesPlayed "Skydiving                 " "4db7"
TimesPlayed "Dsadsa                    " "4dbb"
TimesPlayed "Dsadsa                    " "4dbf"
TimesPlayed "Dsadsa                    " "4dc3"
TimesPlayed "Dsadsa                    " "4dc7"
TimesPlayed "Dsadsa                    " "4dcb"
TimesPlayed "Dsadsa                    " "4dcf"
TimesPlayed "Archery                   " "4dd3"
TimesPlayed "Dsadsa                    " "4dd7"
TimesPlayed "3 Point Contest           " "4ddb"
TimesPlayed "Dsadsa                    " "4ddf"
TimesPlayed "Dsadsa                    " "4de3"
TimesPlayed "Dsadsa                    " "4de7"
TimesPlayed "Dsadsa                    " "4deb"
TimesPlayed "Dsadsa                    " "4def"
TimesPlayed "Dsadsa                    " "4df3"
TimesPlayed "Swordplay-Duel?           " "4df7"
TimesPlayed "Dsadsa                    " "4dfb"
TimesPlayed "Golf                      " "4dff"
TimesPlayed "Island Flyover            " "4e03"
TimesPlayed "Dsadsa                    " "4e07"
TimesPlayed "Swordplay-Duel?           " "4e0b"
TimesPlayed "Dsadsa                    " "4e0f"
