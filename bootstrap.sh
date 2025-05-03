#!/bin/bash

set -e

# Store the absolute path to the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

# Record the start time
start_time=$(date +%s)

# Source utility functions
source "$SCRIPTS_DIR/utils.sh"

# Record the end time
end_time=$(date +%s)

# Calculate duration
duration=$((end_time - start_time))

# Convert duration to hours, minutes, and seconds
hours=$((duration / 3600))
minutes=$(((duration % 3600) / 60))
seconds=$((duration % 60))

print_color "Bootstrap process completed successfully!" "$GREEN"
print_color "Total execution time: ${hours}h ${minutes}m ${seconds}s" "$YELLOW"
print_color "Please log out and log back in for all changes to take effect." "$YELLOW"