#!/bin/bash


#Vars
PROJECT_DIR="/mnt/c/Users/saste/Workspace/MobileApps"
CURRENT_DATE=$(date '+%Y-%m-%d')

#check if the daily report exists first
check_project(){
    if [ ! -f "$REPORT_FILE" ]; then
        echo "Error: No daily report found for today. Please create one first."
        exit 1
    fi
}

select_project() {
    echo "Select the project directory where the problem occurred:"
    PROJECT=$(find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type d ! -name ".git"| fzf --height 10 --prompt="Choose a directory: " --border)
    if [ -z "$PROJECT" ]; then
        echo "No directory selected. Exiting."
        exit 1
    fi
    REPORT_DIR="$PROJECT/reports"
    REPORT_FILE="$PROJECT/reports/daily_report_$CURRENT_DATE.txt"
}

add_problem(){
    while true; do

        echo "What's the problem?"
        read -r PROBLEM

        #APPENDS the problem to the bugs section in your daily report
        sed -i "/Bugs:/a - $PROBLEM (File: $FILE)" "$REPORT_FILE"

        echo "Do you have more problems to add? (y/n)"
        read -r RESPONSE
        if [[ "$RESPONSE" != "y" && "$RESPONSE" != "Y" ]]; then
            echo "All prolems added to $REPORT_FILE."
            break
        fi
    done
}

# Make sure the reports directory exists
mkdir -p "$REPORT_DIR"

#MAIN
select_project
check_project
add_problem