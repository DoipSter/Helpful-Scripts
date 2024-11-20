#!/bin/bash

CONFIG_FILE="$HOME/.daily_report_config"

#MobileAPPS dir
PROJECT_BASE_DIR="/mnt/c/Users/saste/Workspace/MobileApps"

# Function to capture and store user's name(Only if it is not already stored)
get_username() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Enter your name: "
        read -r USER_NAME
        echo "USER_NAME=\"$USER_NAME\"" > "$CONFIG_FILE"
    else
        source "$CONFIG_FILE"
    fi
}

# A Function to list projects and allow the user to select one from the MobileApps Directory
select_project() {
    echo "Select a project from the list:"
    PROJECT_DIRS=$(find "$PROJECT_BASE_DIR" -mindepth 1 -maxdepth 1 -type d)
    PROJECT=$(echo "$PROJECT_DIRS" | fzf --height 10 --prompt="Choose a project: " --border)
    if [ -z "$PROJECT" ]; then
        echo "No project select. Exiting"
        exit 1
    fi
}

# Generate the daily report

generate_report() {
    REPORT_DIR="$PROJECT/reports"
    REPORT_FILE="$REPORT_DIR/daily_report_$(date '+%y-%m-%d').txt"

    # check if report directory exists

    mkdir -p "$REPORT_DIR"

    #Basic outline of report to be output in the file
    {
        echo "Daily Report"
        echo "============"
        echo "Name       : $USER_NAME"
        echo "Date       : $(date)"
        echo "Project    : $PROJECT"
        echo ""
        echo "Bugs:"
        echo "------"
        echo ""
        echo "Fixes:"
        echo "------"
        echo ""
        echo "Additional Comments:"
    } > "$REPORT_FILE"

    echo "Report is opening in..."
    echo "3..."
    sleep(0.6)
    echo "2.."
    sleep(0.6)
    echo "1."    
    sleep(0.6)    

    emacs "$REPORT_FILE"

    echo "Report saved at: $REPORT_FILE"
}

# Main Script
get_username
select_project
generate_report