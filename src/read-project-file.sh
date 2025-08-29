
# Function to read project.job file
read_project_file() {
    if [ ! -f "$PROJECT_FILE" ]; then
        return 1
    fi
    
    # Source the project file to get variables
    source "$PROJECT_FILE"
    echo "$JOB_ID|$HOSTNAME|$STARTED"
}
