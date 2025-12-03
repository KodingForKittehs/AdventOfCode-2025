#!/bin/bash

if [ -n "$1" ]; then
    SLEEP_INTERVAL=$1
else
    SLEEP_INTERVAL=0.5
fi

WATCH_FILE="./work.sh"

if [ ! -f "$WATCH_FILE" ]; then
    echo "Error: $WATCH_FILE not found"
    exit 1
fi

echo "Watching $WATCH_FILE for changes (checking every ${SLEEP_INTERVAL}s)..."
echo "Press Ctrl+C to stop"

# Get initial modification time
LAST_MTIME=$(stat -c %Y "$WATCH_FILE" 2>/dev/null)

# Run once at startup
printf "#####  Running work.sh...  #####\n"
./work.sh
printf "\nAwaiting further changes to $WATCH_FILE."

# Check for changes in a loop
LOOP_COUNT=0
while true; do
    sleep $SLEEP_INTERVAL
    LOOP_COUNT=$((LOOP_COUNT + 1))
    if [ $((LOOP_COUNT % 10)) -eq 0 ]; then
        printf "."
    fi
    
    CURRENT_MTIME=$(stat -c %Y "$WATCH_FILE" 2>/dev/null)
    
    if [ "$CURRENT_MTIME" != "$LAST_MTIME" ]; then
        printf "\n"
        ./work.sh
        EXIT_CODE=$?
        if [ $EXIT_CODE -ne 0 ]; then
            printf "Error: work.sh exited with code $EXIT_CODE\n"
        fi
        printf "\nAwaiting further changes to $WATCH_FILE."

        LAST_MTIME=$CURRENT_MTIME
    fi
done