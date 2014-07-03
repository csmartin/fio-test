#!/bin/bash
# Iterates the various cache options on a LD
# Usage: 
# run_fio_batches 1 /dev/sdc1 ssd
#              LD #   Device name  Human readable device name


# clear the logs
rm -rf ./fio*.log
rm -rf MegaSAS.log #(removing *.log seems to remove overall.log and prevents it from being re-made with content after this point)
rm import.csv

duration="600"

# Run read test
./run_fio_batches.sh $2 100 $duration $3-WT-NORA-read

# Run write test
./run_fio_batches.sh $2 70 $duration $3-WT-NORA-70read-30write

# Run pure write test
./run_fio_batches.sh $2 0 $duration $3-WT-NORA-0read-100write

# Prepare data for import
./parse_log.pl > import.csv

