#LASTZ alignment
/data/01/user151/software/USCS_tools/faToTwoBit Ma6.softmask.fasta Ma6.softmask.fasta.2bit
/data/01/user151/software/USCS_tools/faToTwoBit Mp5.softmask.fasta Mp5.softmask.fasta.2bit
/data/01/user151/software/USCS_tools/faToTwoBit Efon.softmask.fasta Efon.softmask.fasta.2bit
/data/01/user151/software/USCS_tools/faSize Ma6.softmask.fasta -detailed -tab > Ma6.softmask.fasta.sizes
/data/01/user151/software/USCS_tools/faSize Mp5.softmask.fasta -detailed -tab > Mp5.softmask.fasta.sizes
/data/01/user151/software/USCS_tools/faSize Efon.softmask.fasta -detailed -tab > Efon.softmask.fasta.sizes
/data/00/user/user157/lastz-distrib/bin/lastz Ma6.softmask.fasta.2bit Mp5.softmask.fasta.2bit  K=2400 L=3000 Y=9400 H=2000 --format=axt --ambiguous=iupac --ambiguous=n > Ma-Mp.axt
/data/00/user/user157/lastz-distrib/bin/lastz Ma6.softmask.fasta.2bit Efon.softmask.fasta.2bit  K=2400 L=3000 Y=9400 H=2000 --format=axt --ambiguous=iupac --ambiguous=n > Ma-Efon.axt
USCS_tools/axtChain -minScore=3000 -linearGap=medium Ma-Mp.axt  Ma6.softmask.fasta.2bit Mp5.softmask.fasta.2bit Ma-Mp.chain
USCS_tools/axtChain -minScore=3000 -linearGap=medium Ma-Mp.axt  Ma6.softmask.fasta.2bit Efon.softmask.fasta.2bit Ma-Efon.chain
USCS_tools/chainMergeSort Ma-Mp.chain > Ma-Mp.sort.chain
USCS_tools/chainMergeSort Ma-Efon.chain > Ma-Efon.sort.chain
python3 RepeatFiller.py -c Ma-Mp.sort.chain -T2  Ma6.softmask.fasta.2bit -Q2 Mp5.softmask.fasta.2bit > Ma-Mp.repeatfiller.chain
python3 RepeatFiller.py -c Ma-Mp.sort.chain -T2  Ma6.softmask.fasta.2bit -Q2 Efon.softmask.fasta.2bit > Ma-Efon.repeatfiller.chain
chainCleaner Ma-Mp.repeatfiller.chain Ma6.softmask.fasta.2bit Mp5.softmask.fasta.2bit -tSizes=Ma6.softmask.fasta.sizes -qSizes=Mp5.softmask.fasta.sizes Ma-Mp.cleanchainer.chain Ma-Mp.bed -linearGap=medium
chainCleaner Ma-Efon.repeatfiller.chain Ma6.softmask.fasta.2bit Efon.softmask.fasta.2bit -tSizes=Ma6.softmask.fasta.sizes -qSizes=Efon.softmask.fasta.sizes Ma-Efon.cleanchainer.chain Ma-Efon.bed -linearGap=medium
chainPreNet Ma-Mp.cleanchainer.chain Ma6.softmask.fasta.sizes Mp5.softmask.fasta.sizes Mp.prenet.chain
chainPreNet Ma-Efon.cleanchainer.chain Ma6.softmask.fasta.sizes Efon.softmask.fasta.sizes Efon.prenet.chain
chainNet -rescore Mp.prenet.chain Ma6.softmask.fasta.sizes Mp5.softmask.fasta.sizes -tNibDir=Ma6.softmask.fasta.2bit  -qNibDir=Mp5.softmask.fasta.2bit  -linearGap=medium Ma-Mp.prenet Mp.prenet 
chainNet -rescore Efon.prenet.chain Ma6.softmask.fasta.sizes Efon.softmask.fasta.sizes -tNibDir=Ma6.softmask.fasta.2bit  -qNibDir=Efon.softmask.fasta.2bit  -linearGap=medium Ma-Efon.prenet Efon.prenet
netSyntenic Ma-Mp.prenet Ma-Mp.net
netSyntenic Ma-Efon.prenet Ma-Efon.net
NetFilterNonNested.perl -doUCSCSynFilter -keepSynNetsWithScore 5000 -keepInvNetsWithScore 5000 Ma-Mp.net> Ma-Mp.filter.net
NetFilterNonNested.perl -doUCSCSynFilter -keepSynNetsWithScore 5000 -keepInvNetsWithScore 5000 Ma-Efon.net> Ma-Efon.filter.net
#DESCHRAMBLER
DESCHRAMBLER.pl params.txt
The output "APCFs.300K/SFs/Conserved.segments" was taken as the input of ANGEs.
#ANGEs
python src_path/MASTER/anges_CAR_UI.py









