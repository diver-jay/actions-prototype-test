#!/bin/bash

# Job distribution calculator
# Usage: ./calculate_distribution.sh <total_jobs> <total_runners>

n=$1
k=$2

if [ -z "$n" ] || [ -z "$k" ]; then
    echo "Usage: $0 <total_jobs> <total_runners>"
    exit 1
fi

# Calculate distribution
jobs_per_runner=$((n / k))
remainder=$((n % k))

# Create JSON array for matrix strategy
groups_json="["
current_start=1

echo "Distribution:"

for i in $(seq 1 $k); do
    # Calculate jobs for this group
    if [ $i -le $remainder ]; then
        # First 'remainder' groups get one extra job
        jobs_in_group=$((jobs_per_runner + 1))
    else
        jobs_in_group=$jobs_per_runner
    fi

    current_end=$((current_start + jobs_in_group - 1))

    # Add to JSON array
    if [ $i -gt 1 ]; then
        groups_json+=","
    fi
    groups_json+="{\"name\":\"Group $i\",\"range\":\"$current_start-$current_end\"}"

    # Display
    echo "Group $i: $current_start-$current_end ($jobs_in_group jobs)"

    # Update start for next group
    current_start=$((current_end + 1))
done

groups_json+="]"
echo "groups_matrix=$groups_json" >> $GITHUB_OUTPUT