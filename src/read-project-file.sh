
get_job_id() {
    PROJECT_FILE=$1
    if [ ! -f "$PROJECT_FILE" ]; then
        return 1
    fi
    read id < $PROJECT_FILE
    echo "$id"
}
