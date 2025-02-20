#HiC-pro
python3 HiC-Pro_3.1.0/bin/utils/split_reads.py --results_folder  .  --nreads 20000000 Ma6_R1.fastq
python3 HiC-Pro_3.1.0/bin/utils/split_reads.py --results_folder  .  --nreads 20000000 Ma6_R2.fastq
python3 /data/01/user157/software/hic-pro/HiC-Pro_3.1.0/bin/utils/digest_genome.py -r ^GATC -o Ma6.MBOI.bed  Ma6.final.Chr.fasta
bowtie2-build --threads 20 Ma6.Chr.2210.fasta Ma
/data/01/user157/software/Hic-Pro/hic-pro-install/HiC-Pro-3.1.0/bin/HiC-Pro -i fastq -o results -c config-hicpro.txt
#FitHiC
/data/01/user157/software/Hic-Pro/hic-pro-install/HiC-Pro-3.1.0/bin/utils/hicpro2fithic.py -i chroder_20000_iced.matrix -b chroder_20000_abs.bed -s  chroder_20000_iced.matrix.biases
fithic -f fithic.fragmentMappability.gz -i fithic.interactionCounts.gz -t fithic.biases.gz -o fithic -l Ma -v -x All -r 20000
python runfilterpvalue.qvalue.count.py Ma.spline_pass1.res20000.significances.txt.gz Ma.spline_pass1.res20000.significances.txt.bed
