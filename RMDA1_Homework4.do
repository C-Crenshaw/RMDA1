*********************************************************************************		
/*	TITLE: 		RMDA1_Homework4.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 4. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	10/20/2023																			
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
	log using "${classpath}RMDA1_Homework4_log", replace 
	
	use "${classpath}fertility.dta", clear
	
*********
*	1: Homework Code
*********

*QUESTION 2
	*AI.
	describe, short
		
	*AII. 
	tab voucher_individual, mi //no missing values
	
	*BI. // reg baseline characteristic x variable
	reg electric voucher_individual
	
	// check if this is correct by running a t-test
	// ttest electric, by(voucher_individual)
	
	*B2II 
	reg timesincelastbirth voucher_individual
	
	*CI. // reg Y(outcome of treatment) X
	reg used_voucher voucher_individual
	
	*CII.
	reg used_injectable voucher_individual
	
	*CIII.
	reg birth_year1 voucher_individual

*********
*	2: Close log file
*********	
	
	log close
	translate "${classpath}RMDA1_Homework4_log.smcl" "${logfilepath}RMDA1_Homework4_log.pdf", replace
