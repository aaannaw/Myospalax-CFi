#Delly
conda install -c bioconda delly
delly call -g Ma6.final.chr.fa -o $name.bcf $name.bam
delly merge -o all.sites.bcf $name1.bcf $name2.bcf $name3.bcf ...
delly call -g $reference -v all.sites.bcf -o $name1.geno.bcf $name1.bam
for file in *geno.bcf; do bcftools view $file -O v > $file.vcf; done
for file in *geno.bcf.vcf;  do python3 fillter.py $file; done
##filter.py
#!/usr/bin/python3
import sys
import re

infile = sys.argv[1]
name = re.search(r'(.*)\.vcf',infile)[1]
outfile = name + '.filter.vcf'
o = open(outfile, 'w')
with open(infile, 'r') as f:
    for line in f:
        line = line.strip()
        if line.startswith('#'):
            # print(line)
            o.write(line + '\n')
            continue
        content = line.split()
        if content[6] != "PASS" or re.match(r'IMPRECISE', content[7]):
            continue
        # print(line)
        o.write(line + '\n')
#lumpy（smoove）
conda install -c bioconda lumpy-sv
smoove call --outdir results-smoove/ --name $name1 --fasta Ma6.final.chr.fa -p 1 --genotype $name1.bam
smoove merge --name merged -fasta Ma6.final.chr.fa *.genotyped.vcf.gz
smoove genotype -d -x -p 1 --name $name1-joint --outdir results-genotyped/ --fasta Ma6.final.chr.fa --vcf merged.sites.vcf.gz $name1.bam
for file in *genotyped.vcf;  do python3 fillter1.py $file; done
##filter1.py
#!/usr/bin/python3
import sys
import re

infile = sys.argv[1]
name = re.search(r'(.*)\.vcf',infile)[1]
outfile = name + '.filter.vcf'
o = open(outfile, 'w')
with open(infile, 'r') as f:
    for line in f:
        line = line.strip()
        if line.startswith('#'):
            # print(line)
            o.write(line + '\n')
            continue
        content = line.split()
        if content[5] == "0":
            continue
        # print(line)
        o.write(line + '\n')
#Manta
(1) for file in `cat sample.txt` 
do
echo "/data/01/user186/sv/software/manta-1.6.0.centos6_x86_64/bin/configManta.py --bam $i.bam --referenceFasta Ma6.final.chr.fa --runDir $file" >> run.sh
done
(2) for file in {11-AS2-1,13AS2-1,16-AS2-1}
do
echo "python /data/01/user191/svcishu/manta/$file/runWorkflow.py" >> run1.sh
done
(3) python3 filter2.py (input file: $file/results/variants/diploidSV.filter.vcf)
##filter2.py
#!/usr/bin/python3
import sys
import re

infile = sys.argv[1]
name = re.search(r'(.*)\.vcf',infile)[1]
outfile = name + '.filter.vcf'
o = open(outfile, 'w')
with open(infile, 'r') as f:
    for line in f:
        line = line.strip()
        if line.startswith('#'):
            # print(line)
            o.write(line + '\n')
            continue
        content = line.split()
        if content[5] < "20":
            continue
        # print(line)
        o.write(line + '\n')
(4) for file in `cat sample.list`
do
mv $file/results/variants/diploidSV.filter.vcf $file/results/variants/$file.filter.vcf
Done
#merge
(1)svimmer --threads 10 all.vcf.list Chr1 Chr2 Chr3 Chr4 ......
(2)./graphtyper genotype_sv Ma6.final.chr.fa input.vcf.gz --sams=bam.list --region=Chr1:start-end
###batch.py
awk '{print $1, 1, $2}' cishu.LG.fasta.fai > chrpos.bed
import os
import sys
f = open("chrpos.bed","r")
for line in f:
line = line.strip()
print("graphtyper genotype_sv Ma6.final.chr.fa merge.vcf.gz --sams=bam.list --region=" + line)
f.close()
(3)cat vcf.list | awk '{print $1,$2="-I"}' | awk '{print $2,$1}' | tr "\n" " "
gatk MergeVcfs -I concat-a.vcf -I concat-b.vcf -O combine_gatk.vcf
(4)bcftools view --include "SVMODEL='AGGREGATED'" -Oz -o get_agg.vcf.gz combine_gatk.vcf
(5)vcftools --vcf get_agg.vcf --max-missing 0.95 --recode --recode-INFO-all --out vcftools-filliter

