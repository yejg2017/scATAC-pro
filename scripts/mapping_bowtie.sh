#!/bin/bash



input_ff=$1
fastqs=(${input_ff//,/ })

mapRes_dir="${2}"


echo "Starting bowtie alignment ... "
${BOWTIE_PATH}/bowtie -1 ${fastqs[0]} -2 ${fastqs[1]} $BOWTIE_INDEX -S $BOWTIE_OPTS > ${mapRes_dir}/${OUTPUT_PREFIX}.bowtie.sam 

echo "Bowtie Mapping Done!"


## convert to bam
echo "Converting sam to bam ... "
ncore=$(nproc --all)
ncore=$(($ncore - 1))

${SAMTOOLS_PATH}/samtools view -@ $ncore -h -bS ${mapRes_dir}/${OUTPUT_PREFIX}.bowtie.sam > ${mapRes_dir}/${OUTPUT_PREFIX}.bowtie.bam

#rm ${mapRes_dir}/${OUTPUT_PREFIX}.bowtie.sam

