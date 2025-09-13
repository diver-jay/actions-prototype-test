#!/bin/bash

# Job execution script
# Usage: ./execute_jobs.sh <group_name> <job_range>

group_name=$1
job_range=$2

if [ -z "$group_name" ] || [ -z "$job_range" ]; then
    echo "Usage: $0 <group_name> <job_range>"
    exit 1
fi

# Parse job range (e.g., "1-7" -> start=1, end=7)
start=$(echo $job_range | cut -d'-' -f1)
end=$(echo $job_range | cut -d'-' -f2)

echo "🚀 $group_name executing jobs $start to $end"

# Execute jobs in the range
for i in $(seq $start $end); do
    echo "  ✅ Job $i completed"
    sleep 0.5
done

echo "🎉 $group_name completed all jobs ($start-$end)"