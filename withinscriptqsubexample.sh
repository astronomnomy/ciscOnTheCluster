#! /bin/bash

echo "here I can do all my normal bash commands"

echo "running within script qsub example, this should print to screen"
echo "submitting job"

cat << EOF | qsub -q cisc.q -sync n
#$ -j y
#$ -cwd
#$ -S /bin/bash
#$ -N script_qsub
#$ -pe mpich 2
#$ -o script_qsub.log


#Here is a comment, only preceded by #. It will not be read by qsub, but lines preceded by #$ together will be.
#Load up modules 
module load fsl/cisc/5.0.7


#add 3 to all voxels in the example nifti
fslmaths ./example.nii -add 10 ./example_script_qsub.nii


#find mean of all non-zero voxels, print to screen (will be put in commandlineqsubexample.log)
fslstats /example.nii -M


#find mean of all non-zero voxels, print to screen (will overwrite new file and put in cmd_qsub_results.txt)
fslstats /example.nii -M > ./script_qsub_results.txt


#find mean of all non-zero voxels, print to screen (will be ADDED to the new file and put in cmd_qsub_results.txt)
fslstats /example_script_qsub.nii -M >> ./script_qsub_results.txt

EOF
