#$ -j y
#$ -cwd
#$ -S /bin/bash
#$ -N cmd_qsub
#$ -pe mpich 2
#$ -o cmd_qsub.log

echo "running command line qsub example, this should be saved out in the log"
echo "submitting job"

#Here is a comment, only preceded by #. It will not be read by qsub, but lines preceded by #$ together will be.
#Load up modules 
module load fsl/cisc/5.0.7


#add 3 to all voxels in the example nifti
fslmaths ./example.nii -add 3 ./example_cmd_qsub.nii


#find mean of all non-zero voxels, print to screen (will be put in commandlineqsubexample.log)
fslstats /example.nii -M


#find mean of all non-zero voxels, print to screen (will overwrite new file and put in cmd_qsub_results.txt)
fslstats /example.nii -M > ./cmd_qsub_results.txt


#find mean of all non-zero voxels, print to screen (will be ADDED to the new file and put in cmd_qsub_results.txt)
fslstats /example_cmd_qsub.nii -M >> ./cmd_qsub_results.txt
