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

# Group 1 (gets the remainder jobs)
start1=1
end1=$((jobs_per_runner + remainder))
echo "group1_range=$start1-$end1" >> $GITHUB_OUTPUT

# Group 2
start2=$((end1 + 1))
end2=$((start2 + jobs_per_runner - 1))
echo "group2_range=$start2-$end2" >> $GITHUB_OUTPUT

# Group 3
start3=$((end2 + 1))
end3=$n
echo "group3_range=$start3-$end3" >> $GITHUB_OUTPUT

# Display distribution
echo "Distribution:"
echo "Group 1: $start1-$end1 ($(($end1 - $start1 + 1)) jobs)"
echo "Group 2: $start2-$end2 ($(($end2 - $start2 + 1)) jobs)"
echo "Group 3: $start3-$end3 ($(($end3 - $start3 + 1)) jobs)"