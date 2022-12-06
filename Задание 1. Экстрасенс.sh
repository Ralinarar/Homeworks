#!/bin/sh

#define colors
#RED='\e[31m'
#GREEN='\e[32m'
#RESET='\e[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

#Show percents
show_percents() {
  hit=$1
  miss=$2
  total=$(($hit + $miss))

  let hit_percent=hit*100/total
  let miss_percent=100-hit_percent

  echo "Hit: ${hit_percent}%" "Miss: ${miss_percent}%"
}

declare -i counter=1
declare -i hit_amount=0
declare -i miss_amount=0
declare -a history

while :; do
  echo "Step: ${counter}"
  counter+=1

  #read user attempt to suggest
  read -p "Please enter number from 0 to 9 (q - quit): " answer

  case "${answer}" in
  [0-9])
    #generate random from 0 to 9
    random=$(($RANDOM % 10))
    if [[ "${answer}" == "${random}" ]]; then
      echo "Hit! My number: ${random}"
      #format to green color
      number_string="${GREEN}${answer}${RESET}"
      #increment success attempt for percentage computing
      hit_amount+=1
    else
      echo "Miss! My number: ${random}"
      #format to red color
      number_string="${RED}${answer}${RESET}"
      #increment success attempt for percentage computing
      miss_amount+=1
    fi
    #add value for number displaying
    history+=(${number_string})

    #Show percents
    show_percents hit_amount miss_amount

    #Show history
    if [ ${#history[@]} -gt 10 ]; then
      echo "Numbers: ${history[@]: -10}"
    else
      #if less no need to cut
      echo "Numbers: ${history[@]}"
    fi
    ;;
  q)
    #user decided to exit
    echo "Bye"
    echo "Exit..."
    break
    ;;
  *)
    #not valid input
    echo "Not valid input"
    echo "Please repeat"
    ;;
  esac
done
