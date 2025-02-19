ls illumina reads/M.psilurus.6 *.fq.&z l awk 'fprint "gzip -dc "$0 }'> generate.file
Jellyfish count -m 21 -s3G -t 40 -C-0 Ma6.21.kmer.count -ggenerate.file -G 2
jellyfish histo -v -o Ma6.21.kmer.histo Ma6.21.kmer.count -t 40 -h 10000
jellyfish stats 21.Ma6.kmer.counts -o 21.Ma6.kmer.stats
gce -fMa6.kmer.histo-c 21 -H0-g83767325646 -M 10000 >1.Ma6.gce.table 2> Ma6.gce.log
