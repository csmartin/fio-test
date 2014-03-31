#!/bin/bash
# Run 6 times
# Usage: 
# fio_test.sh /dev/sdc1 100 600 write
#             file     % read   time (sec)  log file name


./fio_test.sh $1 $2 $3 2>&1 | tee -a fio-$4-1.log
./fio_test.sh $1 $2 $3 2>&1 | tee -a fio-$4-2.log
./fio_test.sh $1 $2 $3 2>&1 | tee -a fio-$4-3.log
./fio_test.sh $1 $2 $3 2>&1 | tee -a fio-$4-4.log
./fio_test.sh $1 $2 $3 2>&1 | tee -a fio-$4-5.log
./fio_test.sh $1 $2 $3 2>&1 | tee -a fio-$4-6.log

