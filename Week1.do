* Week 1 
* Opening the data
* You must have transferred the data sets and this do file to your home space and into a folder called H:\Socialepi

cd "H:\socialepi"
use socepi_tz
log using socepi_tz_wk1, replace

* Section 3
* Descriptive analysis

summ age 
tab serostat 
tab toilet 
tab electricity
tab water 
tab radio
tab tv
tab fridge
tab bike
tab car
tab floor
tab wall 
tab roof 
tab educat
tab married
tab partners


* Section 4
* Recoding age and partners

gen agegp=age
recode agegp min/19.5=1 19.5/max=2
tab agegp

gen partnersgp=partners
recode partnersgp 3/max=2
tab partnersgp

* Section 5
* Prevalence of HIV

tab serostat

tab agegp serostat, row
mhodds serostat agegp

tab educat serostat, row
mhodds serostat educat, c(1,0)
mhodds serostat educat, c(2,0)


* Section 6
* Adjusting for confounding


mhodds serostat educat agegp, c(1,0)
mhodds serostat educat agegp, c(2,0)


* REMEMBER to save your data set to keep your re-codings for neext week

save "socepi_tz.dta", replace

