SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROJECT_FILE="$HOME/pbs-workbench/project.job"


if [ ! -f "$PROJECT_FILE" ]; then
    echo "No job running"
    exit 1
fi

source read-project-file.sh

project_data=$(read_project_file "$PROJECT_FILE")

IFS='|' read -r job_id hostname started_time <<< "$project_data"

echo "Deleting job $job_id"
qdel $job_id
rm "$PROJECT_FILE"