declare -a COLORS
COLORS=("black:0" "red:1" "green:2" "yello:3" "blue:4" "magenta:5" "cyan:6" "grey:7" "lightgrey:7" "darkgrey:8" "salmon:9" "lime:10" "banana:11" "indigo:12" "pink:13" "aqua:14" "white:15")

function color() {
  NAME=$1
  for item in "${COLORS[@]}"
  do
    KEY=${item%%:*}
    VALUE=${item##*:}
    if [[ ${KEY} == ${NAME} ]]
    then
      echo ${VALUE}
      return 0
    fi
  done
  return 1
}

red=1
green=2
yellow=3
blue=4
magenta=5
cyan=6
white=7

COLOR=$1
shift
CMD=$*

if [[ "${COLOR}" == "next" ]]
then
  COLOR=$(cat ~/.color 2>/dev/null)
  (( COLOR+=1 ))
  if (( ${COLOR} == 16 ))
  then
    COLOR=1
  fi
  echo ${COLOR} > ~/.color
fi

if color ${COLOR} &>/dev/null
then
  COLOR=$(color ${COLOR})
fi

tput setaf ${COLOR}
${CMD}
tput sgr0
