*********************************************************************************		
/*	TITLE: 		RMDA1_Homework2.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 2. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	09/14/2023															
*	CALLS UPON:	"${rawdatapath}peer_pressure.dta"					
*	CONTENTS:	0: Set globals
* 				1: Open Data 
*				2: Homework Answers
*				3: Close log file (learn about this in Week 03)
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
	log using "${classpath}RMDA1_Homework2_log", replace 
	
*********
*	1: Open Data
*********

	use "${classpath}peer_pressure.dta", clear

*********
*	2: Homework Code
*********

	**1a**
	describe
	** 825 observations/students in the data. 
	
	**1b**
	bysort public: count
	**  411 private treatment assignments. 
	
	**1c**
	tab public
	** 49.82% assigned to private treatment. 
	
	**2a** Honors class (binary) variable analysis
	**i.  265 in an honors class.
	bysort honor: count
	**ii. 32.12%
	tab honor
	**iii.
	ttest honor, by(public)
	
	**2b** Male (binary) variable analysis
	**i. 423 male.
	bysort male: count 
	**ii. 51.27%
	tab male
	**iii.
	ttest male, by(public)
	
	**2c** Age (continuous) variable analysis
	**i. 16.74
	summarize age
	**ii. 
	ttest age, by(public)

	**3a**
	ttest yesno, by(public)
	
	**3b**
	ttest no_usage, by(public)
	

	
*********
*	3: Close log file
*********	
	
	log close
	translate "${classpath}RMDA1_Homework2_log.smcl" "${logfilepath}RMDA1_Homework2_log.pdf", replace
