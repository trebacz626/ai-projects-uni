#!/bin/bash

action=$1
DATABASE='database'

if [[ ! -f $DATABASE  ]]; then
    touch $DATABASE
fi

while [[ -f $DATABASE  ]]
do
    PS3='Please enter your choice: '
    options=("add" "remove" "getDay" "search" "edit" "exit")
    select action in "${options[@]}"
    do
        if [[ "$action" == "add" ]]; then
            echo Date
            read date
            echo name
            read name
            echo description
            read description
            description=$(echo $description | tr '\n' '\t')
            description="\"$description\""
            record="$date;$name;$description"
            echo $record >> $DATABASE
        elif [[ "$action" == "remove" ]]; then
            PS3='Select event: '
            SAVEIFS=$IFS   # Save current IFS
            IFS=$'\n'
            events=($( cat $DATABASE ))
            IFS=$SAVEIFS   # Restore IFS
            select event in "${events[@]}"
            do
                echo selected $event
                splited=( $(echo "$event" | tr ';' ' ') )
                date=${splited[0]}
                name=${splited[1]}
                awk -F';' "!/$date;$name/" $DATABASE > tmpfile && mv tmpfile $DATABASE
                break
            done
        elif [[ "$action" == "getDay" ]]; then
            echo Date
            read date
            echo Days on date $date
            awk "/$date/" $DATABASE
        elif [[ "$action" == "search" ]]; then
            echo give description part
            read descriptionPart
            awk -F';' "\$3 ~ /$descriptionPart/" $DATABASE
        elif [[ "$action" == "edit" ]]; then
            PS3='Select event: '
            SAVEIFS=$IFS   # Save current IFS
            IFS=$'\n'
            events=($( cat $DATABASE ))
            IFS=$SAVEIFS   # Restore IFS
            select event in "${events[@]}"
            do
                echo selected $event
                splited=( $(echo "$event" | tr ';' ' ') )
                date=${splited[0]}
                name=${splited[1]}
                description=${splited[2]}
                PS3='What do you want to edit? '
                edits=( "date" "name" "description")
                select whatEdit in "${edits[@]}"
                do
                    case $whatEdit in
                        "date")
                            echo New date
                            read newDate
                            echo $newDate
                            awk -F';' "( /$name;$description/ ) {print \"$newDate\" \";\" \$2 \";\" \$3} !/$name;$description/ {print \$0}" $DATABASE > tmpfile && mv tmpfile $DATABASE
                            ;;
                        "name")
                            echo "you chose choice 2"
                            echo New name
                            read newName
                            awk -F';' "( /$date;.*;$description/ ) {print \$1 \";\" \"$newName\" \";\" \$3} !/$date;.*;$description/ {print \$0}" $DATABASE > tmpfile && mv tmpfile $DATABASE
                            ;;
                        "description")
                            echo New Description
                            read newDescription
                            awk -F';' "( /$date;$name/ ) {print \$1 \";\" \$2 \";\" \"$newDescription\"} !/$date;$name/ {print \$0}" $DATABASE > tmpfile && mv tmpfile $DATABASE
                            ;;
                        *) echo "invalid option $REPLY";;
                    esac
                    break
                done
                break
            done
        else
            exit 0
        fi
        break

    done
done