#!/bin/bash

# Specify important variables
DIR=/home/adway/Desktop/Data_fcd
TUTORIAL_DIR=/home/adway       #location of experiment folder
export SUBJECTS_DIR=$TUTORIAL_DIR/freesurfer/subjects  #location of freesurfer folder

for id in 1001 #$(seq -w 1001 1010)
do
    echo "working on s$id"
    #recon-all -subjid s$id -localGI
    cd ${SUBJECTS_DIR}/s${id}/surf
    mri_surf2vol --o lh_lhlgi.nii.gz --subject s${id} --so lh.white lh.pial_lgi
    mri_surf2vol --o lh_rhlgi.nii.gz --subject s${id} --so lh.white rh.pial_lgi
    mri_surf2vol --o rh_lhlgi.nii.gz --subject s${id} --so rh.white lh.pial_lgi
    mri_surf2vol --o rh_rhlgi.nii.gz --subject s${id} --so rh.white rh.pial_lgi
    mris_calc --output lh.nii.gz lh_lhlgi.nii.gz sub lh_rhlgi.nii.gz
    mris_calc --output rh.nii.gz rh_lhlgi.nii.gz sub rh_rhlgi.nii.gz
    mris_calc --output ${SUBJECTS_DIR}/s${id}/interasymm_s$id.nii.gz lh.nii.gz add rh.nii.gz
    cp -rf ${SUBJECTS_DIR}/s${id}/interasymm_s$id.nii.gz ${DIR}/interasymm.nii.gz
    echo "s$id finished"
done
