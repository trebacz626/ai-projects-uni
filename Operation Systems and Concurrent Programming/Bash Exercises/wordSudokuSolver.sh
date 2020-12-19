#!/bin/bash

sudoku_file=$1
direction=$2

lin=$(cat file |tr "\n" " ")
lines=($lin)
echo lets see
if [[ $direction == "horiz" ]]; then
    for i in {0..9}; do
        for j in {0..9}; do
            max_len=$((10-$j))
            for (( k=3; k<=max_len; k++)) do
                wordToCheck=${lines[$i]:j:k}
                if grep -Fxq "$wordToCheck" /usr/share/dict/american-english
                then
                    echo found $wordToCheck
                fi
            done
        done
    done
elif [[ $direction == "vert" ]]; then
    echo not implemented
    for j in {0..9}; do
        for i in {0..9}; do
            for (( k=3; k<=10-i;k++)) do
                wordToCheck=""
                for ((l = i; l<i+k;l++)) do
                    wordToCheck+=${lines[$l]:j:1}
                done
                if grep -Fxq "$wordToCheck" /usr/share/dict/american-english
                then
                    echo found $wordToCheck
                fi
            done    
        done
    done
fi