Variable Description
Names of the varibles on left hand side are the ones used in the text of the paper and names of the same variables on the right hand side are the ones used in stata data file and in stata Do-file (codes). 
Sorting variable - numen
Cooperatives - coope
Age - age_hh
Agesq - agesq
Gender - gender
Certification - certified
HHsize - hh_size
Dependencyratio - depratio
Edu - edu
Edusq - edusq
Exp - years_cofeproduction
Farmsize - total_land
Access to NF income - nonfarmincome_access
Total income - totalincome_hh
Monthly per capita expenditure - percapita_consumption
Access to credit - access_credit
Yield - myYield
Weathershock - badweat   
Livestock - livestock
Land for coffee (ha) - land_coffee
Price of red cherry from cooperative (birr/kg) - redcheryprice_coopbirperkg
Price of sundried cherry from private trader (birr/kg) - driedcherryprice_birperkg
Net income from coffee (birr/ha) - cofeeincome_perunit_land
Log farm size - logtotal_land
Log yield - logmyYield
Extreme poor - poor_narrow_maleeq
Moderate poor - poor_broad_maleeq
Income gap ratio - income_gap
Income gap ratio square - income_gapsq

Table 1: Description of variables (Pg.11)
Codes for descriptive statistics
sum certified age_hh agesq gender  hh_size depratio edu  edusq years_cofeproduction total_land  nonfarmincome_access totalincome_hh percapita_consumption access_credit  myYield  badweat   livestock


Table 2: Gross margins in certified and conventional channels in Ethiopia (pg.14)
Codes for each column of the Table. Description of the variables used could be found from the list above titled by "Description of variables used".
tab certified
ttest total_land,by(certified)
ttest land_coffee,by(certified)
ttest myYield,by(certified)
ttest redcheryprice_coopbirperkg,by(certified)
ttest driedcherryprice_birperkg,by(certified)
ttest cofeeincome_perunit_land if cofeeincome_perunit_land!=0, by(certified)


Table 3:OLS regression results (pg.15)
reg percapitaincome_day_maleeq certified age_hh agesq access_nonfarnincome logtotal_land depratio badweat edu gender years_cofeproduction logmyYield hh_size,cluster (coope)
reg logtotal_income certified age_hh agesq access_nonfarnincome logtotal_land depratio badweat edu gender years_cofeproduction logmyYield,cluster (coope)
reg dailyconsumption_percapita certified age_hh agesq access_nonfarnincome logtotal_land depratio edu gender years_cofeproduction hh_size,cluster (coope)


Table 4: First stage Logit results of Propensity score matching (pg.17) 
Table 5: Propensity score matching results (pg.17)
psmatch2  certified age_hh agesq  access_nonfarnincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome(  percapitaincome_day_maleeq) common logit ate
psmatch2  certified age_hh agesq  access_nonfarnincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome(  logtotal_income) common logit ate
psmatch2  certified age_hh agesq  access_nonfarnincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome(  dailyconsumption_percapita) common logit ate
psmatch2  certified age_hh agesq  access_nonfarnincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome( myYield) common logit ate



Table 6: Poverty status of producers (pg.19) 
tab poor_broad_maleeq certified
tab poor_narrow_maleeq certified

Table 7: Regression results on poverty (pg.20)
reg  income_gap certified age_hh agesq access_nonfarnincome logtotal_land depratio badweat edu gender years_cofeproduction livestock hh_size,cluster (coope)
reg  income_gapsq certified age_hh agesq access_nonfarnincome logtotal_land depratio badweat edu gender years_cofeproduction livestock hh_size,cluster (coope)
