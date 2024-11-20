#!/bin/bash

CONFIG_FILE="$HOME/.daily_report_config"

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
    PROJECT_DIRS=$(find "Home" -maxdepth 1 -type d -name "*" | grep -v "^\.$" | grep -v "^\.\.$")
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
    
}