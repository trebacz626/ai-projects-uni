#!/bin/bash
matrix_file1=$1
matrix_file2=$2


declare -A matrix1
n1=0
while read line; do
    line=($line)
    len=${#line[@]}
    m1=$len
    for ((j=0; j<len; j++))
    do
        matrix1[$n1,$j]=${line[$j]}
    done
    n1=$((n1+1))
done < $matrix_file1


declare -A matrix2
n2=0
while read line; do
    line=($line)
    len=${#line[@]}
    m2=$len
    for ((j=0; j<len; j++))
    do
        matrix2[$n2,$j]=${line[$j]}
    done
    n2=$((n2+1))
done < $matrix_file2

echo sizes $n1 $m1 $n2 $m2

if [[ $m1 != $n2 ]]
then
    exit  1
fi

declare -A matrix3

for (( i = 0; i<n1; i++ ))
do
    for ((j = 0; j<m1; j++))
    do
        let sum=0
        for ((k = 0; k<m1; k++))
        do
            let sum+=${matrix1[$i,$k]}*${matrix2[$k,$j]}
        done
        matrix3[$i,$j]=$sum
        # echo "${matrix3[$i,$j]}"
    done
done

for (( i=0; i< n1; i++))
do
    for (( j=0;j<m2;j++ ))
    do
        echo -n "${matrix3[$i,$j]} "
    done
    echo
done

