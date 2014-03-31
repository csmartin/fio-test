#!/bin/bash
# Runs a FIO test on a device
# usage:
# fio_test /dev/sdb1 100 600 
#           file   % read  seconds to run

fio --filename=$1 --direct=1 --rw=randrw --refill_buffers --norandommap --randrepeat=0 --ioengine=libaio --bs=4k --rwmixread=$2 --iodepth=16 --numjobs=16 --runtime=$3 --group_reporting --name=4ktest

