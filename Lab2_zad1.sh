#!/bin/bash

set -eu

TARGET_DIRECTORY="${1:-lab3}"

if [ $# -eq 0 ]; then
    echo "Argumenty nie były podane"
    exit 1
fi

if [[ ! -d "${TARGET_DIRECTORY}" ]]; then
    echo "Podany katalog nie istnineje"
    exit 1
fi



for FILE_NAME in "${TARGET_DIRECTORY}"/*;
do
    if [[ -f "${FILE_NAME}" ]]; then
        if [[ "${FILE_NAME}" == *.bak ]]; then
            chmod a-w "${FILE_NAME}"
        fi
        if [[ "${FILE_NAME}" == *.txt ]]; then
            chmod 241 "${FILE_NAME}"
        fi
        if [[ "${FILE_NAME}" == *.exe ]]; then
            chmod a+x "${FILE_NAME}"
            chmod u+s "${FILE_NAME}"       #s - flaga specjalna UID, kazdy uruchamia jak wlasciciel
        fi

    fi
        
    if [[ -d "${FILE_NAME}" ]]; then
        if [[ "${FILE_NAME}" == *.bak ]]; then
            chmod 426 "${FILE_NAME}"
        fi
        if [[ "${FILE_NAME}" == *.tmp ]]; then
            chmod a-w "${FILE_NAME}"
            chmod u+w "${FILE_NAME}"
        fi
    fi
done

