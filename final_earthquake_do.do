clear all
version 18
capture log close
********************************************************************************
*Project Title: Nepal Household Vulnerability Studies						   *
*Description: For Nepal Earthquake study									   *
*Dataset: World Bank														   *
*Author: Ramesh Dulal 														   *
********************************************************************************
global user  1   // change the number to your user number

if $user == 1 { 
    global workdir "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work"
}
if $user == 2 {
    global projectfolder " "  // Enter the file path to your projectfolder here
}

*==============================================================================*
*          WORKING DIRECTORIES  & DATA LOADING                                 *
*------------------------------------------------------------------------------*
*Entering my work directory
cd "$workdir"
*Making folders in the work directory
global do "$workdir/do"
global data "$workdir/data"
global docs "$workdir/docs"

**Creating a log file
set logtype smcl
log using "$do/final_nepal_earthquake.smcl", replace

*Specifying the path to the folder where I have the raw Dataset. I have three different
*folders for Raw Data as phase 1, 2 and 3
global wave1 "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work/data/wave_1/merged_data"
global wave2 "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work/data/wave_2/merged_data2"
global wave3 "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work/data/wave_3/merged_data3"


cap{
mkdir "$data/Final_Data"
}
global final "$data/Final_Data"
*==============================================================================*
*          Appending Wave 1, 2 and 3 data.                                     *
*------------------------------------------------------------------------------*
use "$wave1/wave_1.dta"
append using "$wave2/wave_2.dta"
save "$final/wave_1_2.dta", replace
use "$final/wave_1_2.dta"
append using "$wave3/wave_3.dta"
save "$final/wave_1_2_3.dta", replace
