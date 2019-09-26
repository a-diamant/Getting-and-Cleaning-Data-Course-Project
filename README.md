****************************************************************
Peer-graded Assignment: Getting and Cleaning Data Course Project
by Anna Diamant
*****************************************************************
_______________
INTRODUCTION
_______________
The repository contains README file, codebook and run_analysis.R script.

The data used come from Human Activity Recognition Using Smartphones Data Set (1)

The original dataset by David Anguita and al. contains the results of experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured.
_____________________________________
	THE DATA ANALYSIS
_____________________________________
Since the initial dataset was divided into training and testing data sets, i have merged them together for purpose of my course project.

As a next step i used a 561-feature vector with time and frequency domain variables provided in with data set to label all of the variables with their names.

The activity names (like WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) were initialy coded with numbers separetly for training and test data sets. For my merged data set i have merged both activity coding vectors into one and assigned the coded names to my merged data set. After that, i changed the coded names to words based on the information in activity_labeles.txt file

The similar steps i did with identification numbers of person who performed the experiments. As before, i merged two vectors into one and assigned the obtained IDs to my dataset. 

On this step we have a big dataset with all the measurements clearly labeled with the activities names, their coded names and person's id.
Here we come back to the step#2 of coursera assigment and extract the data needed - the measurements on the mean and standard deviation for each measurement.

In a final part of my analysis I create a tidy data set with averaged numbers of mean measurements and standart deveation measurements accordign to person's id and activity performed.


___________________________________________________________________
(1) Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
