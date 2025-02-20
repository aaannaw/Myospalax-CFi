hisat2-build -p 20 Ma6.final.chr.fasta Ma6
for i in `cat sample.id`;hisat2 -x Ma6 -p 20 -X 500 --dta --fr --min-intronlen 20 --max-intronlen 600000 -1 ${i}_1.fq.gz -2 ${i}_2.fq.gz -S $i.sam 2>> $i.txt  && samtools view -bS $i.sam | samtools sort -@ 20 -o $i.bam
samtools merge  -@ 28 Ma6.merged.bam `ls *bam`
/data/01/user157/software/stringtie/stringtie -p 30 -o Ma6.stringtie.gtf ../02.hisat_mapping/01.bam/Ma6/Ma6.merged.bam
