#!/bin/bash

action=$1
DATABASE='database'

# $t="t"
# while [[ $t == "t"]]; do
#     PS3='Please enter your choice: '
#     options=("add" "remove" "getDay" "search" "edit")
#     select opt in "${options[@]}"
#     do
#     done
# done


if [[ ! -f $DATABASE  ]]; then
    touch $DATABASE
fi

if [[ "$action" == "add" ]]; then
    date=$2
    name=$3
    description=$4
    description=$(echo $description | tr '\n' '\t')
    record="$date;$name;$description"
    # echo $record
    echo $record >> $DATABASE
elif [[ "$action" == "remove" ]]; then
    date=$2
    name=$3
    awk "!/$date;$name/" $DATABASE > tmpfile && mv tmpfile $DATABASE
elif [[ "$action" == "getDay" ]]; then
    date=$2
    awk "/$date/" $DATABASE
elif [[ "$action" == "search" ]]; then
    descriptionPart=$2
    awk -F';' "\$3 ~ /$descriptionPart/" $DATABASE
elif [[ "$action" == "edit" ]]; then
    date=$2
    name=$3
    newDescription=$4
    awk -F';' "/$date;$name/ {print \$1 \";\" \$2 \";\" \"$newDescription\"}" $DATABASE > tmpfile && mv tmpfile $DATABASE
else
    echo wrong action
fi


# PS3='Please enter your choice: '
#     options=("Option 1" "Option 2" "Option 3" "Quit")
#     select opt in "${options[@]}"
#     do
#         case $opt in
#             "Option 1")
#                 echo "you chose choice 1"
#                 ;;
#             "Option 2")
#                 echo "you chose choice 2"
#                 ;;
#             "Option 3")
#                 echo "you chose choice $REPLY which is $opt"
#                 ;;
#             "Quit")
#                 break
#                 ;;
#             *) echo "invalid option $REPLY";;
#         esac
#     done