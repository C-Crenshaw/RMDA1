clear all
set more off

cd "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA I/" //insert your own file path here (data is from last homework )
use "nlsw88.dta"

//Observational data

//Basic, simple regression

//Let's start by testing the association between total work experience and hourly wage. What does the following regression of hourly wage on total work experience tell you?

regress wage ttl_exp

// People how 0 years of work experience receive, on average, a wage of $3.61 per hour
// Each additional year of experience is associated with a $0.33 (33 cent) increase in hourly wage
// This estimate is statistically significant at any conventional levels (P=0.000)
// There is a positive relationship (correlation, not causation) between experience and wage

	//Everytime you perform a regression, you should think about these three steps:
		//1) What is the magnitude of our alpha and coefficient of interest? Interpret in the context of the regression variables and their units.
			//a. Is Y (and therefore our units for alpha and beta) a binary variable - share, rate, percent, percentage point - or a continuous variable - #
			//b. Are we working with RCT data (causal relationship) or observational data (correlational relationship)?
		//2) Is our coefficient of interest statistically significant? At what levels is it / is it not statistically signficant?
		//3) Why do we care i.e. what is the implication of our test? 


//What happens when you add covariates?

//We think that this association may vary depending on being a college graduate. What happens when you add collgrad as a covariate? 

regress wage ttl_exp collgrad

// When we add college graduate status as a covariate, our estimate of the effect of experience on wage decreases.
// Now, each additional uear of experience is associated with a 29 (or 30) cent increase in hourly wage, holding college graduation status constant. 
// We previously overestimated the effect of experience on wage because we didn't account for the relationship between college, experience, and wage (must be either both - or both +, likely both positive)

//How would you approach signing the bias? Start by running a regression of your omitted variable on X, and look at the regression of your omitted variable on Y. Use the equation on the slides to plug in values.
// Since these relationships are correlational, you can run them however makes sense to you -- but the interpretation will change. 

// For me -- the most intuitive way to do this is to 1) regress experience on college graduation and 2) regression wage on college graduation. The question we are asking is how does being a college graduate affect your wage or affect your experience?

regress ttl_exp collgrad
// college graduates have 1.19 years more of experience, on average

regress wage collgrad
// college graduates earn $3.61 dollars/hour more, on average

// If you were to run it the other ways:
regress collgrad ttl_exp 
// Experience is positively related to college graduation
// An additional year of experience is associated with a 1 percentage point increase in someone's likelihood of being a college graduate.

regress collgrad wage
// An additional dollar per hour in wage is associated with a 1.9 percentage point increase in the likelihood (or share) of someone being a college graduate. 

// All show us that college graduate is positively related to both wage and experience

// You could also check this with correlations:
corr collgrad wage
corr collgrad ttl_exp
// Positive correlations


//We also think that race may be biasing our original estimate. Let's add it as a covariate to see how the association between total work experience and wage changes:
tab race
tab race, gen(race_d)
rename race_d1 White
rename race_d2 Black 
rename race_d3 Other

tab White
tab Black

regress wage ttl_exp collgrad race
regress wage ttl_exp collgrad White
// Holding race and college graduation status constant, an additional year of experience is associated with a 30.1 cent increase in hourly wage


//What is the sign of the omitted variable bias associated with not controlling for race?
regress race ttl_exp

// relationship between X and covariate
regress ttl_exp White

// relationship between Y and covariate
regress wage White




