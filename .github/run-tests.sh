#!/bin/bash

GITHUB_DIR=$(dirname "$0")
ROOT_DIR="${GITHUB_DIR}/.."
TEST_DIR="${GITHUB_DIR}/../test"

echo $GITHUB_DIR

for f in ${TEST_DIR}/assets/*; do
    filename=$(basename $f)
    new_filename=$(${ROOT_DIR}/photoname.sh "$f")
    expected_new_filename=$(cat "${TEST_DIR}/expected.csv" | grep "${filename}" | cut -d ';' -f2) 

    if [ "$new_filename" == "$expected_new_filename" ]
    then
        echo "[success] $f -> $new_filename";
    else
        echo "[failed] expected ${expected_new_filename} but got ${new_filename}";
        exit -1
    fi

done
