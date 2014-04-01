#!/bin/bash
# usage: make_ssd_r10_with_stripe.sh 64
# Where the # is the KB of stripe size, values: 64, 128, 256, 512, and 1024

# Create the array with the desired stripe size
MegaCli -CfgSpanAdd -r10 -Array0[32:4,32:5] -Array1[32:6,32:7] -strpsz $1 -a0

# Force a start of an init
MegaCli -LDInit -Start -Full -L1 -a0

# Watch the progress and hopefully hang on it until complete
MegaCli -LDInit -ProgDsply -L1 -a0

# Dump the 200G partition onto the disk
cat ./200g.partition.map | sfdisk -f /dev/sdc

