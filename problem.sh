#!/bin/bash


#Vars
PROJECT_DIR="/mnt/c/Users/saste/Workspace/MobileApps"
REPORT_DIR="$PROJECT_DIR/reports"
REPORT_FILE="$REPORT_DIR/daily_report_$(date '+%y-%m-d').txt"

#check if the daily report exists first
if [ ! -f "$REPORT_FILE" ]; then
    echo "Error: No daily report found for today. Please create one first."
    exit 1
fi


# A function to select a file
select_file() {
    echo "Select the file where the problem occurs:"
    FILE=$(find "$PROJECT_DIR" -type f | fzf --height 10 --prompt="Choose a file: " --border)
    if [ -z "$FILE" ]; then
        echo "No file selected. Exiting."
        exit 1
    fi
}