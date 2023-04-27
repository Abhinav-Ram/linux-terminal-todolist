#!/bin/bash

# Define the file that stores the tasks
TASKS_FILE="tasks.txt"

# Parse the command line arguments
ACTION=$1
ID=$2
NAME=$3
DATE=$4

# Initialize LAST_ID to 0
LAST_ID=0


usage() {
    echo "Usage: $0 COMMAND [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  add ID NAME DATE  Add a new task with the given ID, name, and date"
    echo "  update ID NAME DATE  Update the task with the given ID to have the new name and date"
    echo "  delete ID  Delete the task with the given ID"
    echo "  disp  Display all tasks"
    echo "  help  Display this help message"
    echo ""
    echo "Options:"
    echo "  -h, --help  Display help information"
}


# Calculate LAST_ID if necessary
if [ "$ACTION" == "add" ] || [ "$ACTION" == "delete" ]; then
    LAST_ID=$(tail -n 1 "$TASKS_FILE" | awk '{print $1}')
fi

# Define a function to check if a task with the given ID exists
task_exists() {
    grep -q "^$ID\s" "$TASKS_FILE"
}

reorder_tasks() {
    awk '{printf("%d %s %s\n", NR, $2, $3)}' "$TASKS_FILE" > "$TASKS_FILE.tmp"
    mv "$TASKS_FILE.tmp" "$TASKS_FILE"
}

# Print usage information
if [[ "$ACTION" == "--help" || $1 == "-h" ]]; then
    usage
    exit 0


# Implement the "add" action
elif [ "$ACTION" == "add" ]; then
    if ! [[ "$2" =~ ^[0-9]+$ ]] || [ "$2" -ne $((LAST_ID+1)) ]; then
        echo "Error: Invalid ID, it should be integer and equal to the last ID + 1"
        exit 1
    fi
    # Check if the task already exists
    if task_exists; then
        echo "Error: Task with ID $ID already exists"
        exit 1
    fi

    # Add the task to the file
    echo "$ID $NAME $DATE" >> "$TASKS_FILE"

    # Reorder the task IDs in the file
    if [ "$2" -ne "$((LAST_ID+1))" ]; then
        reorder_tasks
    fi

    echo "Task added successfully"
    exit 0

# Implement the "update" action
elif [ "$ACTION" == "update" ]; then
    if ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid ID, it should be integer"
        exit 1
    fi
    # Check if the task exists
    if ! task_exists; then
        echo "Error: Task with ID $ID does not exist"
        exit 1
    fi

    # Update the task in the file
    sed -i "s/^$ID\s.*/$ID $NAME $DATE/" "$TASKS_FILE"

    echo "Task updated successfully"
    exit 0


# Implement the "delete" action
elif [ "$ACTION" == "delete" ]; then
    if ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid ID, it should be integer"
        exit 1
    fi

    # Check if the task exists
    if ! task_exists; then
        echo "Error: Task with ID $ID does not exist"
        exit 1
    fi

    # Delete the task from the file
    sed -i "/^$ID\s/d" "$TASKS_FILE"

    # Reorder the task IDs in the file
    if [ "$ID" -ne "$LAST_ID" ]; then
        reorder_tasks
    fi

    echo "Task deleted successfully"
    exit 0


# Implement the "display" action
elif [ "$ACTION" == "disp" ]; then
    # Display all tasks in the file
    cat "$TASKS_FILE"
    exit 0


else
    echo "Error: Invalid command"
    usage
    exit 1
fi

