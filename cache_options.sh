#!/bin/bash
# Iterates the various cache options on a LD
# Usage: 
# run_fio_batches 1 /dev/sdc1 ssd
#              LD #   Device name  Human readable device name


# clear the logs
rm -rf ./fio*.log
rm -rf MegaSas.log (removing *.log seems to remove overall.log and prevents it from being re-made with content after this pooint)
rm import.csv

duration="600"

# *****
# WB + ADRA (default)
# *****
MegaCli -LDSetProp WB -L$1 -a0
MegaCli -LDSetProp ADRA -L$1 -a0

# Run read test
./run_fio_batches.sh $2 100 $duration $3-WB-ADRA-read

# Run write test
./run_fio_batches.sh $2 70 $duration $3-WB-ADRA-70read-30write

# *****
# WB + RA
# *****
MegaCli -LDSetProp WB -L$1 -a0
MegaCli -LDSetProp RA -L$1 -a0

# Run read test
./run_fio_batches.sh $2 100 $duration $3-WB-RA-read

# Run write test
./run_fio_batches.sh $2 70 $duration $3-WB-RA-70read-30write


# *****
# WB + NORA
# *****
MegaCli -LDSetProp WB -L$1 -a0
MegaCli -LDSetProp NORA -L$1 -a0

# Run read test
./run_fio_batches.sh $2 100 $duration $3-WB-NORA-read

# Run write test
./run_fio_batches.sh $2 70 $duration $3-WB-NORA-70read-30write


# *****
# WT + ADRA
# ****
MegaCli -LDSetProp WT -L$1 -a0
MegaCli -LDSetProp ADRA -L$1 -a0

# Run read test
./run_fio_batches.sh $2 100 $duration $3-WT-ADRA-read

# Run write test
./run_fio_batches.sh $2 70 $duration $3-WT-ADRA-70read-30write

# *****
# WT + RA
# *****

MegaCli -LDSetProp WT -L$1 -a0
MegaCli -LDSetProp RA -L$1 -a0

# Run read test
./run_fio_batches.sh $2 100 $duration $3-WT-RA-read

# Run write test
./run_fio_batches.sh $2 70 $duration $3-WT-RA-70read-30write


# *****
# WT + NORA (aka Cut through IO)
# *****

MegaCli -LDSetProp WT -L$1 -a0
MegaCli -LDSetProp NORA -L$1 -a0

# Run read test
./run_fio_batches.sh $2 100 $duration $3-WT-NORA-read

# Run write test
./run_fio_batches.sh $2 70 $duration $3-WT-NORA-70read-30write

# Prepare data for import
./parse_log.pl > import.csv

# Verify raid options succeeded
cat ./MegaSAS.log | grep success | wc -l
echo "Above value should be 12 if all mode changes succeeded"
