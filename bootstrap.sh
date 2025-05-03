#!/bin/bash

set -e

# Store the absolute path to the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

# Record the start time
start_time=$(date +%s)

# Source utility functions
source "$SCRIPTS_DIR/utils.sh"

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
  print_color "This script is intended for Arch Linux only." "$RED"
  exit 1
fi

# Run scripts in sequence
print_color "Starting bootstrap process..." "$YELLOW"

# Array of scripts to run in order
SCRIPTS=()

# Execute each script
for script in "${SCRIPTS[@]}"; do
  script_path="$SCRIPTS_DIR/$script"

  # Debug information
  print_color "Attempting to run script: $script_path" "$YELLOW"
  print_color "Current working directory: $(pwd)" "$YELLOW"

  if [ -f "$script_path" ]; then
    print_color "Running $script..." "$YELLOW"

    # Ensure script is executable
    if [ ! -x "$script_path" ]; then
      chmod +x "$script_path"
    fi

    # Save current directory
    pushd "$SCRIPT_DIR" >/dev/null

    # Source the script with absolute path
    source "$script_path"

    # Return to previous directory
    popd >/dev/null

    if [ $? -eq 0 ]; then
      print_color "$script completed successfully." "$GREEN"
    else
      print_color "$script failed! Exiting..." "$RED"
      exit 1
    fi
  else
    print_color "Script $script not found at $script_path!" "$RED"
    print_color "Contents of scripts directory:" "$YELLOW"
    ls -la "$SCRIPTS_DIR"
    exit 1
  fi
done

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