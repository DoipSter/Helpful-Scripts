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