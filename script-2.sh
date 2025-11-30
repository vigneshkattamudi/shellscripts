#!/bin/bash
START_TIME=$(date +%s)

echo "PID of script-2: $$"

echo "$GREETING"

END_TIME=$(date +%s)

TOTAL_TIME=$(($END_TIME - $START_TIME))
echo "Total time taken: $TOTAL_TIME seconds"