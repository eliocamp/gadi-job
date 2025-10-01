#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROJECT_FILE="$HOME/pbs-workbench/project.job"


if [ ! -f "$PROJECT_FILE" ]; then
    echo "No job running"
    exit 1
fi

source "$SCRIPT_DIR/functions.sh"

job_id=$(get_job_id "$PROJECT_FILE")

echo "Deleting job $job_id"
qdel $job_id
rm "$PROJECT_FILE"