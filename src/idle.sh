PROJECT_FILE="$HOME/pbs-workbench/project.job"

cleanup() {
    rm -f "$PROJECT_FILE"
    exit 0  
}

trap cleanup SIGTERM

while true; do
    sleep 30  
done

exit 0
