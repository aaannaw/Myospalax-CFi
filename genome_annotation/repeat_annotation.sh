#RepeatModeler
/data/00/software/Repeatmask/RepeatModeler-2.0/BuildDatabase -name Ma Ma6.final.chr.fa
/data/00/software/Repeatmask/RepeatModeler-2.0/RepeatModeler -pa 30 -database Ma
ln -s RM*/consensi.fa.classified custom.lib
/data/00/software/Repeatmask/RepeatMasker/RepeatMasker -pa 30 -lib ./custom.lib Ma6.final.chr.fa
perl /data/01/user191/YJW/utils/ConvertRepeatMasker2gff.pl Ma6.final.chr.fa.out Denovo.gff Denovo
#RepeatMasker
/data/00/software/Repeatmask/RepeatMasker/RepeatMasker -pa 30  -nolow -norna -no_is -gff -species rattus Ma6.final.chr.fa
perl /data/01/user191/YJW/utils/ConvertRepeatMasker2gff Ma6.final.chr.fa.out TE.gff TE
#LTRretriever
/data/00/user/user101/software/LTR_FINDER_parallel/LTR_FINDER_parallel -seq Ma6.final.chr.fa -threads 30 -harvest_out -size 5000000 -time 3000
perl /data/00/user/user101/software/gene_annot_lzu_v2/utils/SplitRunLTRharvest.pl Ma6.final.chr.fa /data/00/user/user105/software/LTR_harvest/gt-1.5.10-Linux_x86_64-64bit-complete/bin/gt LTRretriever 30
cat Ma6.final.chr.fa.finder.combine.scn LTRretriever.harvest.scn > ./LTRretriever.merged.scn
LTR_retriever -genome Ma6.final.chr.fa -inharvest LTRretriever.merged.scn -threads 30
ln -s LTRretriever/03.LTR_retriever/Ma6.final.chr.fa.LTRlib.redundant.fa .
ln -s ../01.repeatmodeler/custom.lib .
cat custom.lib Ma6.final.chr.fa.LTRlib.redundant.fa /data/00/software/Repeatmask/RepeatMasker/Libraries/RepeatMasker.lib > custom.lib.fix.fa
/data/00/software/Repeatmask/RepeatMasker/RepeatMasker -pa 30 -lib ./custom.lib.fix.fa Ma6.final.chr.fa
perl /data/01/user191/YJW/utils/ConvertRepeatMasker2gff.pl Ma6.final.chr.fa.out Denovo.gff Denovo
#RepeatProteinMask
/data/00/software/Repeatmask/RepeatMasker/RepeatProteinMask -noLowSimple -pvalue 1e-04 Ma6.final.chr.fa
perl /data/01/user191/YJW/utils/ConvertRepeatMasker2gff.pl Ma6.final.chr.fa.repeatproteinmasker.annot TP.gff TP
#trf
/data/01/user157/software/TRF/build/bin/trf  Ma6.final.chr.fa 2 7 7 80 10 50 2000 -d -h
perl /data/01/user191/YJW/utils/ConvertTrf2Gff.pl  Ma6.final.chr.fa.2.7.7.80.10.50.2000.dat  Ma6.final.chr.fa.trf.gff
#statistics
ln -s ../LTRretriever/Denovo.gff ./Denovo.gff
ln -s ../02.repeatmakser/TE.gff ./TE.gff
ln -s ../03.repeatproteinmask/TP.gff ./TP.gff
ln -s ../04.trf/Ma6.final.chr.fa.trf.gff ./TRF.gff
cat Denovo.gff TE.gff TP.gff TRF.gff | grep -v -P '^#' | cut -f 1,4,5 | sort -k1,1 -k2,2n -k3,3n > All.repeat.bed
bedtools merge -i All.repeat.bed > All.repeat.merge.bed
bedtools maskfasta -fi Ma6.final.chr.fa -bed All.repeat.merge.bed -fo Ma6.final.chr.fa.mask
bedtools maskfasta -fi Ma6.final.chr.fa -bed All.repeat.merge.bed -fo Ma6.final.chr.fa.mask_soft -soft
grep -v 'Class=Unknown;' Denovo.gff > Denovo.gff.known
grep -v 'Class=Unknown;' TE.gff > TE.gff.known
grep -v 'Class=Unknown;' TP.gff > TP.gff.known
grep -v 'Class=Unknown;' TRF.gff > TRF.gff.known
perl /data/00/user/user101/software/gene_annot_lzu_v2/utils/bed_intersect.pl  TRF.gff.known Denovo.gff.known TRF.gff.known.noDenovo
perl /data/00/user/user101/software/gene_annot_lzu_v2/utils/bed_intersect.pl  TP.gff.known Denovo.gff.known TP.gff.known.noDenovo
perl /data/00/user/user101/software/gene_annot_lzu_v2/utils/bed_intersect.pl  TE.gff.known Denovo.gff.known TE.gff.known.noDenovo
perl /data/00/user/user101/software/gene_annot_lzu_v2/utils//gff_rep_summary.pl final_rep_dir Denovo.gff.known TE.gff.known.noDenovo TRF.gff.known.noDenovo  TP.gff.known.noDenovo
perl /data/00/user/user101/bin/lenbed.pl All.repeat.merge.bed > All.repeat.merge.bed.len
cat final_rep_dir/99.SUMMARY2 final_rep_dir/99.SUMMARY3 All.repeat.merge.bed.len > SUMMARY.FINAL.txt
