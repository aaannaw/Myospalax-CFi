perl 00.rename.pl Ma.genome.gff Ma.genome.rename.gff Ma
perl 00.rename.pl Mp.genome.gff Mp.genome.rename.gff Mp
perl 00.rename.pl E.fontanierii.genome.gff Efon.genome.rename.gff Efon
perl 00.rename.pl E.cansus.genome.gff Eca.genome.rename.gff Eca
perl 00.rename.pl S.carmeli.genome.gff Spalax.genome.rename.gff Spalax
perl 00.rename.pl R.norvegicus.genome.gff Rat.genome.rename.gff Rat
/data/01/p1/user157/software/iTools_Code/iTools Fatools getCdsPep -Ref  Ma6.final.onlychr.fa -Gff Ma.genome.rename.gff -OutPut Ma
/data/01/p1/user157/software/iTools_Code/iTools Fatools getCdsPep -Ref  Mp5.final.onlychr.fa -Gff Mp.genome.rename.gff -OutPut Mp
/data/01/p1/user157/software/iTools_Code/iTools Fatools getCdsPep -Ref  Efon.final.onlychr.fa -Gff Efon.genome.rename.gff -OutPut Efon
/data/01/p1/user157/software/iTools_Code/iTools Fatools getCdsPep -Ref  Eca.final.onlychr.fa -Gff Eca.genome.rename.gff -OutPut Eca
/data/01/p1/user157/software/iTools_Code/iTools Fatools getCdsPep -Ref  Spalax.final.onlychr.fa -Gff Spalax.genome.rename.gff -OutPut Spalax
/data/01/p1/user157/software/iTools_Code/iTools Fatools getCdsPep -Ref  Rat.final.onlychr.fa -Gff Rat.genome.rename.gff -OutPut Rat
awk '{if($3=="gene")print}' Ma.genome.rename.gff| awk -F ";" '{print $1}' | cut -f 1,4,5,9 | sed 's/ID=//g' | awk '{print $1"\t"$4"\t"$2"\t"$3}' > Ma.gff
awk '{if($3=="gene")print}' Mp.genome.rename.gff| awk -F ";" '{print $1}' | cut -f 1,4,5,9 | sed 's/ID=//g' | awk '{print $1"\t"$4"\t"$2"\t"$3}' > Mp.gff
awk '{if($3=="gene")print}' Efon.genome.rename.gff| awk -F ";" '{print $1}' | cut -f 1,4,5,9 | sed 's/ID=//g' | awk '{print $1"\t"$4"\t"$2"\t"$3}' > Efon.gff
awk '{if($3=="gene")print}' Eca.genome.rename.gff| awk -F ";" '{print $1}' | cut -f 1,4,5,9 | sed 's/ID=//g' | awk '{print $1"\t"$4"\t"$2"\t"$3}' > Eca.gff
awk '{if($3=="gene")print}' Spalax.genome.rename.gff| awk -F ";" '{print $1}' | cut -f 1,4,5,9 | sed 's/ID=//g' | awk '{print $1"\t"$4"\t"$2"\t"$3}' > Spalax.gff
awk '{if($3=="gene")print}' Rat.genome.rename.gff| awk -F ";" '{print $1}' | cut -f 1,4,5,9 | sed 's/ID=//g' | awk '{print $1"\t"$4"\t"$2"\t"$3}' >Rat.gff
perl 01.phase.gff2wgdi.pl
perl 01.wgdi.pl
cd Ma-Efon
diamond_blastp.pl All.pep All.pep 200 | sh
/data/00/user/user157/miniconda3/envs/wgdi/bin/wgdi -d total.conf;
