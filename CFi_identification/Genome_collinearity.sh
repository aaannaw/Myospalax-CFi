#Mummer
mummer-4.0.0rc1/bin/nucmer --mum --mincluster 500 -t 30 01.Ma6.onlyChr.softmask.fasta 01.Mp5.onlyChr.softmask.fasta -p 02.Ma6-Mp5
ummer-4.0.0rc1/delta-filter  -1 -i 90 -l 1000 02.Ma6-Mp5.delta > 03.Ma6-Mp5.filter.delta
mummer-4.0.0rc1/show-coords -c -r  -l 03.Ma6-Mp5.filter.delta > 04.Ma6-Mp5.filter.coords
awk -F "|" '{print $7"\t"$1"\t"$2}' 04.Ma6-Mp5.filter.coords| tr "\t" " " | awk  -F " " '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6}' |  awk  '{if($4>$3){print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t""+"}else{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t""-"}}'| awk  '{if($6>$5){print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t""+"}else{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t""-"}}'| awk '{print $1"\t"$3"\t"$4"\t"$7"\t"$2"\t"$5"\t"$6"\t"$8}' > 05.Ma-Mp.record
awk '{print $1"_"$2"\t"$1"_"$3"\t"$5"_"$6"\t"$5"_"$7"\t500\t"$8}'  05.Ma-Mp.record > 06.Ma-Mp.record.simple 
awk '{print $5"\t"$6-1"\t"$6+1"\t"$5"_"$6"\t0\t"$8"\n"$5"\t"$7-1"\t"$7+1"\t"$5"_"$7"\t0\t"$8}' 05.Ma-Mp.record > 07.Ma.bed 
awk '{print $1"\t"$2-1"\t"$2+1"\t"$1"_"$2"\t0\t"$4"\n"$1"\t"$3-1"\t"$3+1"\t"$1"_"$3"\t0\t"$4}' 05.Ma-Mp.record > 08.Mp.bed
awk '{print $1}' 07.Ma.bed |sort -u > 09.Ma.seqids
awk '{print $1}' 08.Mp.bed |sort -u > 10.Mp.seqids
cat 09.Ma.seqids 10.Mp.seqids > all.seqids
#jcvi plot
##layout 
# y, xstart, xend, rotation, color, label, va,  bed
 .7,     0.1,    0.9,       0,     #1ec2b4, Ma, top, 07.Ma.bed
 .3,     0.1,    0.9,       0,     #007ba3, Mp, top, 08.Mp.bed
#edges
e, 0, 1, 06.Ma-Mp.record.simple 
python3 -m jcvi.graphics.karyotype all.seqids  layout

