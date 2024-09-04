clear all
version 18
capture log close
********************************************************************************
*Project Title: Nepal Household Vulnerability Studies						   *
*Description: For Nepal Earthquake study									   *
*Dataset: World Bank														   *
*Author: Ramesh Dulal 
														   *
********************************************************************************
global user  1   // change the number to your user number

if $user == 1 { 
    global workdir "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work/data/Final_Data"
}
if $user == 2 {
    global projectfolder " "  // Enter the file path to your projectfolder here
}

*==============================================================================*
*          WORKING DIRECTORIES  & DATA LOADING                                 *
*------------------------------------------------------------------------------*
*Entering my work directory
cd "$workdir"
*Making the folder for first analysis
cap{
	mkdir "$workdir/analysis_1"
}
global analysis_1 "$workdir/analysis_1"
*Making folders in the work directory
global do "$analysis_1/do"
global data "$analysis_1/data"
global docs "$analysis_1/docs"

cap{
    mkdir "$do"
	mkdir "$data"
	mkdir "$docs"
}

**Creating a log file
set logtype smcl
log using "$do/analysis_1.smcl", replace

***Using the final merged dataset
*Specifying the path to the folder where I have the raw Dataset. I have three different
*folders for Raw Data as phase 1, 2 and 3
global raw_data_1 "/Users/rameshdulal/Documents/Data/NPL_2016-2018_HRVS_v02_M_STATA12/Wave 1 - Household"
global raw_data_2 "/Users/rameshdulal/Documents/Data/NPL_2016-2018_HRVS_v02_M_STATA12/Wave 2 - Household"
global raw_data_3 "/Users/rameshdulal/Documents/Data/NPL_2016-2018_HRVS_v02_M_STATA12/Wave 3 - Household"


cap{
mkdir "$data/wave_3"
}
global wave3 "$data/wave_3"
cap{
	mkdir "$data/wave_3/merged_data"
}
global merged_data "$data/wave_3/merged_data"
*I am using one of the datasets from the folders
********************************************************************************
*************************----------------------------***************************
*-----------------------Using dataset from Round 3-----------------------------*
*************************----------------------------***************************
********************************************************************************
use "$raw_data_3/Section_0.dta"
*Drop the variables not required
drop s00q00c s00q00d s00q01 s00q01a s00q02a s00q02b s00q03a s00q03b s00q03c s00q07  s00q07
rename s00q00b willing_partcpt 
rename  s00q09 is_HHH 
rename  s00q15 ethnic  
rename  s00q16 prim_lang 
rename  s00q17 religion
rename  s00q03 prev_ward
*The dataset has HHID, district code and PSU which is ward. Each VDC has data on a single ward. So name of VDC is not significant in creating a unique id.
*saving the dataset into my project folder
save "$merged_data/consent_info.dta", replace

*************************----------------------------***************************
*-------------------------Using another dataset--------------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_1.dta"
*rename the variables
rename s01q00a still_memb
rename s01q00b moved_to
rename s01q01 reln_to_HHH 
rename s01q02 sex
rename s01q03 age_grt_5
rename s01q03a age_mnths
rename s01q03c age_les_5
rename s01q05a born_same_dist
rename s01q05b birth_dist
rename s01q05c birth_cont
rename s01q06a current_living_house 
rename s01q06b current_living_location
rename s01q06b_s current_living_other
rename s01q07  marital_stat
drop vdc
*saving the dataset
save "$merged_data/hh_basic_info.dta", replace

*************************----------------------------***************************
*-------------------------Using another dataset--------------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_2.dta"
*rename the variables
rename s02q01 edu_background
rename s02q02 grade_comp
rename s02q03 current_grade
rename s02q04 school_type
rename s02q05 scholarship_recvd
rename s02q06 scholarship_source

rename s02q06_1 scholarship_govn
rename s02q06_2 scholarship_school
rename s02q06_3 scholarship_ngo
rename s02q06_4 scholarship_help
rename s02q06_5 scholarship_other
rename s02q06_s scholarship_othrdetl


rename s02q07 scholarship_type
rename s02q08 scholarship_amt
rename s02q09 school_exp /*expenses*/
rename s02q09a tuition_exp
rename s02q09b uniform_exp 
rename s02q09c supplies_exp
rename s02q09d trans_exp /*trans=transportation*/
rename s02q09e lunch_exp
rename s02q09f other_exp/*education related other expenses*/
rename s02q10 school_trans 
rename s02q11a pct_absent
rename s02q11b missing_reason

rename s02q11b_s missing_reason_other
rename s02q11c days_didnot_go
rename s02q11d reason_didnot_go
rename s02q11d_s reason_other
*saving dataset--------------------------------*
save "$merged_data/education.dta", replace
*************************----------------------------***************************
*----------------------Using Dataset Section_3 Dataset-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_3.dta"
*renaming variables***
rename s03q01 disability
rename s03q02a health_preven_usual_act
rename s03q02b_1 prevent_shrawan72
rename s03q02b_2 prevent_bhadra72
rename s03q02b_3 prevent_asoj72
rename s03q02b_4 prevent_kartik72
rename s03q02b_5 prevent_mangsir72
rename s03q02b_6 prevent_poush72
rename s03q02b_7 prevent_magh72
rename s03q02b_8 prevent_falgun72
rename s03q02b_9 prevent_chaitra72
rename s03q02b_10 prevent_baisakh73
rename s03q02b_11 prevent_jestha73
rename s03q02b_12 prevent_asar73
rename s03q02b_13 prevent_shrawan73
rename s03q02b_14 prevent_bhadra73

rename s03q03_1 days_stopped_shrawan72
rename s03q03_2 days_stopped_bhadra72
rename s03q03_3 days_stopped_asoj72 
rename s03q03_4 days_stopped_kartik72 
rename s03q03_5 days_stopped_mangsir72 
rename s03q03_6 days_stopped_poush72 
rename s03q03_7 days_stopped_magh72 
rename s03q03_8 days_stopped_falgun72 
rename s03q03_9 days_stopped_chaitra72 
rename s03q03_10 days_stopped_baisakh73
rename s03q03_11 days_stopped_jestha73
rename s03q03_12 days_stopped_asar73 
rename s03q03_13 days_stopped_shrawan73 
rename s03q03_14 days_stopped_bhadra73

rename s03q04 consult_treatment
rename s03q05a cosult_doctor_gov
rename s03q05b consult_paramed_gov 
rename s03q05c consult_kabiraj_gov 
rename s03q05d consult_paramed_gvt 
rename s03q05e consult_doctor_pvt
rename s03q05f consult_pharmcst
rename s03q05g consult_paramed_pvt 
rename s03q05h consult_tradnl 
rename s03q05i consult_other

rename s03q06a amt_doctor
rename s03q06b amt_diagnosis 
rename s03q06c amt_medcns 
rename s03q06d amt_transpt_med 
rename s03q06e amt_other

rename s03q07a diarrhoea_suffer
rename s03q07b_1 diarrhoea_shrawan72
rename s03q07b_2 diarrhoea_bhadra72
rename s03q07b_3 diarrhoea_asoj72
rename s03q07b_4 diarrhoea_kartik72
rename s03q07b_5 diarrhoea_mangsir72
rename s03q07b_6 diarrhoea_poush72
rename s03q07b_7 diarrhoea_magh72 
rename s03q07b_8 diarrhoea_falgun72 
rename s03q07b_9 diarrhoea_chaitra72 
rename s03q07b_10 diarrhoea_baisakh73 
rename s03q07b_11 diarrhoea_jestha73 
rename s03q07b_12 diarrhoes_asar73 
rename s03q07b_13 diarrhoea_shrawan73
rename s03q07b_14 diarrhoea_bhadra73 
rename s03q08 diarrhoea_ors_treat

*saving the file in work directory
save "$merged_data/health.dta", replace

*************************----------------------------***************************
*----------------------Using Dataset Section_4 Dataset-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_4.dta"
*renaming variables***
rename s04q00 living_same
rename s04q00a reason_other_live

rename s04q01 slope_plot
rename s04q02 num_storey
rename s04q03 ownership
rename s04q04a rented
rename s04q04b rent_recvd
rename s04q05  occupancy 

rename s04q05a cost_rent

rename s04q06 rent_paid
rename s04q07 only_hh_occup 
rename s04q08 rooms_occup_hhmemb

rename s04q09a alwys_lived_house
rename s04q10 years_lived
rename s04q09b alwys_lived_vdc 
rename s04q09c alwys_lived_dist
rename s04q11 kitchen_garden

rename s04q12 change_plot

rename s04q12a plot_unit

rename s04q12b_r housing_plot_ropani
rename s04q12b_a housing_plot_Aana
rename s04q12b_p housing_plot_Pathi
rename s04q12b_b housing_plot_bigha
rename s04q12b_k housing_plot_kaththa
rename s04q12b_d housing_plot_dhur
rename s04q13 dwell_length
rename s04q14 dwell_width

rename s04q15 wall_matter
rename s04q16 foundation_matter
rename s04q17 roof_matter
rename s04q18 build_house_year
rename s04q19 value_house
rename s04q20_1 water_piped
rename s04q20_2 water_well
rename s04q20_3 water_handpump
rename s04q20_4 water_openwell
rename s04q20_5 water_spring
rename s04q20_6 water_river
rename s04q20_7 water_other

rename s04q21 amt_paid_water
rename s04q22 toilet_type
rename s04q23 amt_paid_elect
rename s04q24a_1 telephone
rename s04q24a_2 mobile
rename s04q24a_3 cable_tv
rename s04q24a_4 internet

rename s04q24a_998 none_faclts

rename s04q24b amt_paid_commn

rename s04q25 fuel_type
rename s04q26 stove_type

rename s04q27c connected_waste
rename s04q27d garbage_disposal
rename s04q27e garbage_pmt

rename s04q28a nearest_mkt
rename s04q28b_1 nearest_mkt_foot
rename s04q28b_2 nearest_mkt_cycle
rename s04q28b_3 nearest_mkt_motbike
rename s04q28b_4 nearest_mkt_carbus
rename s04q28c nearest_mkt_time

rename s04q29b_1 nearest_bank_foot
rename s04q29b_2 nearest_bank_cycle
rename s04q29b_3 nearest_bank_motbike
rename s04q29b_4 nearest_bank_carbus
rename s04q29a nearest_bank_dist
rename s04q29c nearest_bank_time

rename s04q30b_1 near_blacktop_foot
rename s04q30b_2 near_blacktop_cycle
rename s04q30b_3 near_blacktop_motbike
rename s04q30b_4 near_blacktop_carbus
rename s04q30a near_blacktop_dist
rename s04q30c near_blacktop_time

rename s04q31b_1 near_motorable_foot
rename s04q31b_2 near_motorable_cycle
rename s04q31b_3 near_motorable_motbike
rename s04q31b_4 near_motorable_carbus
rename s04q31a near_motorable_dist
rename s04q31c near_motorable_time

rename s04q32b_1 near_primskool_foot
rename s04q32b_2 near_primskool_cycle
rename s04q32b_3 near_primskool_motbike
rename s04q32b_4 near_primskool_carbus
rename s04q32a near_primskool_dist
rename s04q32c near_primskool_time

rename s04q33b_1 near_secskool_foot
rename s04q33b_2 near_secskool_cycle
rename s04q33b_3 near_secskool_motbike
rename s04q33b_4 near_secskool_carbus
rename s04q33a near_secskool_dist
rename s04q33c near_secskool_time

rename s04q34b_1 near_helthpst_foot
rename s04q34b_2 near_helthpst_cycle
rename s04q34b_3 near_helthpst_motbike
rename s04q34b_4 near_helthpst_carbus
rename s04q34a near_helthpst_dist
rename s04q34c near_helthpst_time

rename s04q10a sep_kitchen
**saving the file in work directory
save "$merged_data/housing_access_services.dta", replace
*************************----------------------------***************************
*------------------------Merging Dataset Section 0-4---------------------------*
*************************----------------------------***************************

use "$merged_data/consent_info.dta"
merge 1:1 hhid using "$merged_data/housing_access_services.dta"
drop _merge
save "$merged_data/section0nd4.dta", replace

use "$merged_data/hh_basic_info.dta"
merge 1:1 member_id hhid using "$merged_data/health.dta"
drop _merge
save "$merged_data/section1nd3.dta", replace
merge 1:1 member_id hhid using "$merged_data/education.dta", keep(master matched)
drop _merge
save "$merged_data/section1_2_3.dta", replace
merge m:1 hhid using "$merged_data/section0nd4.dta", keep (matched using)
drop _merge
save "$merged_data/section_0to4.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_7.dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_7.dta"
*renaming the variables***
rename s07q03a work_place
rename s07q03b out_worktype
rename s07q01a work_in_year

rename s07q03b_i reason_return
rename s07q03b_ii reason_return_other
rename s07q03b_iii look_for_emp

rename s07q03_1 work_shrawan72
rename s07q03_2 work_bhadra72
rename s07q03_3 work_asoj72
rename s07q03_4 work_kartik72
rename s07q03_5 work_mangsir72
rename s07q03_6 work_poush72
rename s07q03_7 work_magh72
rename s07q03_8 work_falgun72
rename s07q03_9 work_chaitra72
rename s07q03_10 work_baisakh73
rename s07q03_11 work_jestha73
rename s07q03_12 work_asar73
rename s07q03_13 work_shrawan73
rename s07q03_14 work_bhadra73

rename s07q04_1 days_work_shrawan72
rename s07q04_2 days_work_bhadra72
rename s07q04_3 days_work_asoj72
rename s07q04_4 days_work_kartik72
rename s07q04_5 days_work_mangsir72
rename s07q04_6 days_work_poush72
rename s07q04_7 days_work_magh72
rename s07q04_8 days_work_falgun72
rename s07q04_9 days_work_chaitra72
rename s07q04_10 days_work_baisakh73
rename s07q04_11 days_work_jestha73
rename s07q04_12 days_work_asar73
rename s07q04_13 days_work_shrawan73
rename s07q04_14 days_work_bhadra73

rename s07q05 hrs_per_day
rename s07q06 work_type
*saving the dataset in workdirectory
save "$merged_data/job_time_use", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_8.dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_8.dta"
*renaming the variables***
rename s08q02 emp_sector
rename s08q03 reside_elsewhere
rename s08q04 reside_place
rename s08q04a location_if_othr
rename s08q05 contract_type
rename s08q06 wage_daily

rename s08q07a_1 value_kind_paddy
rename s08q07a_2 value_kind_wheat
rename s08q07a_3 value_kind_maize
rename s08q07a_4 value_kind_meals
rename s08q07a_5 value_kind_cloth
rename s08q07a_6 value_kind_other
rename s08q07a_7 kind_nthng
rename s08q07a_s value_others

rename s08q08 value_kind_rcvd
rename s08q09 job_sector_lngtrm
rename s08q10 amt_rcvd_year
rename s08q11a_1 lngtrm_kind_paddy
rename s08q11a_2 lngtrm_kind_wheat
rename s08q11a_3 lngtrm_kind_maize
rename s08q11a_4 lngtrm_kind_meals
rename s08q11a_5 lngtrm_kind_cloth
rename s08q11a_6 lngtrm_kind_other
rename s08q11a_7 lngtrm_nthng 
rename s08q11b amt_kind_rcvd

rename s08q12a amt_wage_month
rename s08q12b amt_travel_allowanc
rename s08q12c amt_bonuses_year
rename s08q12d amt_clothallowance_year
rename s08q12e amt_other_year
rename s08q13 amt_contractwork
 *saving the dataset--------------------------------*
save "$merged_data/wages_salaries.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_11.dta----------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_11.dta"
*Rename Variables
rename s11q00d still_migrant
rename s11q00e live_current
rename s11q00f live_current_other
rename s11q01a name_inc_hhroster

rename s11q01b memb_no_roster

rename s11q01c gender
rename s11q01d age
rename s11q01e education
rename s11q01f grade_current

rename s11q01g highest_grade

rename s11q02 migrate_where
rename s11q02a local_destntn
rename s11q02b overseas_destntn

rename s11q02d country 
rename s11q02e first_month_migration
rename s11q03 month_migrated
rename s11q04a_1 migrate_marriage
rename s11q04a_2 migrate_follow
rename s11q04a_3 migrate_otherfamreason
rename s11q04a_4 migrate_education
rename s11q04a_5 migrate_train
rename s11q04a_6 migrate_worksearch
rename s11q04a_7 migrate_newjobbus
rename s11q04a_8 migrate_jobtrans
rename s11q04a_9 migrate_conflictfam
rename s11q04a_10 migrate_disas
rename s11q04a_11 migrate_easylife
rename s11q04a_998 migrate_other
rename s11q04a_s migrate_otherreasn

rename s11q05a actvt_newplace
rename s11q05a_s actvt_newplace_other
rename s11q05b prim_job_type
rename s11q05c earn_prim
rename s11q06a second_job
rename s11q06b second_job_type
rename s11q06c earn_secod_job

rename s11q07a remit_sent 
rename s11q07b remit_freq
rename s11q07c remit_amt
rename s11q07d_1 remit_bank
rename s11q07d_2 remit_friends
rename s11q07d_3 remit_hundi
rename s11q07d_4 remit_other

rename s11q07e_1 remit_use_nondurble
rename s11q07e_2 remit_use_durble
rename s11q07e_3 remit_use_educ
rename s11q07e_4 remit_use_health
rename s11q07e_5 remit_use_business
rename s11q07e_6 remit_use_busequip
rename s11q07e_7 remit_use_land
rename s11q07e_8 remit_use_animal
rename s11q07e_9 remit_use_farm
rename s11q07e_10 remit_use_dwelling
rename s11q07e_11 remit_use_improvedwell
rename s11q07e_12 remit_use_ceremony
rename s11q07e_13 remit_use_migr
rename s11q07e_14 remit_debtpmt
rename s11q07e_15 remit_use_other
rename s11q07e_f remit_other_sector

rename s11q08a migration_cost
rename s11q08b migration_cost_amt
rename s11q08c_1 migration_cost_loan
rename s11q08c_2 migration_cost_saving
rename s11q08c_3 migration_cost_saleasst
rename s11q08c_4 migration_cost_other
rename s11q09 migrant_ill
rename s11q10a migrant_day_disturb
rename s11q10b amt_spent_treat
rename s11q11 migrant_back

 
*Saving the Dataset----------------------*
save "$wave3/migration_remittance.dta", replace 
*************************----------------------------***************************
*------------------------Use Dataset Section_11(a).dta----------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_11a.dta"
*Rename Variables
rename s11aq01_1 migr_other
rename s11aq01_2a migr_year
rename s11aq01_2b migr_start_month
rename s11aq01_2c migr_year_month
rename s11aq01_3a migr_end_year
rename s11aq01_3b migr_end_month
rename s11aq01_3c migr_year_mnth_end
rename s11aq02 migr_local_overseas
rename s11aq02a migr_district
rename s11aq02b migr_country
rename s11aq02b_i migr_other_spec
rename s11aq03a work_types
rename s11aq03a_i work_types_other
rename s11aq03b primary_work
rename s11aq03c earning_month
rename s11aq04a cost_migrating
rename s11aq04b amount

*Saving the Dataset-------------------------*
save "$wave3/migration.dta", replace
*************************----------------------------***************************
*-------------------Merge Dataset Section_11(a) and 11.dta---------------------*
*************************----------------------------***************************

use "$wave3/migration.dta"
merge m:1 hhid member_id using "$wave3/migration_remittance.dta", keep (master using matched)
drop _merge
save "$merged_data/migration_remittance.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_14(a).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_14a.dta"

*Renaming the variables*********
rename s14q02 hhmemb_rcvd_partcpt
rename s14q03_0b firstmemb_id
rename s14q03_1b secondmemb_id
rename s14q03_2b thirdmemb_id
rename s14q04a asst_rcvd_past4
rename s14q04b asst_rcvd_past12
rename s14q04c freq_rcvd_past12

rename s14q04d_1 asst_shrawan72
rename s14q04d_2 asst_bhadra72
rename s14q04d_3 asst_asoj72
rename s14q04d_4 asst_kartik72
rename s14q04d_5 asst_mangsir72
rename s14q04d_6 asst_poush72
rename s14q04d_7 asst_magh72
rename s14q04d_8 asst_falgun72
rename s14q04d_9 asst_chaitra72
rename s14q04d_10 asst_baisakh73
rename s14q04d_11 asst_jestha73
rename s14q04d_12 asst_asar73
rename s14q04d_13 asst_shrawan73
rename s14q04d_14 asst_bhadra73

rename s14q05a_1 assisted_by_commty
rename s14q05a_2 assisted_by_socmoblizer
rename s14q05a_3 assisted_by_vdcrep
rename s14q05a_4 assisted_by_othrgov
rename s14q05a_5 assisted_by_othrbenef
rename s14q05a_6 assisted_by_famfrnd
rename s14q05a_7 assisted_by_others
rename s14q05a_8 assisted_by_none

rename s14q06a face_diffculty
rename s14q06b_1 reachvdc_difficult
rename s14q06b_2 no_docs
rename s14q06b_3 no_support_vdc
rename s14q06b_4 other_reason
rename s14q06_s other_specify
rename s14q06c difficult_access
rename s14q06e_1 pmt_irregular
rename s14q06e_2 info_lack
rename s14q06e_3 diff_vdcreach
rename s14q06e_4 other_prblm

rename s14q07 grievnce_filed
rename s14q08a grievance_about
rename s14q08b grievance_filed_with
rename s14q08c reason_notfiling
rename s14q09a aware_about_bank
rename s14q09b rcvd_from_bank
rename s14q09c have_bank_acc
rename s14q09d diff_face_transfer
rename s14q09g transfer_easier
rename s14q09h convnance_type
rename s14q09h_s other_specific

*Saving Dataset----------------------*
save "$wave3/section_14a.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_14(b).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_14b.dta"
*Renaming variables********************
rename s14q11 hhmemb_partcpt
rename s14q12_0b firstmemb_idkind
rename s14q12_1b secondmemb_idkind
rename s14q12_2b thirdmemb_idkind
rename s14q12_3b fourthmemb_idkind
rename  s14q13a_eng benft_to_rcv
rename s14q13b_eng benft_act_rcvd

rename s14q13a_i quant_benefit
rename  s14q13b_i value_benefit
rename s14q14 diff_access

*Saving Dataset-------------------------*
save "$wave3/section_14b.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_14(c).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_14c.dta"
*Renaming variables********************
rename s14q17 hhmemb_partcpt_pw
rename s14q18_1b firstmemb_idpw
rename s14q18_2b secondmemb_idpw
rename s14q18_3b thirdmemb_idpw
rename s14q19 emp_frm_scheme
rename s14q20 paid_wage_kind
rename s14q21a daily_wage_toget

rename s14q22a wage_act_paid
rename s14q22b earning_if_other
rename s14q23 diff_access_prog

*Saving Dataset-------------------------*
save "$wave3/section_14c.dta", replace


*************************----------------------------***************************
*------------------------Merge Dataset for section 14--------------------------*
*************************----------------------------***************************
use "$wave3/section_14a.dta"
merge m:m hhid using "$wave3/section_14b.dta", keep (match master)
drop _merge
save "$wave3/section_14ab.dta", replace
merge m:m hhid using "$wave3/section_14c.dta"
drop _merge
save "$merged_data/Public_Assistance.dta", replace

*************************----------------------------***************************
*------------------------Merging all the datasets------------------------------*
*************************----------------------------***************************
use "$merged_data/section_0to4.dta"
merge m:m member_id hhid using "$merged_data/job_time_use.dta", keep (match master using)
drop _merge

save "$merged_data/0_to_7.dta", replace
use "$merged_data/wages_salaries.dta"
merge m:m hhid member_id using "$merged_data/0_to_7.dta", keep (match using)
drop _merge
order member_id, after(hhid)
save "$merged_data/0_to_8.dta", replace

use "$merged_data/0_to_8.dta" 

merge m:1 hhid member_id using "$merged_data/migration_remittance.dta", keep (match master using)
drop _merge
save "$merged_data/0_to_11.dta", replace

merge m:m hhid using "$merged_data/Public_Assistance.dta"
drop _merge
save "$merged_data/0_to_14.dta", replace
gen year=2018
order year, after(member_id)
save "$merged_data/wave_3.dta", replace
