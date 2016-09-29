#!/bin/bash

#===============================================#
# Using vsearch, pick OTUs
#===============================================#

# Setting up folders
homedir=/people/bris469/data/CC_mouse_time_delay
output=$homedir/otus_vsearch


cd $output
rm -f rep_set.*


# clustering with vsearch
vsearch --cluster_smallmem seqs.checked_denovo.ref.fna --threads 10 \
--id 0.97 --centroids rep_set.fna --log rep_set.log \
--sizein --xsize --usersort --relabel OTU_

