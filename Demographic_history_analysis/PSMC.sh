samtools depth $i.sort.markdup.bam -a > $i.depth
cat test.depth|awk '{sum+=$3} END {print "Average = ", sum/NR}' > $i.average.depth
samtools mpileup -C50 -u -f Ma6.final.chr.fa $i.sort.rmdup.bam  | /data/01/user194/project/psmc/bcftools-1.10/htslib-1.10/bin/bcftools call -c | vcfutils.pl vcf2fq -d 4 -D 24 | gzip > $i.fq.gz (-d:1/3 average depth, -D 2 fold average depth)
/data/01/user194/psmc/utils/fq2psmcfa -q20 $i.fq.gz > diploid.psmcfa
/data/01/user194/psmc/utils/splitfa $i.psmcfa > split.psmcfa
/data/00/user/user194/lifang/lf/psmc/psmc -N25 -t15 -r5 -p “4+25*2+4+6” -o diploid.psmc diploid.psmcfa   
seq 100 | xargs -i echo /data/00/user/user194/lifang/lf/psmc/psmc -N25 -t15 -r5 -b -p “4+25*2+4+6” -o round-{}.psmc split.psmcfa | sh
cat diploid.psmc ronud-*.psmc > combined.psmc
/data/01/user194/project/psmc/utils/psmc_plot.pl -u 3.03e-09 -g 1 -R -x 1e3 -X 1e7 Ebaileyi1.combined combined.psmc
