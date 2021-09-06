
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
echo -e "${RED}Wii ${BLUE}Sports ${PURPLE}Resort ${GREEN}Times Played${SET}"

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
TimesPlayed() {
printf "%s:\t" "$1" 
x=`doc $2`
min=${hex:$x:2}
echo `hexToDec $min`
}
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
