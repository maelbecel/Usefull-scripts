#!/bin/bash
################
## Epitech C Norme Checker in bash
## github.com/maelbecel
################

function cat_readme() {
    echo ""
    echo "Usage: ./coding-style.sh DELIVERY_DIR [OPTIONS]"
    echo "       DELIVERY_DIR      Should be the directory where your project files are"
    echo "       OPTIONS           -v: Display the error information"
    echo ""
}

function update_line() {
    Line=$1
    File=~/scripts/norme/norme_rules.txt
    IFS=':' read -ra  Error <<< "$2"
    Error=${Error[1]}

    while read code info_error; do
        if [[ $code == $Error ]]; then
            echo "$Line$Error => $info_error"
            return
        fi
    done < $File
    echo "Cannot stat error $Error in $File"
}

function show_output() {
    while read Ligne Info; do

        if [[ -z "$FLAG_V" ]]; then
            Ligne="$Ligne $Info"
        else
            Ligne=$(update_line $Ligne $Info)
        fi
        if [[ $Info == *"MAJOR"* ]]; then
            echo -e "\033[31m$Ligne\033[0m"
        elif [[ $Info == *"MINOR"* ]]; then
            echo -e "\033[33m$Ligne\033[0m"
        elif [[ $Info == *"INFO"* ]]; then
            echo -e "\033[32m$Ligne\033[0m"
        else
            echo $Ligne
        fi
    done < $EXPORT_FILE

    echo -e "$(wc -l < $EXPORT_FILE) coding style error(s) report: \033[31m$(grep -c ": MAJOR:" $EXPORT_FILE) major\033[0m, \033[33m$(grep -c ": MINOR:" $EXPORT_FILE) minor\033[0m, \033[32m$(grep -c ": INFO:" $EXPORT_FILE) info\033[0m."
    rm -f $EXPORT_FILE
}

if [ $# == 0 ]; then
    cat_readme
else
    if [[ $2 == "-v" ]]; then
        FLAG_V="true"
    fi
    DELIVERY_DIR=$(readlink -f "$1")
    REPORTS_DIR=$(readlink -f .)
    EXPORT_FILE="$REPORTS_DIR"/coding-style-reports.log
    ### delete existing report file
    rm -f $EXPORT_FILE

    echo -e "\033[1mPulling docker for coding style checker...\033[0m"
    sudo docker pull ghcr.io/epitech/coding-style-checker:latest && sudo docker image prune -f > /dev/null

    echo -e "\033[1mRunning coding style checker...\033[0m"
    sudo docker run --rm -i -v "$DELIVERY_DIR":"/mnt/delivery" -v "$REPORTS_DIR":"/mnt/reports" ghcr.io/epitech/coding-style-checker:latest "/mnt/delivery" "/mnt/reports" > /dev/null
    [[ -f $EXPORT_FILE ]] && show_output
fi