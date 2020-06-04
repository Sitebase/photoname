#!/bin/bash

for f in assets/*; do
    filename=$(basename $f)
    new_filename=$(./../photoname.sh "$f")
    expected_new_filename=$(cat "expected.csv" | grep "${filename}" | cut -d ';' -f2) 

    if [ "$new_filename" == "$expected_new_filename" ]
    then
        echo "[success] $f -> $new_filename";
    else
        echo "[failed] expected ${expected_new_filename} but got ${new_filename}";
        exit -1
    fi

done
