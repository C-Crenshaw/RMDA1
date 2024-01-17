/***********************************************

FILE NAME: Discussion3_dofile.do
AUTHOR: Eileen & Ella
DATE CREATED: September 8, 2023
PURPOSE: This is a do.file with practice and examples for Discussion 3

***********************************************/

//Comment notes for yourself or to track HW questions by using:
	// #1 - Double slashes (//) 
		// double slashes allow you to comment at the end of a command
	* #2 - a star *
	/* #3 A slash and a star. This will turn everything after (on multiple lines) into a comment
	until you end it with */

//Don't worry too much about these commands. These are best practices to start your .dofile. Clear all will ensure there is no other data in your Stata system so you can import what data you need for homework or practice
clear all
set more off 




*************
*
* Open up your data
*
*************

//copy your own data file path into the ""
use "/Users/eileenpowell/Downloads/MiniELSdata.dta", clear"

save 

*************
*
* Get to know your data
*
*************

//the command browse will pull up a separate window of the data for you to explore
browse 
br // browse can be shortened all the way to br 


//other helpful commands to explore the data:
codebook //this will give you the codebook for every variable
codebook, compact 
describe


//How many variables are in the dataset? How many observations? 
describe
*16,197 observations, 14 variables
codebook compact

// Let's find the means of some variables in our data using the command summarize. What variables can you get means for, but the means aren't useful? 
summarize bynels2m

//How would you interpret the mean of bysex? Be sure to use information from codebook to help you.
codebook bysex

//Use the help command to explore one of the commands above more. See if you can find a useful option you might want to run 
help browse //this is an example, you should do something else as well 


*************
*
* Running some tests
*
*************

//We are curious if there is a difference in sport participation based on gender. Use the tab command to explore this question 
	*tab syntax: tab [variable 1] [variable 2]
tab bysolosp bysex
bysort bysex: tab bysolosp
	
	
//We are now curious if there is a difference in sport participation based on gender, but only for students in urban environments. Add an "if" command to your tab to explore this question.
	*tab syntax: tab [variable 1] [variable 2] if [other variable]==[some condition]
codebook byurban
	tab byurban
	
ttest bystlang, by(bysex)
	
// We want to know if there is a difference in testing scores based on gender. Run a t-test to explore this question. 
	*t-test syntax: ttest [variable of interest], by([treatment/groupinig variable])

	*What is our null hypothesis in words? 
	*What is the difference between the two groups? 
	*What does our p-value tell us? 
	

