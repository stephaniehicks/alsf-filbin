#$ -pe local 6
#$ -R y
#$ -cwd
#$ -o log/
#$ -e log/
#$ -l mem_free=20G,h_vmem=20G
#$ -t 1-576
#$ -tc 10

# set project directory path
# d=/fastscratch/myscratch/shicks1/alsf-filbin
d=/fastscratch/myscratch/akuo/alsf-filbin

# make log directory for error and output files
mkdir -p $d/scripts/log

# run salmon
samplefile=$d/sample_data/unique_cell_paths.txt;
fn=`awk -F'\r' -v var=$SGE_TASK_ID '{if(NR==var)print $1}' $samplefile`;
samp=`basename ${fn}`
samp=${samp::-2}
echo "Processing sample ${samp}"
salmon quant -i $d/salmon_files/gencode.v32_salmon-index-v1.0.0-mRNA -l A \
         -1 ${fn}1.fastq.gz \
         -2 ${fn}2.fastq.gz \
         -p 6 --validateMappings -o $d/salmon_quants/${samp}_quant
