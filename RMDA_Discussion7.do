*********************************************************************************************************************************************
/*
FILE NAME: RMDA_Discussion8.do
AUTHOR: Eileen Powell
DATE CREATED: October 30, 2020
PURPOSE: This is a do.file with examples of counting clusters, generating dummy variables, and regressing with clusters
*/
*********************************************************************************************************************************************

//Load your data
 use "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA I/vaschls2015_2019.dta"
 
 //This data gives us a bunch of information on enor
 //generate a dummy variable:
 
	//Let's say I want to create a dummy variable for if a school has more than 500 students who receive free lunch
		//This means:
			//schools with 500+ will receive a value of 1
			//schools with less than 500 students will receive a value of 0
			
	summ nfree //ranges from 0 to 1973, mean of 261.52
	
	//strategy 1:
		generate nfree_dummy =.
		replace nfree_dummy = 1 if nfree >= 500 
		replace nfree_dummy = 0 if nfree <500
		tab nfree_dummy
		//I've replaced my variable so it is [0,1] and any schools with nfree=. will also have a missing value for my dummy variable
		
	//strategy 2:
		gen nfree_dummy2=(nfree>=500)
		tab nfree_dummy2
		
		//gen var=(statement) evaluates if that statement is true for each observation. If it is true, var = 1 else var = 0 
		
	//Now let's say I want to create a dummy for if a school has more than 500 students enrolled but less than 250 female students enrolled: 
	summ enrollft enrollftf
	
	//Strategy 1
	generate enroll_fem_dummy = 0
	replace enroll_fem_dummy = 1 if (enrollft>=500 & enrollftf <250)
		//this is an AND statement (&): if enrollment is greater than 500 AND enrollment female is less than 200
	replace enroll_fem_dummy = . if (enrollft==. | enrollftf==.)
		//this is an OR (|) statement: if enrollment is missing OR enrollment female is missing, set our dummy equal to missing
	
 
 // count clusters - 
	//if a treatment was administered at the division level, instead of school, how could I count the number of divisions?
	
	//Strategy 1
 codebook division
	//there are 132 unique division values 

	//Strategy 2
	egen num_division = group(division)
	sum num_division
		//The maximum value is our number of divisions
	
	//Strategy 3
	bysort division: gen student_num = _n
	
	count if student_num == 1
	//132 
 
 //regression - I am regressing the number of students who failed their math scores on the number of students with free and reduced lunch
	//this is not a causal dataset; just an example of how to cluster regressions
	 
 reg nfail_r frpl
 
 //Let's say I want to cluster at the division level (even though our smallest level of observation is school)

 reg nfail_r frpl, cluster(division)
 
	//Do our coefficient and intercept change? Does our standard error and statistical significance change?
