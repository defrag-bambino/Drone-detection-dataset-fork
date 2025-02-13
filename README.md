MODIFICATIONS: changed the Create_a_dataset_from_vidoes_and_labels.m file to convert the given MATLAB dataset into yolov5 format. Follow the instructions in the file's comments.



# Drone-detection-dataset
Dataset containing IR, visible and audio data that can be used to train and evaluate drone detection sensors and systems.

Video labels: Airplane, Bird, Drone and Helicopter.
Audio labels: Drone, Helicopter and Background.

The dataset contains 90 audio clips and 650 videos (365 IR and 285 visible). If all images are extracted from all the videos the dataset has a total of 203328 annotated images.

Free to download, use and edit.
Descriptions of the videos are found in "Video_dataset_description.xlsx".
The videos can be used as they are, or together with the respective label-files.
The annotations are in .mat-format and have been done using the Matlab video labeler.
Some instructions and examples are found in "Create_a_dataset_from_videos_and_labels.m"

Please cite:  
"Svanström F. (2020). Drone Detection and Classification using Machine Learning and Sensor Fusion".
[Link to thesis](https://hh.diva-portal.org/smash/get/diva2:1434532/FULLTEXT02.pdf)  
or  
"Svanström F, Englund C and Alonso-Fernandez F. (2020). Real-Time Drone Detection and Tracking With Visible, Thermal and Acoustic Sensors".
[Link to ICPR2020-paper](https://arxiv.org/pdf/2007.07396.pdf)  
or  
"Svanström F, Alonso-Fernandez F and Englund C. (2021). A Dataset for Multi-Sensor Drone Detection".
[Link to Data in Brief](https://www.sciencedirect.com/science/article/pii/S2352340921007976#!)

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.5500576.svg)](http://dx.doi.org/10.5281/zenodo.5500576)

Contact:  
DroneDetectionThesis@gmail.com
