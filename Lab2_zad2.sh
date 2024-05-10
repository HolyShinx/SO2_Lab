#!/bin/bash

set -eu

TARGET_DIRECTORY_1="${1:-lab3_1}"
TARGET_DIRECTORY_2="${2:-lab3_2}"

if [ $# -eq 0 ]; then
    echo "Argumenty nie były podane"
    exit 1
fi

if [[ ! -d "${TARGET_DIRECTORY_1}" ]]; then
    echo "Katalog Numer 1 nie istnieje!"
    exit 1
fi

if [[ ! -d "${TARGET_DIRECTORY_2}" ]]; then
    echo "Katalog Numer 2 nie istnieje!"
    exit 1
fi

for FILE_NAME in "${TARGET_DIRECTORY_1}"/*;
do
    if [[ -d "${FILE_NAME}" ]]; then
        echo "${FILE_NAME} Jest katalogiem!"
    fi

    if [[ -L "${FILE_NAME}" ]]; then
        echo "${FILE_NAME} Jest dowiazaniem symbolicznym!"
    fi

    if [[ -f "${FILE_NAME}" ]]; then
        echo "${FILE_NAME} Jest plikiem"
    fi
done

for FILE_NAME in "${TARGET_DIRECTORY_1}"/*;
do
    if [[ -f "${FILE_NAME}" ]] || [[ -d "${FILE_NAME}" ]]; then
        BASE_NAME=$(basename "${FILE_NAME}")    
        NAME="${BASE_NAME%%.*}"                     #https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/utilities/V3_chap02.html#tag_18_06_02
        EXTENSION="${BASE_NAME#"${NAME}".}"    

        if [[ "$BASE_NAME" == *.* ]]; then
            BASE_NAME="${NAME^^}_ln.${EXTENSION}"
        else                                        #Warunek dla pliku/katalogu bez rozszerzenia xd
            BASE_NAME="${NAME^^}_ln"
        fi

        ln -s "${FILE_NAME}" "${TARGET_DIRECTORY_2}/${BASE_NAME}"
        echo "Udalo sie utworzyc dowiazanie symboliczne dla pliku ${BASE_NAME}"
    fi
done