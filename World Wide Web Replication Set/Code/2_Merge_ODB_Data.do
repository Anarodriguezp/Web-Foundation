*merge Rankings
clear all
cd "\Data\Raw_ODB_Data"
         use "ODB-HistoricalData-ODB-1stEdition-Rankings.dta", replace
append using "ODB-HistoricalData-ODB-2ndEdition-Rankings.dta"
append using "ODB-HistoricalData-ODB-3rdEdition-Rankings.dta"
append using "ODB-HistoricalData-ODB-4thEdition-Rankings.dta"
append using "ODB-HistoricalData-ODB-LeadersEdition-Rankings.dta"
save "\Data\Merged_ODB_Data\ODB-HistoricalData-ODB-Rankings_merged.dta", replace

*merge Scores
         use "ODB-HistoricalData-ODB-1stEdition-Scores.dta", replace
append using "ODB-HistoricalData-ODB-2ndEdition-Scores.dta"
tostring odb2013ccity, replace
append using "ODB-HistoricalData-ODB-3rdEdition-Scores.dta", 
append using "ODB-HistoricalData-ODB-4thEdition-Scores.dta", force
destring odb2013ccity, force replace
destring unosi2016, force replace
tostring odb2013d15, replace
append using "ODB-HistoricalData-ODB-LeadersEdition-Scores.dta"
replace odb2013d15 = "." if odb2013d15 == "NA"
destring odb2013d15, replace
save "\Data\Merged_ODB_Data\ODB-HistoricalData-ODB-Scores_merged.dta", replace


*merge Scored
         use "ODB-HistoricalData-ODB-1stEdition-Datasets-Scored.dta", replace
append using "ODB-HistoricalData-ODB-2ndEdition-Datasets-Scored.dta"
append using "ODB-HistoricalData-ODB-3rdEdition-Datasets-Scored.dta"
append using "ODB-HistoricalData-ODB-4thEdition-Datasets-Scored.dta"
append using "ODB-HistoricalData-ODB-LeadersEdition-Datasets-Scored.dta"
save "\Data\Merged_ODB_Data\ODB-HistoricalData-ODB-Datasets-Scored_merged.dta", replace

*convert to csv
cd "\Data\Merged_ODB_Data
use "ODB-HistoricalData-ODB-Rankings_merged.dta", replace
keep year iso2 iso3 odbrank country implementationdatasets_average implementation
export delimited using "Rankings.csv", replace

use "ODB-HistoricalData-ODB-Scores_merged.dta", replace
export delimited using "Scores.csv", replace

use "ODB-HistoricalData-ODB-Datasets-Scored_merged.dta", replace
export delimited using "Scored.csv", replace
