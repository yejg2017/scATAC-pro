#!/bin/bash



input_ff=$1
fastqs=(${input_ff//,/ })

mapRes_dir="${2}"


echo "Starting bowtie2 alignment ... "
${MAPPING_PATH}/bowtie2 -1 ${fastqs[0]} -2 ${fastqs[1]} -x $BOWTIE2_INDEX  $MAPPING_OPTS -S ${mapRes_dir}/${SAMPLE_PREFIX}.bowtie2.sam 

echo "Bowtie2 Mapping Done!"


## convert to bam
echo "Converting sam to bam ... "
${SAMTOOLS_PATH}/samtools view -h -bS ${mapRes_dir}/${SAMPLE_PREFIX}.bowtie2.sam > ${mapRes_dir}/${SAMPLE_PREFIX}.bowtie2.bam

#rm ${mapRes_dir}/${SAMPLE_PREFIX}.bowtie.sam

