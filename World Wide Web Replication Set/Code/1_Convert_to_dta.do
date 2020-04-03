*Set working directory 
cd "\Data\ODB-HistoricalData-Full\Individual_Datasets"

*Convert files into dta 
*1st edition
import delimited "ODB-HistoricalData-ODB-1stEdition-Datasets-Scored.csv", clear
save "ODB-HistoricalData-ODB-1stEdition-Datasets-Scored.dta", replace

import delimited "ODB-HistoricalData-ODB-1stEdition-Rankings.csv", clear
save "ODB-HistoricalData-ODB-1stEdition-Rankings.dta", replace

import delimited "ODB-HistoricalData-ODB-1stEdition-Scores.csv", clear
save "ODB-HistoricalData-ODB-1stEdition-Scores.dta", replace


*2nd edition
import delimited "ODB-HistoricalData-ODB-2ndEdition-Datasets-Scored.csv", clear
save "ODB-HistoricalData-ODB-2ndEdition-Datasets-Scored.dta", replace

import delimited "ODB-HistoricalData-ODB-2ndEdition-Rankings.csv", clear
save "ODB-HistoricalData-ODB-2ndEdition-Rankings.dta", replace

import delimited "ODB-HistoricalData-ODB-2ndEdition-Scores.csv", clear
save "ODB-HistoricalData-ODB-2ndEdition-Scores.dta", replace


*3rd edition
import delimited "ODB-HistoricalData-ODB-3rdEdition-Datasets-Scored.csv", clear
save "ODB-HistoricalData-ODB-3rdEdition-Datasets-Scored.dta", replace

import delimited "ODB-HistoricalData-ODB-3rdEdition-Rankings.csv", clear
rename v1 year
save "ODB-HistoricalData-ODB-3rdEdition-Rankings.dta", replace

import delimited "\ODB-HistoricalData-ODB-3rdEdition-Scores.csv", clear
save "ODB-HistoricalData-ODB-3rdEdition-Scores.dta", replace


*4th 
import delimited "ODB-HistoricalData-ODB-4thEdition-Datasets-Scored.csv", clear
foreach var of varlist calculatedscore isopen aexists bavailable cmachinereadable dbulk efree flicense gupdated hsustainable idiscoverable jlinked {
destring `var', force replace
}
save "ODB-HistoricalData-ODB-4thEdition-Datasets-Scored.dta", replace

import delimited "ODB-HistoricalData-ODB-4thEdition-Rankings.csv", clear
save "ODB-HistoricalData-ODB-4thEdition-Rankings.dta", replace

import delimited "ODB-HistoricalData-ODB-4thEdition-Scores.csv", clear
save "ODB-HistoricalData-ODB-4thEdition-Scores.dta", replace


*Leaders edition
import delimited "ODB-HistoricalData-ODB-LeadersEdition-Datasets-Scored.csv", clear
save "ODB-HistoricalData-ODB-LeadersEdition-Datasets-Scored.dta", replace

import delimited "ODB-HistoricalData-ODB-LeadersEdition-Rankings.csv", clear
save "ODB-HistoricalData-ODB-LeadersEdition-Rankings.dta", replace

import delimited "ODB-HistoricalData-ODB-LeadersEdition-Scores.csv", clear
save "ODB-HistoricalData-ODB-LeadersEdition-Scores.dta", replace



