*===========================================================.
*Estimating mean wealth using complex survey design features
*============================================================.

*open log file in output folder with name of outcome variable.
log using "C:\CLAUDE\Projects\Project6\output\wealth.log", replace

*load survey_data:
use "C:\CLAUDE\Projects\Project6\data\survey_data.dta", clear

*confirm outcome variable exists before proceeding:
describe wealth

*'svyset' the data:
svyset [pw=wt_int],psu(psu) strata(strata)

*set values as missing:
summ wealth
mvdecode wealth,mv(-9/-1)
summ wealth

*estimate survey statistics for the outcome variable:
svy:mean wealth

*publish the output using the etable command and save in a txt file
etable, cstat(_r_b, nformat(%7.2f)) cstat(_r_se, nformat(%7.2f)) export("C:/CLAUDE/Projects/Project6/output/wealth.txt", replace)

local date `c(current_date)'
local time `c(current_time)'
display _newline "Run `date' at `time'"

log close
