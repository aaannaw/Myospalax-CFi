samtools view ../M.aspalax.6.1.ccs.bam  | awk '{print ">"$1"\n"$10}' > M.aspalax.6.1.fasta
samtools view ../M.aspalax.6.2.ccs.bam  | awk '{print ">"$1"\n"$10}' > M.aspalax.6.2.fasta
samtools view ../M.aspalax.6.3.ccs.bam  | awk '{print ">"$1"\n"$10}' > M.aspalax.6.3.fasta
hifiasm -o M.aspalax.6 -t 30 M.aspalax.6.1.fasta M.aspalax.6.2.fasta M.aspalax.6.3.fasta > M.aspalax.6.log
awk '/^S/{print ">"$2;print $3}' M.aspalax.6.p_ctg.gfa > M.aspalax.6.p_ctg.fa
