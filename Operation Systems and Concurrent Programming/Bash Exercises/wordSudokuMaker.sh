#!/bin/bash


#INCEREMENT
# i=$((i+1))
# ((i=i+1))
# let "i=i+1"

#Length of array
#   ${array[@]}
# 
# 


random_string() {
    textik= cat /dev/urandom | tr -dc "a-zA-Z'" | fold -w $1 | head -n 1
    echo $textik
}

#length f string
myvar="some string"
size=${#myvar} 

lines=()
for i in {0..9}; do
    lines+=("$(random_string 10)")
done


words=()
for i in 3 3 3 4 5 6 7 8 9 10; do
    variable=$(awk "length == $i" /usr/share/dict/american-english | sed -n "$((RANDOM%200+1)) p")
    words+=("$variable")
done
echo generated words

for i in {0..9}; do
    echo ${words[$i]}
done
echo 
if [[ $1 == "horiz" ]]; then
    for i in {0..9}; do
        len=${#words[$i]}
        if [[ $len != 10 ]]; then
            startIndex=$(($RANDOM%(10-$len)))
        else
            startIndex=0
        fi
        lines[$i]="${lines[$i]:0:((startIndex))}""${words[$i]}""${lines[$i]:((startIndex+len))}"
    done
elif [[ $1 == "vert" ]]; then
    for j in {0..9}; do
        len=${#words[$j]}
        if [[ $len != 10 ]]; then
            startIndex=$(($RANDOM%(10-$len)))
        else
            startIndex=0
        fi
        for ((i=0; i< len;i++))
        do
            row=$(($startIndex+$i))
            lines[$row]="${lines[$row]:0:$j}""${words[$j]:$i:1}""${lines[$row]:(($j+1))}"
        done
    done
else
    echo not implemented yet
fi

for i in {0..9}; do
    echo ${lines[$i]}
done