#!/bin/bash
################
## Reminder in bash
## github.com/maelbecel
################

REMINDER_FILE=~/scripts/reminder/reminder.txt

# (crontab -l ; echo "* * * * * ~/scripts/reminder/reminder.sh -c")| crontab -

function cat_readme() {
    echo ""
    echo "Usage: ./reminder.sh [OPTIONS]"
    echo ""
    echo "OPTIONS           -h: Display this help"
    echo "                  -a: Add a reminder"
    echo "                  -d: Delete a reminder"
    echo "                  -l: List all reminders"
    echo "                  -r: Remove all reminders"
    echo "                  -c: Check for reminders"
    echo "                  -p: Check for old reminders"
    echo "                  -o: Delete old reminders"
    echo ""
}
function get_nextline() {
    nbline=$(cat $REMINDER_FILE | grep "" -c)
    nbline=$(($nbline + 1))
    echo $nbline
}

function add_reminder() {
    echo "Add a reminder"
    echo "Enter the reminder:"
    read Reminder
    echo "Enter the date (YYYY-MM-DD):"
    read Date
    echo "Enter the time (HH:MM):"
    read Time
    echo "$(get_nextline) $Date $Time $Reminder" >> $REMINDER_FILE
    echo "Reminder added"
}

function delete_reminder() {
    echo "Delete a reminder"
    echo "Enter the number of the reminder to delete:"
    read Number
    sed "/^$Number/d" $REMINDER_FILE
    echo "Reminder deleted"
}

function list_reminder() {
    echo "List all reminders"
    while read Line; do
        IFS=' ' read -ra  Reminder <<< "$Line"
        if [[ ${Reminder[1]} == $(date +%Y-%m-%d) ]]; then
            if [[ ${Reminder[2]} == $(date +%H:%M) ]]; then
                echo -e "\e[33m[Now]\e[0m    $Line "
            elif [[ ${Reminder[2]} > $(date +%H:%M) ]]; then
                echo -e "\e[33m[Today]\e[0m  $Line "
            else
                echo -e "\e[31m[Old]\e[0m    $Line "
            fi
        elif [[ ${Reminder[1]} < $(date +%Y-%m-%d) ]] && [[ ${Reminder[2]} < $(date +%H:%M) ]]; then
            echo -e "\e[31m[Old]\e[0m    $Line "
        else
            echo -e "\e[32m[Future]\e[0m $Line "
        fi
    done < $REMINDER_FILE
}

function remove_reminder() {
    echo "Remove all reminders"
    echo "Are you sure? (y/n)"
    read Answer
    if [[ $Answer == "y" ]]; then
        echo -n "" > $REMINDER_FILE
        echo "All reminders removed"
    fi
}

function check_reminder() {
    echo "PASSED $(date +%H:%M:%S)" >~/scripts/reminder/reminder.log
    while read Line; do
        IFS=' ' read -ra  Reminder <<< "$Line"
        if [[ ${Reminder[1]} == $(date +%Y-%m-%d) ]]; then
            if [[ ${Reminder[2]} == $(date +%H:%M) ]]; then
                read a b c d <<< "${Reminder[*]}"
                kdialog --sorry "$(date +%H:%M)\n$d" 2> /dev/null &
            fi
        fi
    done < $REMINDER_FILE
}

function check_old_reminder() {
    echo "Check for old reminders"
    while read Line; do
        IFS=' ' read -ra  Reminder <<< "$Line"
        if [[ ${Reminder[1]} < $(date +%Y-%m-%d) ]]; then
            read a b c d <<< "${Reminder[*]}"
            echo "$d"
        fi
    done < $REMINDER_FILE
}

function delete_old_reminder() {
    echo "Delete old reminders"
    echo "Are you sure? (y/n)"
    read Answer
    if [[ $Answer == "y" ]]; then
        while read Line; do
            IFS=' ' read -ra  Reminder <<< "$Line"
            if [[ ${Reminder[1]} < $(date +%Y-%m-%d) ]]; then
                sed "/^${Reminder[0]}/d" $REMINDER_FILE
            fi
        done < $REMINDER_FILE
        echo "Old reminders deleted"
    fi
}

function main() {
    if [ $# == 0 ]; then
        cat_readme
    else
        case $1 in
            "-h")
                cat_readme
                ;;
            "-a")
                add_reminder
                ;;
            "-d")
                delete_reminder
                ;;
            "-l")
                list_reminder
                ;;
            "-r")
                remove_reminder
                ;;
            "-c")
                check_reminder
                ;;
            "-p")
                check_old_reminder
                ;;
            "-o")
                delete_old_reminder
                ;;
            *)
                echo "Invalid option"
                cat_readme
                ;;
        esac
    fi
}

main $1