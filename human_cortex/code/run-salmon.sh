#$ -pe local 6
#$ -R y
#$ -cwd
#$ -l mem_free=10G,h_vmem=15G

# set project directory path
# d=/fastscratch/myscratch/shicks1/alsf-filbin
d=/fastscratch/myscratch/akuo/alsf-filbin

for fn in `cat $d/sample_data/unique_cell_paths.txt`; 
do 
samp=`basename ${fn}`
samp=${samp::-2}
echo "Processing sample ${samp}"
salmon quant -i $d/salmon_files/gencode.v32_salmon-index-v1.0.0 -l A \
         -1 ${fn}1.fastq.gz \
         -2 ${fn}2.fastq.gz \
         -p 6 --validateMappings -o $d/salmon_quants/${samp}_quant
done
