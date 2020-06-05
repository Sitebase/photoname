#!/bin/bash

TEST_DIR=$(dirname "$0")
ROOT_DIR="${TEST_DIR}/.."

for f in ${TEST_DIR}/assets/*; do
    filename=$(basename "${f}")
    new_filename=$(${ROOT_DIR}/photoname.sh "$f")
    expected_new_filename=$(cat "${TEST_DIR}/expected.csv" | grep "${filename}" | cut -d ';' -f2) 

    if [ "$new_filename" == "$expected_new_filename" ]
    then
        echo "[success] $f -> $new_filename";
    else
        echo "[failed] rename $f expected/got:";
        echo "   - ${expected_new_filename}";
        echo "   - ${new_filename}";
        echo " "
        echo "================= RAW EXIF ================="
        exiftool "$f"
        echo "================= END EXIF ================="
        exit -1
    fi

done
