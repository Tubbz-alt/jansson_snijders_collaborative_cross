#!/bin/bash

#===============================================#
# Identify how many reads in our samples closely
# match our standards. This let's us estimate 
# the cross contamination rate between samples
# on this run.
#===============================================#

homedir=/people/bris469/data/CC_mouse_time_delay
# Used all reads (or subsampled reads)
reads=$homedir/split/seqs.fna.gz
ref=$homedir/standards/Mock_Hot_Lake_Community.aligned.v4.fna
out=$homedir/standards/map
which vsearch

cd $homedir

rm -rf $out
mkdir $out


vsearch -search_exact $reads -db $ref \
-strand plus -id 1.0 -uc $out/map_100.uc -threads 20

vsearch -usearch_global $reads -db $ref \
-strand plus -id 0.99 -uc $out/map_99.uc -threads 20


# Looks good!

cd $out
# make a table of OTUs
uc_to_otu.py -i map_100.uc -o map_100.txt
uc_to_otu.py -i map_99.uc -o map_99.txt




