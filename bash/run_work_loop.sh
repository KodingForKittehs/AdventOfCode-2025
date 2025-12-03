#!/bin/bash

if [ -n "$1" ]; then
    SLEEP_INTERVAL=$1
else
    SLEEP_INTERVAL=1
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
printf "#####  Completed running work.sh  #####\n"

# Check for changes in a loop
while true; do
    sleep $SLEEP_INTERVAL
    
    CURRENT_MTIME=$(stat -c %Y "$WATCH_FILE" 2>/dev/null)
    
    if [ "$CURRENT_MTIME" != "$LAST_MTIME" ]; then
        printf "\n#####  Change detected! Running work.sh...  #####\n"
        ./work.sh
        printf "#####  Completed running work.sh  #####\n"
        LAST_MTIME=$CURRENT_MTIME
    fi
done