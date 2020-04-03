
clear all
graph drop _all
cd "\Data\Choropleth_Map"

* Shapefiles were downloaded from https://hub.arcgis.com/datasets/UIA::uia-world-countries-boundaries/data
* Convert shape file to dta files (this creates two files)
	* 1: data (this dataset will be merged with the ODB data)
	* 2: coord (this dataset contains the coordinates will be used to make the choropleth map) 
shp2dta using "shapefiles\UIA_World_Countries_Boundaries", data("data.dta") coord("coord.dta") genid(stid) gencentroids(cc) replace /*install shp2dta before running this commmand*/

use coord, clear
drop if _ID == 25
save coord2, replace

*-------------------------------------------------------------------------------
use "\Data\Final_Data_Set\Rankings.dta", clear
keep if year == 2013
isid country
ren iso2 ISO
rename country COUNTRY
merge 1:m ISO using data, keepusing(stid x_cc y_cc)
graph drop _all

* Open Data Barometer 1nd Edition (2013)
spmap implementationdatasets_average using coord2, id(stid) ///
	osize(vthin ..) ocolor(gray%10 ..) /// /*outline color and thickness of base map poligons*/
	fcolor(GnBu) ndfcolor(gray%15) ndocolor(gray%00) ///
	line(data("coord.dta") size(0.006) color(white)) ///
	clmethod(custom) clbreaks(0 20 40 60 80 100) eirange(0 90) ///
	legtitle("Legend") legend(label(2 "Very Low") label(3 "Low" ) label(4 "Medium") label(5 "High") label(6 "Very High") color(gray)) ///
	title("Open Data Implementation", size(*2) color(black)) ///
	subtitle("ODB 1st Edition (2013)", size(*1.5) color(gray)) ///
	legend(size(vlarge)) ///
	legend(position(7)) ///

graph export "\Choropleth_Maps\2013.png", as(png) replace
graph close

* Open Data Barometer 2th Edition (2014)
use "\Data\Final_Data_Set\Rankings.dta", clear
keep if year == 2014
isid country
ren iso2 ISO
rename country COUNTRY
merge 1:m ISO using data, keepusing(stid x_cc y_cc)
graph drop _all

spmap implementationdatasets_average using coord2, id(stid) ///
	osize(vthin ..) ocolor(gray%10 ..) /// /*outline color and thickness of base map poligons*/
	fcolor(GnBu) ndfcolor(gray%05) ndocolor(gray%05) ///
	clmethod(custom) clbreaks(0 20 40 60 80 100) eirange(0 90) ///
	line(data("coord.dta") size(0.006) color(white)) ///
	legtitle("Legend") legend(label(2 "Very Low") label(3 "Low" ) label(4 "Medium") label(5 "High") label(6 "Very High") color(gray)) ///
	title("Open Data Implementation", size(*2) color(black)) ///
	subtitle("ODB 2nd Edition (2014)", size(*1.5) color(gray)) ///
	legend(size(vlarge)) ///
	legend(position(7)) ///
	
graph export "\Choropleth_Maps\2014.png", as(png) replace
graph close

* Open Data Barometer 3th Edition (2015)
use "\Data\Final_Data_Set\Rankings.dta", clear
keep if year == 2015
isid country
ren iso2 ISO
rename country COUNTRY
merge 1:m ISO using data, keepusing(stid x_cc y_cc)
graph drop _all

spmap implementationdatasets_average using coord2, id(stid) ///
	osize(vthin ..) ocolor(gray%10 ..) /// /*outline color and thickness of base map poligons*/
	fcolor(GnBu) ndfcolor(gray%05) ndocolor(gray%05) ///
	clmethod(custom) clbreaks(0 20 40 60 80 100) eirange(0 90) ///
	line(data("coord.dta") size(0.006) color(white)) ///
	legtitle("Legend") legend(label(2 "Very Low") label(3 "Low" ) label(4 "Medium") label(5 "High") label(6 "Very High") color(gray)) ///
	title("Open Data Implementation", size(*2) color(black)) ///
	subtitle("ODB 3rd Edition (2015)", size(*1.5) color(gray)) ///
	legend(size(vlarge)) ///
	legend(position(7)) ///

graph export "\Choropleth_Maps\2015.png", as(png) replace
graph close


* Open Data Barometer 4th Edition (2016)
use "\Data\Final_Data_Set\Rankings.dta", clear
keep if year == 2016
isid country
ren iso2 ISO
rename country COUNTRY
merge 1:m ISO using data, keepusing(stid x_cc y_cc)
graph drop _all

spmap implementationdatasets_average using coord2, id(stid) ///
	osize(vthin ..) ocolor(gray%10 ..) /// /*outline color and thickness of base map poligons*/
	fcolor(GnBu) ndfcolor(gray%05) ndocolor(gray%05) ///
	clmethod(custom) clbreaks(0 20 40 60 80 100) eirange(0 90) ///
	line(data("coord.dta") size(0.006) color(white)) ///
	legtitle("Legend") legend(label(2 "Very Low") label(3 "Low" ) label(4 "Medium") label(5 "High") label(6 "Very High") color(gray)) ///
	title("Open Data Implementation", size(*2) color(black)) ///
	subtitle("ODB 4th Edition (2016)", size(*1.5) color(gray)) ///
	legend(size(vlarge)) ///
	legend(position(7)) ///

graph export "\Choropleth_Maps\2016.png", as(png) replace

graph close


