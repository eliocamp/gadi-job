PROJECT_FILE="$HOME/pbs-workbench/project.job"

cleanup() {
    rm -f "$PROJECT_FILE"
    exit 0  
}

trap cleanup SIGTERM

echo "JOB_ID=${PBS_JOBID}" > "$PROJECT_FILE"
echo "HOSTNAME=$(hostname)" >> "$PROJECT_FILE"
echo "STARTED=$(date +%s)" >> "$PROJECT_FILE"

while true; do
    sleep 30  
done

exit 0
