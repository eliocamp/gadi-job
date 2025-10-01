set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source $SCRIPT_DIR/functions.sh

PROJECT_FILE="$HOME/pbs-workbench/project.job"

profile="${1:-"default"}"

# Let profile be either a profile or an actual file. 
if [ -f $profile ]; then
    job_script=$profile
else 
  profile_folder=$HOME/pbs-workbench/profiles
  job_script="$profile_folder/${profile}.sh"

  if [ ! -f $job_script ]; then
      echo "Job script $job_script not found"
      echo "Create a profile with job profile"
      exit 1
  fi
fi

job_id=$(qsub -h "$job_script")

function cleanup {
  qdel "$job_id"
}

trap cleanup EXIT

printf "%.0f\n" $(su_from_id $job_id)