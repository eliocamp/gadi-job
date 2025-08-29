#!/bin/bash
set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROJECT_FILE="project.job"

if [ -f "$PROJECT_FILE" ]; then
    echo "Another job already running"
    exit 1
fi

profile="${1:-"default"}"
profile_folder=$HOME/gadi-job/profiles
job_script="$profile_folder/${profile}.sh"

if [ ! -f $job_script ]; then
    echo "Job script $job_script not found"
    echo "Create a profile with job profile"
    exit 1
fi

JOB_ID=$(qsub "$job_script")


# Logs are saved here, make sure the folder exists
mkdir -p "$HOME/gadi-job/logs"

echo "JOB_ID=${JOB_ID}" > "$PROJECT_FILE"
job monitor