#ab initio prediction
##busco_traning
busco -i Ma6.final.chr.fasta -l /data/01/user157/fenshu/HIFI/annotation/02.gene_annotation/00.denovo/00.augustus/00.busco_training/mammalia_odb10 -m genome --long -o Ma6.busco.training -c 80 -f
##Augustus_buscotraning
/data/00/software/augustus/augustus-3.3.3/bin/augustus --species=BUSCO_busco_Ma6 Ma6.final.chr.fa.mask_soft | perl ConvertFormat_augustus.pl - Ma6.final.chr.fa.busco.gff
##Augustus_human
/data/00/software/augustus/augustus-3.3.3/bin/augustus --species=human Ma6.final.chr.fa.mask_soft | perl ConvertFormat_augustus.pl - Ma6.final.chr.fa.species.gff
#homology-based gene prediction
##GeMoMa
java -jar /data/00/user/user157/miniconda3/envs/GeMoMa/share/gemoma-1.7.1-0/GeMoMa-1.7.1.jar CLI GeMoMaPipeline threads=30 t=Ma6.final.chr.fa s=own g=Chinese.hamster.genome.fa a=Chinese.hamster.genomic.gff outdir=Chinese.hamster.results AnnotationFinalizer.r=NO tblastn=false;perl /data/01/user191/YJW/utils/ConvertFormat_GeMoMa.pl Chinese.hamster.results/final_annotation.gff
java -jar /data/00/user/user157/miniconda3/envs/GeMoMa/share/gemoma-1.7.1-0/GeMoMa-1.7.1.jar CLI GeMoMaPipeline threads=30 t=Ma6.final.chr.fa s=own g=E.baileyi.genome.fa a=E.baileyi.genomic.gff outdir=E.baileyi.results AnnotationFinalizer.r=NO tblastn=false;perl /data/01/user191/YJW/utils/ConvertFormat_GeMoMa.pl E.baileyi.results/final_annotation.gff
java -jar /data/00/user/user157/miniconda3/envs/GeMoMa/share/gemoma-1.7.1-0/GeMoMa-1.7.1.jar CLI GeMoMaPipeline threads=30 t=Ma6.final.chr.fa s=own g=E.fontanierii.genome.fa a=E.fontanierii.genomic.gff outdir=E.fontanierii.results AnnotationFinalizer.r=NO tblastn=false;perl /data/01/user191/YJW/utils/ConvertFormat_GeMoMa.pl E.fontanierii.results/final_annotation.gff
java -jar /data/00/user/user157/miniconda3/envs/GeMoMa/share/gemoma-1.7.1-0/GeMoMa-1.7.1.jar CLI GeMoMaPipeline threads=30 t=Ma6.final.chr.fa s=own g=golden_hamster.genome.fa a=golden_hamster.genomic.gff outdir=golden_hamster.results AnnotationFinalizer.r=NO tblastn=false;perl /data/01/user191/YJW/utils/ConvertFormat_GeMoMa.pl golden_hamster.results/final_annotation.gff
java -jar /data/00/user/user157/miniconda3/envs/GeMoMa/share/gemoma-1.7.1-0/GeMoMa-1.7.1.jar CLI GeMoMaPipeline threads=30 t=Ma6.final.chr.fa s=own g=spalax.genome.fa a=spalax.genomic.gff outdir=spalax.results AnnotationFinalizer.r=NO tblastn=false;perl /data/01/user191/YJW/utils/ConvertFormat_GeMoMa.pl spalax.results/final_annotation.gff
java -jar /data/00/user/user157/miniconda3/envs/GeMoMa/share/gemoma-1.7.1-0/GeMoMa-1.7.1.jar CLI GeMoMaPipeline threads=30 t=Ma6.final.chr.fa s=own g=mouse.genome.fa a=mouse.genomic.gff outdir=mouse.results AnnotationFinalizer.r=NO tblastn=false;perl /data/01/user191/YJW/utils/ConvertFormat_GeMoMa.pl mouse.results/final_annotation.gff
java -jar /data/00/user/user157/miniconda3/envs/GeMoMa/share/gemoma-1.7.1-0/GeMoMa-1.7.1.jar CLI GeMoMaPipeline threads=30 t=Ma6.final.chr.fa s=own g=rat.genome.fa a=rat.genomic.gff outdir=rat.results AnnotationFinalizer.r=NO tblastn=false;perl /data/01/user191/YJW/utils/ConvertFormat_GeMoMa.pl rat.results/final_annotation.gff
#exonarate
/data/01/user157/software/exonarate/exonerate-2.2.0-x86_64/bin/exonerate -t Ma6.final.chr.fa -q fix_75.uniprot.faa -T dna -Q protein --softmasktarget yes --softmaskquery no --minintron 20 --maxintron 600000 --fsmmemory 200000 --dpmemory 200000 --showvulgar no --showalignment no --showquerygff no --showtargetgff yes --ryo "AveragePercentIdentity: %pi\n" > exonerate_out/Ma6.final.chr.fa.out && perl /data/01/user157/fenshu/HIFI/annotation/02.gene_annotation/02.homologous/01.exonerate/exonerate2evm.pl exonerate_out/Ma6.final.chr.fa.out | awk 'BEGIN{i=0};{if($0~/alignment_id 1\s/){i++};print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t" "ID=match_NO_" i ";AveragePercentIdentity="$19 }' | grep -v "line" | awk -F "=" '$3>80' > exonerate_convert/Ma6.final.chr.fa.convert
#transcriptome-based prediction
##trnasdecoder
hisat2-build -p 20 Ma6.final.chr.fasta Ma6
for i in `cat sample.id`;hisat2 -x Ma6 -p 20 -X 500 --dta --fr --min-intronlen 20 --max-intronlen 600000 -1 ${i}_1.fq.gz -2 ${i}_2.fq.gz -S $i.sam 2>> $i.txt  && samtools view -bS $i.sam | samtools sort -@ 20 -o $i.bam
samtools merge  -@ 28 Ma6.merged.bam `ls *bam`
/data/01/user157/software/stringtie/stringtie -p 30 -o Ma6.stringtie.gtf ../02.hisat_mapping/01.bam/Ma6/Ma6.merged.bam
gffread -w Ma6.stringtie_transcript.fa -g Ma6.final.chr.fasta Ma6.stringtie.gtf
##pasapipeline
Trinity --max_memory 80G --CPU 30 --jaccard_clip  --genome_guided_bam Ma6.merged.bam --genome_guided_max_intron 10000 --output Ma6.trinity_genomeGuided
Trinity --seqType fq --max_memory 180G --full_cleanup --left Ma1.flesh_1.fq.gz,Ma1.heart_1.fq.gz,Ma1.kidney_1.fq.gz,Ma1.liver_1.fq.gz,Ma1.lung_1.fq.gz,Ma2.flesh_1.fq.gz,Ma2.heart_1.fq.gz,Ma2.liver_1.fq.gz,Ma4.flesh_1.fq.gz,Ma4.kidney_1.fq.gz,Ma4.lung_1.fq.gz,Ma6.flesh_1.fq.gz,Ma6.liver_1.fq.gz,Ma6.lung_1.fq.gz --right Ma1.flesh_2.fq.gz,Ma1.heart_2.fq.gz,Ma1.kidney_2.fq.gz,Ma1.liver_2.fq.gz,Ma1.lung_2.fq.gz,Ma2.flesh_2.fq.gz,Ma2.heart_2.fq.gz,Ma2.liver_2.fq.gz,Ma4.flesh_2.fq.gz,Ma4.kidney_2.fq.gz,Ma4.lung_2.fq.gz,Ma6.flesh_2.fq.gz,Ma6.liver_2.fq.gz,Ma6.lung_2.fq.gz --CPU 40 --output Ma6.trinity.denove
perl -e 'while (<>) { print "$1\n" if />(\S+)/ }' Ma6.trinity.denove.Trinity.fasta  > tdn.accs
cat Ma6.trinity.denove.Trinity.fasta  trinity_genomeGuided/Trinity-GG.fasta >  transcripts.fasta
seqclean transcripts.fasta -v vectors.fasta
Launch_PASA_pipeline.pl -c alignAssembly.config -C -R -g Ma6.final.chr.fasta -t transcripts.fasta.clean -T -u transcripts.fasta --ALIGNERS blat --CPU 20 --TDN tdn.accs > pasa.log
#EVidenceModeler
##weight.txt
ABINITIO_PREDICTION     augustus.busco  5
ABINITIO_PREDICTION     augustus.human  5
ABINITIO_PREDICTION     genscan 3
OTHER_PREDICTION        transdecoder    20
PROTEIN chinese.hamster 10
PROTEIN e.baileyi       10
PROTEIN e.fontanierii   10
PROTEIN exonerate       10
PROTEIN golden_hamster  10
PROTEIN mouse   10
PROTEIN rat     10
PROTEIN spalax  10
TRANSCRIPT      RNA_SEQ 20
##EVM 
EVM.prepare.pl /data/00/software/EVM/EVM_V1.1.1/EVidenceModeler-1.1.1 01.abinitio 02.homologs 03.RNA 04.evm
EVM.run.cmd.pl /data/00/software/EVM/EVM_V1.1.1/EVidenceModeler-1.1.1 Ma6.final.chr.fasta-split 04.evm utils > 01.split_prepare.sh
parallel -j 30 < 01.split_prepare.sh
cat 04.evm/evm_for_each_chr/*/split_evm_running.sh > 04.evm/02.split_run.sh
parallel -j 30 < 04.evm/02.split_run.sh 
cat 04.evm/evm_for_each_chr/*/commands.list > 04.evm/03.running.sh
parallel -j 30 < 04.evm/03.running.sh
perl EVM.merge.cmd.pl 03.gene_predict/04.evm/evm_for_each_chr /data/00/software/EVM/EVM_V1.1.1/EVidenceModeler-1.1.1 > 04.evm/04.merge.sh
parallel -j 30 < 04.evm/04.merge.sh
cat 04.evm/evm_for_each_chr/*/evm.out.gff > 04.evm/merge.out.gff


