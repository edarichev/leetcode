#!/bin/bash
# очистка каталогов (запуск make clean)

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for i in `ls -d */`; do
    echo $i
    cd "$i"
    for j in `ls -d */`; do
        echo "----" $j
        cd "$j"
        make clean
        cd ..
    done
    cd ..
done
IFS=$SAVEIFS
