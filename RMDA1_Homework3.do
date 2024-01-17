*********************************************************************************		
/*	TITLE: 		RMDA1_Homework3.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 3. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	09/29/2023																			
*	CONTENTS:	0: Set globals
*				1: Homework Answers
*				2: Close log file (learn about this in Week 03)
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
	log using "${classpath}RMDA1_Homework3_log", replace 

	
*********
*	1: Homework Code
*********

	**2d**
	power twoprop 0.08, n1(7950) n2(7971) alpha(0.05) beta(0.2) direction(upper)
	
	**3c**
	power twoprop 0.14, n1(7950) n2(7971) alpha(0.05) beta(0.2) direction(upper)
	
	**3d**
	power twoprop 0.14, n1(7950) n2(7971) alpha(0.01) beta(0.2) direction(upper)
	
	**3e**
	power twoprop 0.14 0.1558, alpha(0.01) beta(0.2)
	
	**3f**
	power twoprop 0.14 0.15, alpha(0.01) beta(0.2)
	
	power twoprop 0.14, n(1000(2500)60000) alpha(0.01) beta(0.2)
	

*********
*	2: Close log file
*********	
	
	log close
	translate "${classpath}RMDA1_Homework3_log.smcl" "${logfilepath}RMDA1_Homework3_log.pdf", replace
