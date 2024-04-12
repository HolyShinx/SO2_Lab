#!/bin/bash

SOURCE_DIR="${1:-lab_uno}"
RM_LIST="${2:-2remove}"
TARGET_DIR="${3:-bakap}"

if [[ ! -d "${TARGET_DIR}" ]]; then
    mkdir "${TARGET_DIR}"
    echo "Utworzyles: "${TARGET_DIR}" Byqu"
fi

if [[ -f "${RM_LIST}" ]]; then
    while IFS=$'\n' read -r FILE_NAME
    do
        FILE_PATH="${SOURCE_DIR}/${FILE_NAME}"
        if [[ -f "${FILE_PATH}" ]]; then
            rm -rf "${FILE_PATH}"
            echo "Usunieto plik: ${FILE_NAME}"
        else
            echo "Plik ${FILE_NAME} nie istnieje"
        fi
    done < "${RM_LIST}"
else
    echo "Brak listy z plikami do usuniecia xd."
fi

for FILE_NAME in "${SOURCE_DIR}"/*;  
do
    if [[ -f "${FILE_NAME}" ]]; then
        mv "${FILE_NAME}" "${TARGET_DIR}"
    fi

    if [[ -d "${FILE_NAME}" ]]; then
        cp -r "${FILE_NAME}" "${TARGET_DIR}"
    fi
done

FILE_COUNT=$( find "${SOURCE_DIR}" -maxdepth 1 | wc -l )

if [[ "${FILE_COUNT}" -gt 0 ]]; then
    echo "jeszcze cos zostalo"
fi

if [[ "${FILE_COUNT}" -ge 2 ]]; then
    echo "Zostaly conajmniej 2 pliki"
fi

if [[ "${FILE_COUNT}" -gt 4 ]]; then
    echo "Zostalo wiecej niz 4 pliki"
fi

if [[ "${FILE_COUNT}" -ge 2 && "${FILE_COUNT}" -le 4 ]]; then
    echo "Zostalo tak akurat, od 2 do 4 plikow"
fi

if [[ "${FILE_COUNT}" -eq 0 ]]; then
    echo "tu byl Kononowicz, nie ma nic"
fi

DATA="$( date +%Y-%m-%d )"    

zip -r bakap_"${DATA}".zip "${TARGET_DIR}"