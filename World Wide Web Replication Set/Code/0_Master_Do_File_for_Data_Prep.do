*Master Do File for Data Prep

*Convert raw data to .dta 
do "\Code\1_Convert_to_dta.do"

*Construct panel dataset from every year of ODB data
do "\Code\2_Merge_ODB_Data.do"

*Merge in external data and prepare data for analysis 
do "\Code\4_Merge_in_External_Data.do" /// do file 3 is contained within do file 4

*Create the Choropleth Maps
do "\Code\6_Choropleth_Map"

