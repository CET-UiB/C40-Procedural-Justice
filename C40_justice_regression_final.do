********************************************************************************
	*	*	*	C40 JUSTICE PAPER - LOGISTIC REGRESSION ANALYSIS	*	*	*	
********************************************************************************

* Dataset: C40_justice_regression_data_final
* Dependent variable: cities' engagement/lacking engagement with procedural justice (0/1)


********************************************************************************
* Variables generation
********************************************************************************

* create variable DISTANCE YEARS (time between membership status and plan publish)
g distance_years = plan_year - member_year


********************************************************************************
* Logistic regression analysis 
********************************************************************************

* estout package
ssc install estout, replace
eststo clear

eststo:						///
logit procedural_justice 	/// dependent variable 
equity_pledge 				/// equity 
distance_years 				/// time variable 
, level(90) vce(robust) nolog

eststo:						///
logit procedural_justice 	/// dependent variable 
equity_pledge 				/// equity 
distance_years 				/// time variables 
green_access 				/// green access 
coastal_city 				/// coastal 
, level(90) vce(robust) nolog

eststo:						///
logit procedural_justice 	/// dependent variable 
equity_pledge 				/// equity 
distance_years 				/// time variable
green_access 				/// green access 
coastal_city 				/// coastal 
global_south 				/// global south
, level(90) vce(robust) nolog

eststo:						///
logit procedural_justice 	/// dependent variable 
equity_pledge 				/// equity 
distance_years 				/// time variable
green_access 				/// green access 
coastal_city 				/// coastal 
global_south 				/// global south
population_million 			/// population
gdp_capita 					/// gross domestic production
, level(90) vce(robust) nolog


********************************************************************************
* Regression table
********************************************************************************

esttab using logit_final.rtf,  		///
replace 							/// replace existing word file 
b(3)								/// specify format for point estimates
nomtitles 							/// remove model titeles
compress							/// recude horizontal spacing  
onecell            					/// combine point est's and t-stat's in a single cell
se(3)								/// standard errors instead of t-stats in parenthesis 
aic									/// include AIC 
bic									/// include BIC  
star(* 0.10 ** 0.05 *** 0.01) 		/// change p-values 
obslast  							/// put observations last 
scalars(ll r2_p) 					/// log likelihood + pseudo-R2 + p-value for model test
addnote("The dependent variable is binary variable indicating cities' engagement/lacking engagement with procedural justice")


********************************************************************************
* Diagnostics 
********************************************************************************

* OLS final regression model
reg procedural_justice /// dependent variable 
equity_pledge 			/// equity 
distance_years 			/// time variables 
green_access 			/// green access 
coastal_city 			/// coastal 
global_south 			/// global south
population_million 		/// population
gdp_capita 				/// gdp
, level(90) vce(robust)

* Variance inflation factor (VIF) 
vif 


*	*	*	*	*	*	*	*	*	*	*	*	*	*	*	*	*	*	*	*