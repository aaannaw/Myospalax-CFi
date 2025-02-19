/data/00/user/user157/miniconda3/bin/ngmlr -t 16 -r /data/01/user157/fenshu/HIFI/Hic-anchor/del/Ma6/Ma6.final.chr.fasta -q /data/01/user157/fenshu/ONT-reads/$i.fastq.gz  -o $i.sam -x ont
/data/00/user/user186/bin/samtools view --threads 20 -b -S $i.sam | /data/00/user/user186/bin/samtools sort -@ 20 -m 2G -O bam - -o - > $i.sort.bam
sniffles -m $i.sort.bam -v $i.sort.bam.vcf  -d 50 -n -1 -s 10 -t 10 -l 50
ls *sort.bam.vcf.vcf > vcf.list
SURVIVOR merge vcf.list 1000 1 1 -1 -1 -1 merged.vcf
sniffles -m $i.sort.bam -v $i.genotype.vcf --Ivcf merged.vcf
iris --keep_long_variants --also_deletions threads=30 genome_in=bwa-index/Ma6.final.chr vcf_in= $i.genotype.vcf vcf_out=$i.iris.vcf reads_in=$i.sort.bam outdir=iris
SURVIVOR merge 07.vcf.list 1000 1 1 -1 -1 -1 final.merged.vcf
