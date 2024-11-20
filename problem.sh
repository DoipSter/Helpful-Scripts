#!/bin/bash


#Vars
PROJECT_DIR="/mnt/c/Users/saste/Workspace/MobileApps"
REPORT_DIR="$PROJECT_DIR/reports"
REPORT_FILE="$REPORT_DIR/daily_report_$(date '+%y-%m-d').txt"

#check if the daily report exists first
check_file(){
    if [ ! -f "$REPORT_FILE" ]; then
        echo "Error: No daily report found for today. Please create one first."
        exit 1
    fi
}

# A function to select a file
select_file() {
    echo "Select the file where the problem occurs:"
    FILE=$(find "$PROJECT_DIR" -type f | fzf --height 10 --prompt="Choose a file: " --border)
    if [ -z "$FILE" ]; then
        echo "No file selected. Exiting."
        exit 1
    fi
}

add_problem(){
    while true; do

        select_file
        check_file

        echo "What's the problem in '$FILE'?"
        read -r PROBLEM

        #APPENDS the problem to the bugs section in your daily report
        sed -i "/Bugs:/a - $PROBLEM (File: $FILE)" "$REPORT_FILE"

        echo "Do you have more problems to add? (y/n)"
        read -r RESPONSE
        if [[ "$RESPONSE" != "y" && "$RESPONSE" !="Y" ]]; then
            echo "All prolems added to $REPORT_FILE."
            break
        fi
    done
}