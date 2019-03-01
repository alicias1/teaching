** Week 2
cd "H:\socialepi"
use socepi_tz
log using socepi_tz_wk2, replace


* Week 2
* Section 1 - Gnerating an asset index
* Q1 Asset Desscription

* Assets

tab toilet 
tab electricity
tab radio
tab tv
tab fridge
tab car

tab water 
tab floor
tab wall 
tab roof 

* Q2 Relationships between assets

tab electricity car, col chi
* Above is just an example - you should look at othe combinations


* Q3 -  Preparing to generate an asset index
* The following commands create dichotmous indicator variables for all values of variables with more than 2 catgories

tab wall, gen (wall)
tab floor, gen (floor)
tab roof, gen (roof)
tab water, gen (water)


* Q4 - Run PCA

pca  electricity radio tv fridge car toilet water1 water2 water3 water4 water5 floor1 floor2 floor3 floor4  wall1 wall2 wall3 wall4 wall5 wall6 wall7 roof1 roof2 roof3, components(1)

* Q5: Generate an asset index from the first principal component, and group this into quintiles

predict sesscore
xtile sesgroup=sesscore, nq(5)
label define sesgroup 1 "lower" 2 "lower middle" 3  "middle" 4 "upper middle" 5 "upper"
lab val sesgroup sesgroup
tab sesgroup








* Section 2. Concentration curve and index

* Q1: first lets look at the association between hiv and the asset index we have created in 5 groups

tab sesgroup serostat, row chi


* and compare this with the association with education

tab educat serostat, row chi



* Q2: we can use the quantitative asset score data to create a concentratin curve

glcurve serostat, glvar(glmed) pvar(rank) sortvar(sesscore)
prop serostat if sesgroup!=.
label variable rank "Cum. wealth score"
gen ccurve2 = glmed /.02115
label variable ccurve2 "Conc. Curve"
gr7 ccurve2 rank rank , sy(..) xscale(0,1) yscale(0,1) ylabel (0 0.25 to 1) xlabel (0 0.25 to 1) l1(Cum. HIV)

* Calculate a concentration index

ssc install concindc, replace
concindc serostat , welfarevar(sesscore)








* Section 3. Mediation of  influence of education on hiv by number of sexual partrner

* Lets recode education to be two categories - none and some education - so that we have more statistical power

gen educat2=educat
recode educat2 2=1
label define educat2 0 "No education" 1 "Some education"
lab val educat2 educat2
tab educat2


* Lets recode partnersgp to be two categories - none and some education - so that we have more statistical power

gen partnersgp2=partnersgp
recode partnersgp2 0=1
label define partnersgp2 1 "0 or 1 partners" 2 "More than 1 partner"
lab val partnersgp2 partnersgp2
tab partnersgp2

* Unadjusted analysis

tab educat serostat, row chi
mhodds serostat educat2

* Adjusting for confounding

mhodds serostat educat2 agegp


* Association between Partners and HIV


tab partnersgp2 serostat, row chi

* Association between Education and Partners

tab educat2 partnersgp2 , row chi

* Looking for mediation

mhodds serostat educat2 agegp partnersgp2
