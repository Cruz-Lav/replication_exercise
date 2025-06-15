clear all
cd "..."

use "data-Agecon"
describe
summarize
ssc install psmatch2, replace
ssc install pstest



* Replica de cada tabla del estudio

*********** TABLA 1 ***************** 
sum certified age_hh agesq gender hh_size depratio edu edusq years_cofeproduction total_land  nonfarmincome_access totalincome_hh percapita_consumption access_credit myyield  badweat livestock
*********** TABLA 2 ***************** 
tab certified
ttest total_land,by(certified)
ttest land_coffee,by(certified)
ttest myyield,by(certified)
ttest redcheryprice_coopbirperkg,by(certified)
ttest driedcherryprice_birperkg,by(certified)
ttest cofeeincome_perunit_land if cofeeincome_perunit_land!=0, by(certified)

//1.Tamaño total de la tierra (ha):
reg total_land certified

//2.Tamaño de la tierra para café (ha):
reg land_coffee certified

//3. Rendimiento del café (kg/ha):
reg myyield certified

//4. Precio de la cereza roja del cooperativo (birr/kg):
reg redcheryprice_coopbirperkg certified

//5. Precio de la cereza seca de comerciante privado (birr/kg):
reg driedcherryprice_birperkg certified

//6. Ingreso neto por hectárea de café (birr/ha)
reg cofeeincome_perunit_land certified

*********** TABLA 3 *****************
//Columna 1 

gen income_percapita_adj = (totalincome_hh - nonfarmincome) / hh_size
gen income_percapita_day = income_percapita_adj / 365

reg income_percapita_day certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction logmyyield hh_size,cluster (coope)

//Columna 2 _ CORRECTO-VERIFICADO
gen lntotalincome_hh = ln(totalincome_hh)
reg lntotalincome_hh certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction logmyyield,cluster (coope)
vif

//Columna 3 _ CORRECTO-VERIFICADO
gen dailyconsumption_percapita = (percapita_consumption/30)
reg dailyconsumption_percapita certified age_hh agesq nonfarmincome logtotal_land depratio edu gender years_cofeproduction hh_size,cluster (coope)
vif
*********** TABLA 4 ***************** CORRECTO-VERIFICADO

logit certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofepro access_credit


*********** TABLA 5 ***************** 

// Fila 1 
psmatch2  certified age_hh agesq  nonfarmincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome(income_percapita_day) common logit ate

//MCO
reg income_percapita_day certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction logmyyield hh_size if _support == 1

// Fila 2 _ CORRECTO-VERIFICADO
psmatch2  certified age_hh agesq nonfarmincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome(lntotalincome_hh) common logit ate

//MCO
reg lntotalincome_hh certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction logmyyield if _support == 1

// Fila 3 _ CORRECTO-VERIFICADO
psmatch2  certified age_hh agesq nonfarmincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome (dailyconsumption_percapita) common logit ate

//MCO
reg dailyconsumption_percapita certified age_hh agesq nonfarmincome logtotal_land depratio edu gender years_cofeproduction hh_size if _support == 1

// Fila 4 _ CORRECTO-VERIFICADO
psmatch2  certified age_hh agesq nonfarmincome logtotal_land depratio badweat  edu gender years_cofeproduction access_credit,  outcome( myyield) common logit ate

//MCO
reg myyield certified age_hh agesq nonfarmincome logtotal_land depratio edu gender years_cofeproduction hh_size if _support == 1


*********** TABLA 6 ***************** CORRECTO-VERIFICADO

//. Poverty status of producers 
tab poor_broad_maleeq certified
tab poor_narrow_maleeq certified

*********** TABLA 7 *****************  CORRECTO-VERIFICADO
//. Regresión para "Income gap ratio"
regress income_gap certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofepro livestock hh_size, cluster (coope)
//. Regresión para "Income gap ratio square"
regress income_gapsq certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofepro livestock hh_size, cluster (coope)

************ REGRESIONES ADICIONALES ******************* 
//BALANCE DE MEDIAS 
 *1. psmatc2
 * Paso 1: Estimar el modelo logit para el puntaje de propensión
logit certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit

* Paso 2: Generar los puntajes de propensión predichos 
predict pscore, pr

* Paso 3: Realizar el emparejamiento (PSM)
psmatch2 certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, outcome(dailyconsumption_percapita) common logit ate

* Paso 4: Visualización del soporte común 

twoway (kdensity pscore if certified==1, lcolor(red) lpattern(solid)) /// 
       (kdensity pscore if certified==0, lcolor(blue) lpattern(dash)), /// 
       legend(label(1 "Tratados") label(2 "Control")) /// 
       title("Distribución de puntajes de propensión") /// 
       ytitle("Densidad") /// 
       xtitle("Puntaje de propensión") /// 
       xlabel(0(0.2) (0.4) (0.6) (0.8)1), format(%4.1f)) // 


* Paso 5: Realizar pruebas de balance de covariables
pstest age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, by()certified)


* Paso 6: Revisar las estadísticas clave de balance (opcional para observación detallada)

pstest age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, both graph


* Verificar el porcentaje de sesgo y las pruebas t para ver si las covariables están bien balanceadas.




************************************************************************
//           Intento con otras formas de emparejamiento               //
************************************************************************



*1 teffects psmatch
* Paso 1: Estimar el modelo Logit y calcular el puntaje de propensión
logit certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit
predict pscore, xb

* Paso 2: Realizar el emparejamiento usando PSM
teffects psmatch (dailyconsumption_percapita) (certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit), atet

* Paso 3: Calcular medias y desviaciones estándar antes del emparejamiento
pstest age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, both graph


*2. Vecino mas cercano 1: 1 con un caliper de 0.01

psmatch2 certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, outcome(dailyconsumption_percapita) common logit ate caliper(0.01)

pstest age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, both graph


*3. Kernel

psmatch2 certified age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, outcome(dailyconsumption_percapita) logit kernel bw(0.06) ate common

pstest age_hh agesq nonfarmincome logtotal_land depratio badweat edu gender years_cofeproduction access_credit, both graph




