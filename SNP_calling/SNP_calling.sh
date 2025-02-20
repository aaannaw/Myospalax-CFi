/data/01/user164/software/bwa-mem2-2.2.1_x64-linux/bwa-mem2  index Ma6.Chr.2210.fasta
/data/01/user164/software/bwa-mem2-2.2.1_x64-linux/bwa-mem2 mem -t 20 -R '@RG\tID:$i\tPL:illumina\tLB:$i\tSM:$i' Ma6.Chr.2210.fasta ${i}_1.fq.gz ${i}_2.fq.gz | /data/00/user/user157/miniconda3/bin/samtools view --threads 20 -Sb - > $i.bam
/data/00/user/user157/miniconda3/bin/samtools sort -@ 20 -m 2G -O bam -o $i.sort.bam $i.bam
/data/00/software/gatk/gatk-4.1.4.1/gatk MarkDuplicates -I $i.sort.bam -O $i.sort.markdup.bam -M $i.sort.markdup_metrics.txt
gatk CreateSequenceDictionary -R Ma6.Chr.2210.fasta -O Ma6.Chr.2210.fasta.dict
/data/00/software/gatk/gatk-4.1.4.1/gatk HaplotypeCaller --java-options -Xmx5G -R Ma6.final.chr.fasta  -emit-ref-confidence GVCF -I $i.sort.markdup.bam -L $Chr -O $i/$Chr.g.vcf.gz
/data/00/software/gatk/gatk-4.1.4.1/gatk CombineGVCFs -R Ma6.Chr.2210.fasta --variant $i.g.vcf --variant $i.g.vcf --variant $i.g.vcf ... -O hebing.g.vcf
/data/00/software/gatk/gatk-4.1.4.1/gatk GenotypeGVCFs -R 00.Ma6.Chr.2210.fasta -V combined.g.vcf.gz -O combine.vcf.gz
/data/00/software/gatk/gatk-4.1.4.1/gatk SelectVariants -select-type SNP -V combine.vcf.gz -O M.snp.vcf.gz
/data/00/software/gatk/gatk-4.1.4.1/gatk VariantFiltration -V M.snp.vcf.gz --filter-expression "QD < 2.0 || MQ < 20.0 || FS > 60.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name "Filter" -O M.filter.snp.vcf.gz
/data/01/user157/software/bcftools/bin/bcftools filter -g 5 -O v -o M.filter.snp.indel.vcf  M.filter.snp.vcf.gz
/data/01/user157/software/vcftools/bin/vcftools --vcf M.filter.snp.indel.vcf --maf 0.05 --mac 3 --minDP 5 --maxDP 150 --minGQ 20 -h 0.0001 --max-missing 0.95 --min-alleles 2 --max-alleles 2--recode --recode-INFO-all --out M.final.vcf

