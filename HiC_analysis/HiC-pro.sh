#HiC-pro
python3 HiC-Pro_3.1.0/bin/utils/split_reads.py --results_folder  .  --nreads 20000000 Ma6_R1.fastq
python3 HiC-Pro_3.1.0/bin/utils/split_reads.py --results_folder  .  --nreads 20000000 Ma6_R2.fastq
python3 /data/01/user157/software/hic-pro/HiC-Pro_3.1.0/bin/utils/digest_genome.py -r ^GATC -o Ma6.MBOI.bed  Ma6.final.Chr.fasta

#FitHiC
