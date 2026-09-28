*===========================================================.
*Estimating mean income using complex survey design features
*============================================================.

*open log file in output folder with name of outcome variable (e.g. income.log).

log using "C:/CLAUDE/Projects/Project6/output/income.log", replace

*Load the survey dataset.
use "C:/CLAUDE/Projects/Project6/data/survey_data.dta", clear
*svyset the data using 3 variables: 
*wt_int as the sampling weight.
*psu as the primary sampling unit.
*strata as the stratification variable.


*income is the outcome variable
describe income
summ income

*treat missing values as missing to exclude from summary statistics.
mvdecode income,mv(-9/-1)

svyset [pw=wt_int],psu(psu) strata(strata)


*perform survey estimation. 
*estimate the mean income accounting for complex survey design.
svy:mean income

**Publish the outputs in table form using the etable command. 
**name the text file with the same name as outcome variable (e.g. income.txt)
etable, cstat(_r_b,nformat(%7.2f)) cstat(_r_se, nformat(%7.2f)) export("C:/CLAUDE/Projects/Project6/output/income.txt", replace)

*display date and time.
local date `c(current_date)'
local time `c(current_time)'
display _newline "Run `date' at `time'"

*close the log file.
log close








