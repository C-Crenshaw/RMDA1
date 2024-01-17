*********************************************************************************		
/*	TITLE: 		RMDA1_Homework5.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 5. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	11/03/2023																			
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
	log using "${classpath}RMDA1_Homework5_log", replace 
	
*********
*	1: Homework Code
*********


*QUESTION 1

use "${classpath}nlsw88.dta", clear
*1A
reg wage ttl_exp // reg Y(outcome of treatment) X

*1B 
generate ttl_exp_decade = ttl_exp / 10 // Changing units proved by creating a new variable
reg wage ttl_exp_decade

*1C
generate wage_weekly = wage*40 // 8 hours a day, 5 days = 40hr work week
reg wage_weekly ttl_exp


*QUESTION 2

use "${classpath}tracking.dta", clear
*2A
describe, short

*2B
codebook schoolid
distinct schoolid

*2C
bysort schoolid: gen order = _n //should generate the same number for all values of schoolid

sum schoolid if order == 1

*    Variable |        Obs        Mean    Std. dev.       Min        Max
*-------------+---------------------------------------------------------
*    schoolid |        111    777.8559    173.8787        430       1020

tab tracked if order == 1 //tab track should then show school level

*     school |
*assigned to |
*      track |
*   students |      Freq.     Percent        Cum.
*------------+-----------------------------------
*          0 |         51       45.95       45.95
*          1 |         60       54.05      100.00
*------------+-----------------------------------
*      Total |        111      100.00

*2D
reg female tracked, cluster(schoolid) // reg baseline characteristic (Y) x variable (X), clustered at the school level
// can also look at the difference without clustering: reg female tracked


*QUESTION 3

*3A
// variable that represents missing values as 1
generate missing_scores = 0 
replace missing_scores = 1 if score_lit_30months ==. | score_math_30months ==.
tab missing_scores

reg missing_scores tracked

// variable that represents missing values as 0
generate complete_scores = 1
replace complete_scores = 0 if score_lit_30months ==. | score_math_30months ==.
tab complete_scores

reg complete_scores tracked

//can also do it clustered: reg missing_scores tracked, cluster(schoolid)

*3B
count if complete_scores ==1

distinct schoolid if complete_scores ==1

sum score_math_30months if complete_scores ==1


*QUESTION 4

drop if complete_scores ==0 // remove observations with missing data
*4A
reg score_lit_30months tracked, cluster(schoolid)

*4B
reg score_lit_30months tracked


*********
*	2: Close log file
*********	
	
	log close
	translate "${classpath}RMDA1_Homework5_log.smcl" "${logfilepath}RMDA1_Homework5_log.pdf", replace
