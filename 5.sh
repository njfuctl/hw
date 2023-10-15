#!/bin/bash

journal_file="journal.log"
if [ ! -f "$journal_file" ]; then
    echo "Error: journal.log file not found."
    exit 1
fi

tail -n 10 "$journal_file" | grep 'Startup finished in' | awk '{print $NF}' | cut -d 'm' -f 1 > "boot_times_ms.txt"

awk '{print $1 / 1000}' "boot_times_ms.txt" > "boot_times.txt"

sort -n "boot_times.txt" > "sorted_boot_times.txt"

log_count=$(wc -l < "sorted_boot_times.txt")
total_time=$(awk '{total += $1} END {print total}' "sorted_boot_times.txt")
average_time=$(echo "scale=2; $total_time / $log_count" | bc)
median_time=$(awk 'NR == FNR{a[NR] = $1; next} {b[NR] = $1} END{mid = int((NR + 1) / 2); if (NR % 2 == 1) print a[mid]; else print (a[mid] + a[mid + 1]) / 2;}' "sorted_boot_times.txt" "sorted_boot_times.txt")
max_time=$(tail -n 1 "sorted_boot_times.txt")

echo "Average Boot Time: $average_time seconds"
echo "Median Boot Time: $median_time seconds"
echo "Maximum Boot Time: $max_time seconds"

rm "boot_times_ms.txt" "boot_times.txt" "sorted_boot_times.txt"
