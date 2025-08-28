#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROJECT_FILE="project.job"

if [ -f "$PROJECT_FILE" ]; then
    echo "Another job already running"
    exit 1
fi

profile=$1
profile="${profile:-"default"}"

job_script="$SCRIPT_DIR"/profiles/${profile}.sh

if [ ! -f $job_script ]; then
    echo "Job script $job_script not found"
    exit 1
fi

JOB_ID=$(qsub "$job_script")

echo "JOB_ID=${JOB_ID}" > "$PROJECT_FILE"
job monitor