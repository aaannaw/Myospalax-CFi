bwa index M.aspalax.6.p_ctg.fasta
python2 enerate_site_positions.py  MboI  M.aspalax.6_MboI  M.aspalax.6.p_ctg.fasta 
awk 'BEGIN{OFS="\t"}{print $1, $NF}' Ma_MboI.txt > M.aspalax.6.chrom.sizes
/data/01/user164/software/juicer/scripts/juicer.sh -z /data/01/user164/workspace/HiC_0429/juicer/Maspalax6/reference/M.aspalax.6.p_ctg.fasta -p /data/01/user164/workspace/HiC_0429/juicer/Maspalax6/restriction_sites/M.aspalax.6.chrom.sizes -y /data/01/user164/workspace/HiC_0429/juicer/Maspalax6/restriction_sites/M.aspalax.6_MboI.txt -d /data/01/user164/workspace/HiC_0429/juicer/Maspalax6/data -D /data/01/user164/software/juicer -g Maspalax6 -s MboI -t 30 -S early
/data/01/user164/software/3d-dna/run-asm-pipeline.sh -r 2 --sort-output /data/01/user164/workspace/HiC_0429/juicer/Maspalax6/reference/M.aspalax.6.p_ctg.fasta /data/01/user164/workspace/HiC_0429/juicer/Maspalax6/data/aligned/merged_nodups.txt
juicebox correction
/data/01/user164/software/3d-dna/run-asm-pipeline-post-review.sh --sort-output -r M.aspalax.6.bp.p_ctg.0.review.assembly M.aspalax.6.bp.p_ctg.fasta merged_nodups.txt
