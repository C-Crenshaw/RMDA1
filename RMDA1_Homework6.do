*********************************************************************************		
/*	TITLE: 		RMDA1_Homework6.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 6. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	11/16/2023																			
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
	log using "${classpath}RMDA1_Homework6_log", replace 
	
*********
*	1: Homework Code
*********

use "${classpath}tracking.dta", clear

*QUESTION 1
*1A
// Recreate dummy for missing values (as represented by 1)
generate missing_scores = 0 
replace missing_scores = 1 if score_lit_30months ==. | score_math_30months ==.

drop if missing_scores == 1 // remove observations with missing data

reg score_math_30months tracked, cluster(schoolid)

*1B
reg score_math_30months tracked female, cluster(schoolid)

*1C
reg score_math_30months tracked score_lit_30months, cluster(schoolid)

*1D
reg score_math_30months tracked age_base, cluster(schoolid)
// confirm with a covariate balance test regression:
// reg age_base tracked, cluster(schoolid)


*QUESTION 2
*2C
*i
reg score_math_30months tracked if score_base_bottomhalf == 0, cluster(schoolid)

*ii
reg score_math_30months tracked if score_base_bottomhalf == 1, cluster(schoolid)

*iii
gen tracked_bottomhalf = tracked * score_base_bottomhalf
reg score_math_30months tracked score_base_bottomhalf tracked_bottomhalf, cluster(schoolid)


*QUESTION 3

use "${classpath}cps17_va.dta", clear

*3A
reg htotval hunder18

*3B
generate married = 0 
replace married = 1 if a_maritl == 1 | a_maritl == 2 | a_maritl == 3

reg htotval hunder18 married

generate unmarried = 0 
replace unmarried = 1 if a_maritl == 4 | a_maritl == 5 | a_maritl == 6 | a_maritl == 7

reg htotval hunder18 unmarried

*3C
generate hs_grad = 0
replace hs_grad = 1 if a_hga >= 39

reg htotval hunder18 hs_grad

*3D
gen hunder18_sq = hunder18 * hunder18
reg htotval hunder18 hunder18_sq


*********
*	2: Close log file
*********	
	
	log close
	translate "${classpath}RMDA1_Homework6_log.smcl" "${logfilepath}RMDA1_Homework6_log.pdf", replace
