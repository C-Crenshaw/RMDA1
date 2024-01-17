*********************************************************************************		
/*	TITLE: 		RMDA1_Homework7-8.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 7-8. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	12/04/2023																			
*	CONTENTS:	0: Set globals
*				1: Homework Answers
*				2: Close log file
*/
*********************************************************************************

	clear all
	set more off
	pause on

*********
*	0. Set globals & start log file 
*********

	**Set file paths using globals 
	
	glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA I/"
	cd "${classpath}" 

	**Start the log file (something we'll learn about later in class)
	
	capture log close
	log using "${classpath}RMDA1_Homework7-8_log", replace 
	
*********
*	1: Homework Code
*********

use "${classpath}star.dta", clear

*QUESTION 5
*5B
*How old were students in regular classes, on average, when they started kindergarten?
summarize age if class_small==0
*Estimate the difference in average age for students in small classes
reg age class_small, cluster(id_class)

*5C
*Covariate balance test with subsidized lunch receipts instead of age
reg lunch class_small, cluster(id_class)

*QUESTION 6
*6A
*What was the average reading score of students in regular classes?
summarize score_read if class_small==0

*6B
*Estimate the effect of small classes on students' reading scores
reg score_read class_small, cluster(id_class)

*6C
*Add the baseline covariates from Question 5 (lunch, age) to tbe regression
reg score_read class_small age lunch, cluster(id_class)

*QUESTION 7
*7B
*Generate a dummy variable that identifies first-year teachers (no teaching experience)
*If the variable = 1, the teacher has no experience/is a first year teacher 
generate first_year_teach = 0 
replace first_year_teach = 1 if tch_exp == 0

distinct id_teacher if first_year_teach == 1 // Counting the teachers only once (because the dataset is organized by student, teachers are repeated)

*7C
* testscore = B0 + B1(class size) + B2(dummy teach experience) + B3(interaction)
gen class_teach_interaction_dummy = class_small * first_year_teach
reg score_read class_small first_year_teach class_teach_interaction_dummy, cluster(id_class)

*7D
* testscore = B0 + B1(class size) + B2(teach experience) + B3(interaction)
gen class_teach_interaction = class_small * tch_exp
reg score_read class_small tch_exp class_teach_interaction, cluster(id_class)

*********
*	2: Close log file
*********	
	
	log close
	translate "${classpath}RMDA1_Homework7-8_log.smcl" "${logfilepath}RMDA1_Homework7-8_log.pdf", replace
