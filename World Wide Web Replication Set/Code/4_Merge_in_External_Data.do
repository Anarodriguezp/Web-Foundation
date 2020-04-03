*Political Economy Data Prep and Merge 
* external data can be found at https://ncgg.princeton.edu/wep/dataverse.html
import delimited "\Data\External_Data\Political_Economy_Dataverse.csv", clear 
do "\Code\3_Variable_Labels.do"
*modify variables
renvarlab  internet_br_wdi v2x_cspart_vdem v2xdd_dd_vdem v2x_pubcorr_vdem v2x_execorr_vdem v2x_civlib_vdem ge_est_wgi, label

*observation number by country
sort country year
gen first = _n
bysort country (first): gen obfirst = _n
drop first
 
/*political orientation of executive
gen party_exec = 1 if  execrlc_dpi== "0"
replace party_exec = 1 if  execrlc_dpi == "Left"
replace party_exec = 3 if  execrlc_dpi == "Center"
replace party_exec = 4 if  execrlc_dpi == "Right"
xi i.party_exec

** political orientation of largest party
gen party_larg= 1 if  gov1rlc_dpi == "0"
replace party_larg = 2 if  gov1rlc_dpi == "Left"
replace party_larg = 3 if  gov1rlc_dpi == "Center"
replace party_larg = 4 if  gov1rlc_dpi == "Right"
xi i.party_larg
 

*executive political transition variable
gsort country -year
bysort country: gen transition= 1 if party_exec != party_exec[_n-1] & party_exec != . & party_exec[_n-1] != . & party_exec != 0 & obfirst != 1 

*largest political party transition variable
gsort country -year
bysort country: gen transition_larg= 1 if party_larg != party_larg[_n-1] & party_larg!= . & party_larg[_n-1] != . & party_larg!= 0 & obfirst != 1 
*/

save "\Data\External_Data\Political_Economy_Dataverse.dta", replace

*Merge ODB and External Data
*Scored
use "\Data\Merged_ODB_Data\ODB-HistoricalData-ODB-Datasets-Scored_merged.dta", replace
merge m:1 country year using "\Data\External_Data\Political_Economy_Dataverse.dta"
drop if _merge == 2
drop _merge
save "\Data\Final_Data_Set\Scored.dta", replace


*Scores
use "\Data\Merged_ODB_Data\ODB-HistoricalData-ODB-Scores_merged.dta", replace
merge m:1 country year using "\Data\External_Data\Political_Economy_Dataverse.dta"
drop if _merge == 2
drop _merge 
save "\Data\Final_Data_Set\Scores.dta", replace

*Rankings
use "\Data\Merged_ODB_Data\ODB-HistoricalData-ODB-Rankings_merged.dta", replace
drop if country == "." 
merge 1:m country year using "\Data\External_Data\Political_Economy_Dataverse.dta"
drop if _merge == 2
drop _merge
save "\Data\Final_Data_Set\Rankings.dta", replace

*convert to csv
cd "\Data\Final_Data_Set"
use "Rankings.dta", replace
export delimited using "Rankings.csv", replace

use "Scores.dta", replace
export delimited using "Scores.csv", replace

use "Scored.dta", replace
export delimited using "Scored.csv", replace
