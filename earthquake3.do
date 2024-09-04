clear all
version 18
capture log close
********************************************************************************
*Project Title: Nepal Household Vulnerability Studies						   *
*Description: For Nepal Earthquake study									   *
*Dataset: World Bank														   *
*Author: Ramesh Dulal 														   *
********************************************************************************
*I am using one of the datasets from the folders
*==============================================================================*
*          WORKING DIRECTORIES  & DATA LOADING                                 *
*------------------------------------------------------------------------------*
global user  1   // change the number to your user number

if $user == 1 { 
    global workdir "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work"
}
if $user == 2 {
    global projectfolder " "  // Enter the file path to your projectfolder here
}

global do "$workdir/do"
global data "$workdir/data"
global docs "$workdir/docs"

cap{
    mkdir "$do"
	mkdir "$data"
	mkdir "$docs"
}
global raw_data_1 "/Users/rameshdulal/Documents/Data/NPL_2016-2018_HRVS_v02_M_STATA12/Wave 1 - Household"
global raw_data_2 "/Users/rameshdulal/Documents/Data/NPL_2016-2018_HRVS_v02_M_STATA12/Wave 2 - Household"
global raw_data_3 "/Users/rameshdulal/Documents/Data/NPL_2016-2018_HRVS_v02_M_STATA12/Wave 3 - Household"

*Entering my work directory
cd "$workdir"
cap{
mkdir "$data/wave_3"
}
global wave3 "$data/wave_3"
cap{
	mkdir "$data/wave_3/merged_data3"
}
global merged_data "$data/wave_3/merged_data3"

**Creating a log file
set logtype smcl
log using "$do/nepal_earthquake_3.smcl", replace


********************************************************************************
*************************----------------------------***************************
*-----------------------Using dataset from Round 2-----------------------------*
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
*----------------------Using Dataset Section_5(a) Dataset-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_5a.dta"
*renaming the variables***
rename s05q01 qty_cons_homep
rename s05q02 unit
rename s05q03 expense_if_bought
rename s05q04 qty_cons_bought
rename s05q05 unit_bought
rename s05q06 expense_to_buy
rename s05q07 qty_cons_inkind
rename s05q08 unit_kind
rename s05q09 value_kind
*save the dataset--------------------------------*
save "$wave3/section_5a.dta", replace

*************************----------------------------***************************
*----------------------Using Dataset Section_5(b) Dataset----------------------*
*************************----------------------------***************************

use "$raw_data_3/Section_5b.dta"
*Renaming the varibles
rename s05q10 worried
rename s05q11a most_worried_month
rename s05q11b how_worried_thatmonth
rename s05q12 eat_small_meal
rename s05q13 eat_few_meal
rename s05q14 sleep_no_meal
rename s05q15 daynight_no_meal
rename s05q16 nofood_any
rename s05q17 nofood_preferred
rename s05q18 limited_variety
rename s05q19 disliked_eat
save "$wave3/section_5b.dta", replace

*************************----------------------------***************************
*----------------------Merging Dataset 5(a) and 5(b)---------------------------*
*************************----------------------------***************************
use "$wave3/section_5a.dta"

merge m:1 hhid using "$wave3/section_5b.dta"
drop _merge
save "$merged_data/foodexp_homeprodn", replace

*************************----------------------------***************************
*----------------------Using Dataset Section_6(a) Dataset----------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_6a.dta"
*renaming the variables***
rename s06q01a value_month
rename s06q01b value_year
*Saving the dataset--------------------------------*
save "$wave3/section_6(a)", replace

*************************----------------------------***************************
*----------------------Using Dataset Section_6(b) Dataset----------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_6b.dta"
*renaming the variables***
rename s06q02 infreq_exp_year
*saving the dataset--------------------------------*
save "$wave3/section_6(b)", replace

*************************----------------------------***************************
*----------------------Using Dataset Section_6(c) Dataset----------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_6c.dta"
*renaming the variables***
rename s06q03a num_item
rename s06q03b value_item
*saving the dataset--------------------------------*
save "$wave3/section_6(c)", replace

*************************----------------------------***************************
*----------------------Using Dataset Section_6(d) Dataset----------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_6d.dta"
*renaming the variables***
rename s06q04a self_own_item
rename s06q04b self_amt_month 
rename s06q04c self_amt_year
*saving the dataset--------------------------------*
save "$wave3/section_6(d)", replace

*************************----------------------------***************************
*-------------------Merging 6(a) 6(b) 6(c) and 6(d) datasets-------------------*
*************************----------------------------***************************

use "$wave3/section_6(a).dta"
append using "$wave3/section_6(b).dta"
save "$wave3/section_6(a_b).dta", replace

use "$wave3/section_6(a_b).dta"
append using "$wave3/section_6(c).dta"
save "$wave3/section_6(a_b_c).dta", replace
use "$wave3/section_6(d).dta"
merge 1:m hhid using "$wave3/section_6(a_b_c).dta"
drop _merge
save "$merged_data/nonfood_inventory.dta", replace

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
*------------------------Using Dataset Section_9(a1).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9a1.dta"
*rename the variables***
rename s09q03a area_unit
rename s09q03b_r area_ropani
rename s09q03b_a area_aana
rename s09q03b_p area_paisa
rename s09q03b_b area_bigha
rename s09q03b_k area_kaththa
rename s09q03b_d area_dhur
rename s09q04a plot_district
rename s09q04b plot_vdc
rename s09q05 land_type
rename s09q06 land_cost

rename s09q07 wet_use
rename s09q08a rent_cash_wetseason
rename s09q08b rent_kind_wetseason
rename s09q09 irrigsn_mode_wetseason
rename s09q10 irrigsn_type_wetseason
rename s09q11 dry_use
rename s09q12a rent_cash_dryseason
rename s09q12b rent_kind_dryseason
rename s09q13 irrigsn_mode_dryseason
rename s09q14 irrigsn_type_dryseason

*saving the dataset--------------------------------*
save "$wave3/section_9a1.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_9(a2).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9a2.dta"
*rename the variables***

rename shared_plotID plotid_shared
rename s09q15 share_plot
rename s09q16 plots_share_rented
rename s09q17 contract_arrangmnt
rename s09q18 rent_year

rename s09q19__1 share_paddy
rename s09q19__2 share_wheat
rename s09q19__3 share_maize
rename s09q19__4 share_millet
rename s09q19__5 share_barley 
rename s09q19__6 share_buckwheat
rename s09q19__7 share_othercerl
rename s09q19__8 share_soybean
rename s09q19__9 share_blackgram
rename s09q19__10 share_redgram
rename s09q19__11 share_grasspea
rename s09q19__12 share_lentil
rename s09q19__13 share_gram
rename s09q19__14 share_pea
rename s09q19__15 share_greengram
rename s09q19__16 share_crop_landowner
rename s09q19__17 shared_coarsegram
rename s09q19__18 shared_otherlegum
rename s09q19__19 shared_potato
rename s09q19__20 shared_swetpotato
rename s09q19__21 shared_colocasia
rename s09q19__22 shared_othertubers
rename s09q19__23 shared_mustard
rename s09q19__24 shared_groundnut
rename s09q19__25 shared_linseed
rename s09q19__26 shared_sesame
rename s09q19__27 shared_otheroilseed
rename s09q19__28 shared_sugrcane
rename s09q19__29 shared_jute
rename s09q19__30 shared_tobacco
rename s09q19__31 shared_othercashcrp
rename s09q19__32 shared_chilies
rename s09q19__33 shared_onions
rename s09q19__34 shared_garlic
rename s09q19__35 shared_ginger
rename s09q19__36 shared_turmeric
rename s09q19__37 shared_cardamom
rename s09q19__38 shared_coriander
rename s09q19__39 shared_otherspic
rename s09q19__40 shared_veg
rename s09q19__41 shared_orange
rename s09q19__42 shared_lemon
rename s09q19__43 shared_lime
rename s09q19__44 shared_swtlime
rename s09q19__45 shared_othrcitr
rename s09q19__46 shared_mango
rename s09q19__47 shared_banana
rename s09q19__48 shared_guava
rename s09q19__49 shared_jackfruit
rename s09q19__50 shared_pineapple
rename s09q19__51 shared_lichee
rename s09q19__52 shared_pear
rename s09q19__53 shared_apple
rename s09q19__54 shared_plum
rename s09q19__55 shared_papaya
rename s09q19__56 shared_pomegr
rename s09q19__57 shared_otherfrut
rename s09q19__58 shared_tea
rename s09q19__59 shared_thatch
rename s09q19__60 shared_foodertr
rename s09q19__61 shared_bamboo
rename s09q19__62 shared_othrtr

rename s09q20 shared_cash
rename s09q21a unit_land
rename s09q21b_r area_shared_ropani
rename s09q21b_a area_shared_aana
rename s09q21b_p area_shared_paisa
rename s09q21b_b area_shared_bigha
rename s09q21b_k area_shared_kaththa
rename s09q21b_d area_shared_dhur
rename s09q21b_sqm area_shared
rename s09q22 land_shared_type
rename s09q23 irrigatd_rainfed
rename s09q24 seasonl_yearround_irrig
rename s09q25a irrig_mode_dry
rename s09q25b irrig_mode_wet

*save the dataset--------------------------------*
save "$wave3/section_9a2.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_9(a3).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9a3.dta"
*rename the variables***
rename s09q26 land_sold
rename s09q27a unit_sold
rename s09q27b_r sold_ropani
rename s09q27b_a sold_aana
rename s09q27b_p sold_paisa
rename s09q27b_b sold_bigha
rename s09q27b_k sold_kaththa
rename s09q27b_d sold_dhur
rename s09q28a amt_sale
rename s09q28b current_value
rename s09q29 land_buy
rename s09q30a unit_buy
rename s09q30b_r buy_ropani
rename s09q30b_a buy_aana
rename s09q30b_p buy_paisa
rename s09q30b_b buy_bigha
rename s09q30b_k buy_kaththa
rename s09q30b_d buy_dhur 
rename s09q31a amt_buy
rename s09q31b current_value_buy

*Saving dataset--------------------------------*
save "$wave3/section_9a3.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_9(a4).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9a4.dta"
*rename variables***
rename s09q32_1 paddy_wet
rename s09q32_2 wheat_wet
rename s09q32_3 maize_wet
rename s09q32_4 millet_wet
rename s09q32_5 barley_wet
rename s09q32_6 buckwheat_wet
rename s09q32_7 othercerls_wet
rename s09q32_8 soybean_wet
rename s09q32_9 blackgram_wet
rename s09q32_10 redgram_wet
rename s09q32_11 grasspea_wet
rename s09q32_12 lentil_wet
rename s09q32_13 gram_wet
rename s09q32_14 pea_wet
rename s09q32_15 greengram_wet
rename s09q32_16 seasonalcrop_wet
rename s09q32_17 coarsegram_wet
rename s09q32_18 othrlegum_wet
rename s09q32_19 potato_wet
rename s09q32_20 swtpotato_wet
rename s09q32_21 colocasia_wet
rename s09q32_22 othrtuber_wet
rename s09q32_23 mustard_wet
rename s09q32_24 groundnut_wet
rename s09q32_25 linseed_wet
rename s09q32_26 sesame_wet
rename s09q32_27 othroilseed_wet
rename s09q32_28 sugrcane_wet
rename s09q32_29 jute_wet
rename s09q32_30 tobacco_wet
rename s09q32_31 othrcash_wet
rename s09q32_32 chilies_wet
rename s09q32_33 onions_wet
rename s09q32_34 garlic_wet
rename s09q32_35 ginger_wet
rename s09q32_36 turmeric_wet
rename s09q32_37 cardamom_wet
rename s09q32_38 coriandet_wet
rename s09q32_39 othrspice_wet
rename s09q32_401 cucumbet_wet
rename s09q32_402 squash_wet
rename s09q32_403 cauli_wet
rename s09q32_404 cabbage_wet
rename s09q32_405 gourd_wet
rename s09q32_406 raddish_wet
rename s09q32_407 spinach_wet
rename s09q32_408 mushroom_wet
rename s09q32_409 tomato_wet
rename s09q32_410 gourdd_wet
rename s09q32_411 longbean_wet
rename s09q32_412 brinjal_wet

rename s09q32_413 spongegroud_wet
rename s09q32_414 pumpkin_wet
rename s09q32_415 carrot_wet
rename s09q32_416 jackfrut_wet
rename s09q32_417 okra_wet
rename s09q32_418 tamarind_wet
rename s09q32_419 broccoli_wet
rename s09q32_40 vege_wet
rename s09q32_41 orange_wet
rename s09q32_42 lemon_wet
rename s09q32_43 lime_wet
rename s09q32_44 sweetlime_wet
rename s09q32_45 othrcitrus_wet
rename s09q32_46 mango_wet
rename s09q32_47 banana_wet
rename s09q32_48 guava_wet
rename s09q32_49 jackfruit_wet
rename s09q32_50 pinappl_wet
rename s09q32_51 lichee_wet
rename s09q32_52 pear_wet
rename s09q32_53 apple_wet
rename s09q32_54 plum_wet
rename s09q32_55 papaya_wet
rename s09q32_56 pomgranat_wet
rename s09q32_57 othrfrut_wet
rename s09q32_58 tea_wet
rename s09q32_59 thatch_wet
rename s09q32_60 foodertree_wet
rename s09q32_61 bamboo_wet
rename s09q32_62 othrtree_wet
rename s09q32_998 none_wet


rename s09q33_1 paddy_dry
rename s09q33_2 wheat_dry
rename s09q33_3 maize_dry
rename s09q33_4 millet_dry
rename s09q33_5 barley_dry
rename s09q33_6 buckwheat_dry
rename s09q33_7 othercerls_dry
rename s09q33_8 soybean_dry
rename s09q33_9 blackgram_dry
rename s09q33_10 redgram_dry
rename s09q33_11 grasspea_dry
rename s09q33_12 lentil_dry
rename s09q33_13 gram_dry
rename s09q33_14 pea_dry
rename s09q33_15 greengram_dry
rename s09q33_16 seasonalcrop_dry
rename s09q33_17 coarsegram_dry
rename s09q33_18 othrlegum_dry
rename s09q33_19 potato_dry
rename s09q33_20 swtpotato_dry
rename s09q33_21 colocasia_dry
rename s09q33_22 othrtuber_dry
rename s09q33_23 mustard_dry
rename s09q33_24 groundnut_dry
rename s09q33_25 linseed_dry
rename s09q33_26 sesame_dry
rename s09q33_27 othroilseed_dry
rename s09q33_28 sugrcane_dry
rename s09q33_29 jute_dry
rename s09q33_30 tobacco_dry
rename s09q33_31 othrcash_dry
rename s09q33_32 chilies_dry
rename s09q33_33 onions_dry
rename s09q33_34 garlic_dry
rename s09q33_35 ginger_dry
rename s09q33_36 turmeric_dry
rename s09q33_37 cardamom_dry
rename s09q33_38 coriandet_dry
rename s09q33_39 othrspice_dry
rename s09q33_401 cucumbet_dry
rename s09q33_402 squash_dry
rename s09q33_403 cauli_dry
rename s09q33_404 cabbage_dry
rename s09q33_405 gourd_dry
rename s09q33_406 raddish_dry
rename s09q33_407 spinach_dry
rename s09q33_408 mushroom_dry
rename s09q33_409 tomato_dry
rename s09q33_410 gourdd_dry
rename s09q33_411 longbean_dry
rename s09q33_412 brinjal_dry

rename s09q33_413 spongegroud_dry
rename s09q33_414 pumpkin_dry
rename s09q33_415 carrot_dry
rename s09q33_416 jackfrut_dry
rename s09q33_417 okra_dry
rename s09q33_418 tamarind_dry
rename s09q33_419 broccoli_dry
rename s09q33_40 vege_dry
rename s09q33_41 orange_dry
rename s09q33_42 lemon_dry
rename s09q33_43 lime_dry
rename s09q33_44 sweetlime_dry
rename s09q33_45 othrcitrus_dry
rename s09q33_46 mango_dry
rename s09q33_47 banana_dry
rename s09q33_48 guava_dry
rename s09q33_49 jackfruit_dry
rename s09q33_50 pinappl_dry
rename s09q33_51 lichee_dry
rename s09q33_52 pear_dry
rename s09q33_53 apple_dry
rename s09q33_54 plum_dry
rename s09q33_55 papaya_dry
rename s09q33_56 pomgranat_dry
rename s09q33_57 othrfrut_dry
rename s09q33_58 tea_dry
rename s09q33_59 thatch_dry
rename s09q33_60 foodertree_dry
rename s09q33_61 bamboo_dry
rename s09q33_62 othrtree_dry

*save the dataset--------------------------------*
save "$wave3/section_9a4.dta", replace

*************************----------------------------***************************
*------------------------Merging dataset section_9a1-9a4-----------------------*
*************************----------------------------***************************
use "$wave3/section_9a1.dta"
append using "$wave3/section_9a2.dta"
save "$wave3/section_9a1_2.dta", replace

use "$wave3/section_9a3.dta"
merge 1:1 hhid using "$wave3/section_9a4.dta"
drop _merge
save "$wave3/section_9a3_4.dta", replace

use "$wave3/section_9a3_4.dta"
merge 1:m hhid using "$wave3/section_9a1_2.dta", keep (match master)
drop _merge
sort hhid
save "$wave3/section_9a1_4.dta", replace
*************************----------------------------***************************
*------------------------Using Dataset Section_9(b1).dta-----------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9b1.dta"
*rename variables***
rename s09q34a landarea_wet
rename s09q34b_r land_wet_ropani
rename s09q34b_a land_wet_aana
rename s09q34b_p land_wet_paisa
rename s09q34b_b land_wet_bigha
rename s09q34b_k land_wet_kaththa
rename s09q34b_d land_wet_dhur

rename s09q35 late_sow_wet
rename s09q36 days_latesow_wet
rename s09q37 crop_damage_wet
rename s09q38 damage_rating_wet
rename s09q39 area_damaged
rename s09q40a improvd_seed_wet
rename s09q40b fertilizer_wet
rename s09q40c pesticide_wet
rename s09q41a qty_harvest_wet
rename s09q41b unit_harvest_wet
rename s09q41c qty_hrvst_tolandloed_wet
rename s09q41d Unit_hrvst_tolandlord_wet
rename s09q41e qty_sold_wet
rename s09q41f unit_sold_wet
rename s09q42 price_wet

*Save the dataset--------------------------------*
save "$wave3/section_9b1.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_9(b2).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9b2.dta"
*rename variables***
rename s09q43a landarea_dry
rename s09q43b_r land_dry_ropani
rename s09q43b_a land_dry_aana
rename s09q43b_p land_dry_paisa
rename s09q43b_b land_dry_bigha
rename s09q43b_k land_dry_kaththa
rename s09q43b_d land_dry_dhur

rename s09q44 late_sow_dry
rename s09q45 days_latesow_dry
rename s09q46 crop_damage_dry
rename s09q47 damage_rating_dry
rename s09q48 area_damaged
rename s09q49a improvd_seed_dry
rename s09q49b fertilizer_dry
rename s09q49c pesticide_dry
rename s09q50a qty_harvest_dry
rename s09q50b unit_harvest_dry
rename s09q50c qty_hrvst_tolandloed_dry
rename s09q50d Unit_hrvst_tolandlord_dry
rename s09q50e qty_sold_dry
rename s09q50f unit_sold_dry
rename s09q51 price_dry

*Save the dataset--------------------------------*
save "$wave3/section_9b2.dta", replace
*************************----------------------------***************************
*-------------------Appending Dataset Section_9(b1)_9(b2)------------------------*
*************************----------------------------***************************
use "$wave3/section_9b2.dta"
append using "$wave3/section_9b1.dta"
sort hhid
save "$wave3/section_9b1_2.dta", replace
*************************----------------------------***************************
*------------------------Using Dataset Section_9(c).dta------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9c.dta"
*rename variables***
rename s09q52a wet_bought_seedsplants
rename s09q52b wet_amt_spentseed
rename s09q52c wet_bought_fertlizer
rename s09q52d wet_amt_spentfert
rename s09q52e wet_bought_insecticide
rename s09q52f wet_amt_spentinsect
rename s09q52g wet_rent_equip
rename s09q52h wet_amt_rent
rename s09q52i wet_hire_labor
rename s09q52j wet_amt_labor

rename s09q53a dry_bought_seedsplants
rename s09q53b dry_amt_spentseed
rename s09q53c dry_bought_fertlizer
rename s09q53d dry_amt_spentfert
rename s09q53e dry_bought_insecticide
rename s09q53f dry_amt_spentinsect
rename s09q53g dry_rent_equip
rename s09q53h dry_amt_rent
rename s09q53i dry_hire_labor
rename s09q53j dry_amt_labor

rename s09q54a rent_draft_animal
rename s09q54b rent_rcvd_draft
rename s09q54c rent_equipment
rename s09q54d rent_rcvd_equipment
rename s09q54e rent_othr
rename s09q54f income_othr
rename s09q55a spent_irrigation
rename s09q55b amt_irrigation
rename s09q55c spent_transport_agri
rename s09q55d amt_transport_agri
rename s09q55e spent_containers
rename s09q55f amt_containers 
rename s09q55g spent_storage
rename s09q55h amt_storage
rename s09q55i spent_maintenance
rename s09q55j amt_maintenance
rename s09q55k spent_improv_land
rename s09q55l amt_improv_land 
rename s09q55m spent_rent_draft
rename s09q55n amt_rent_draft
rename s09q55o spent_rent_equip
rename s09q55p amt_rent_equip
rename s09q55q spent_rent_other
rename s09q55r amt_rent_other

*Save the dataset--------------------------------*
save "$wave3/section_9c.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_9(d).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9d.dta"
*rename variables***

rename s09q57a num_owned
rename s09q57b value 
rename s09q58 num_newborn
rename s09q59a num_dead
rename s09q59b cause_death
rename s09q60a num_sold
rename s09q60b earn_sale
rename s09q61a num_bought
rename s09q61b paid_buy

*save dataset--------------------------------*
save "$wave3/section_9d.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_9(e).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9e.dta"

*Rename Variables
rename s09q62a inc_milk
rename s09q62b inc_ghee
rename s09q62c inc_eggs
rename s09q62d inc_curd
rename s09q62e inc_animal
rename s09q62f inc_fish
rename s09q62g inc_hide
rename s09q62h inc_honey
rename s09q62i inc_other_anim
rename s09q63a exp_fooder
rename s09q63b exp_transport_anim
rename s09q63c exp_vet
rename s09q63d exp_other

rename s09q64_1 equip_tractor
rename s09q64_2 equip_plough
rename s09q64_3 equip_cart
rename s09q64_4 equip_thresher
rename s09q64_5 equip_trolley
rename s09q64_6 equip_waterpump
rename s09q64_7 equip_generator
rename s09q64_8 equip_storage
rename s09q64_9 equip_tubewell
rename s09q64_10 equip_greenhouse
rename s09q64_11 equip_dripirrig
rename s09q64_12 equip_other
rename s09q64_998 equip_none
*Save Dataset----------------------*
save "$wave3/section_9e.dta", replace

*************************----------------------------***************************
*------------------------Using Dataset Section_9(f).dta---------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_9f.dta"
*Rename Variables

rename s09q65 num_equip
rename s09q66 value_ifsold
rename s09q67 num_sold_equip
rename s09q68 selling_price_equip
rename s09q69 num_bought_equip
rename s09q70 price_equip

*Save dataset--------------------------------*
save "$wave3/section_9f.dta", replace

*************************----------------------------***************************
*------------------------Merging datasets 9(a) to 9(f)-------------------------*
*************************----------------------------***************************

use "$wave3/section_9e.dta"
merge 1:1 hhid using "$wave3/section_9c.dta", keep(match using)
drop _merge
save "$wave3/section_9e_c.dta", replace
merge 1:m hhid using "$wave3/section_9a1_4.dta"
drop _merge
save "$wave3/section_9a_e_c.dta", replace
merge m:m hhid using "$wave3/section_9b1_2.dta", keep(match master)
drop _merge
save "$wave3/section_9ac_9b12.dta", replace
use "$wave3/section_9d.dta"
merge m:m hhid using "$wave3/section_9d.dta", keep(match master)
drop _merge
save "$wave3/section_9ac_9b12_9d.dta", replace

merge m:m hhid using "$wave3/section_9f.dta", keep(match master)
drop _merge
save "$merged_data/farming_livestock.dta", replace
*************************----------------------------***************************
*------------------------Use Dataset Section_10.dta----------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_10.dta"
*Rename Variables
rename s10q02 sector_firm
rename s10q02a own_type
rename s10q02b firm_share
rename s10q03 num_worker
rename s10q04 gross_rev
rename s10q05 exp_wages
rename s10q06 exp_energy
rename s10q07 exp_rawmat
rename s10q08 exp_other_opertn
rename s10q09 exp_assets
rename s10q10 rev_assets

*Saving the dataset--------------------------------*
save "$merged_data/non_agri_enterprise.dta", replace

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
*------------------------Use Dataset Section_12(a).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_12a.dta"
*Rename Variables
rename s12q03a borrower_in_roster
rename s12q03b borrower_not_reason

rename s12q04 loan_source
rename s12q05 loan_rcvd_time
rename s12q06 loan_amt

rename s12q07_1 loan_nondurable
rename s12q07_2 loan_durable
rename s12q07_3 loan_educ
rename s12q07_4 loan_health
rename s12q07_5 loan_bus_input
rename s12q07_6 loan_bus_equip
rename s12q07_7 loan_land
rename s12q07_8 loan_animal
rename s12q07_9 loan_farm
rename s12q07_10 loan_dwell
rename s12q07_11 loan_impr_dwell
rename s12q07_12 loan_ceremony
rename s12q07_13 loan_migr
rename s12q07_14 loan_debt
rename s12q07_15 loan_other

rename s12q08 repay_term
rename s12q09 interest
rename s12q10_1 collatrl_land
rename s12q10_2 collatrl_otherprop
rename s12q10_3 collatrl_gold
rename s12q10_4 collatrl_property
rename s12q10_5 collatrl_persguarantee
rename s12q10_6 collatrl_other
rename s12q10_7 collatrl_no
rename s12q11 amt_repaid

*Saving Dataset----------------------*
save "$wave3/section_12a.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_12(b).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_12b.dta"
*Rename Variables
rename s12q14a lender_inroster
rename s12q14b reason_lender_noexist

rename s12q15 reln_borrower
rename s12q16 loan_month
rename s12q17 loan_amt
rename s12q18 loan_period
rename s12q19 interest
rename s12q20_1 colatrl_agland
rename s12q20_2 colatrl_building
rename s12q20_3 colatrl_gold
rename s12q20_4 colatrl_property
rename s12q20_5 colatrl_persguarantee
rename s12q20_6 colatrl_other
rename s12q20_7 colatrl_none
rename s12q21 repaid_amt

*Saving Dataset----------------------*
save "$wave3/section_12b.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_12(c).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_12c.dta"
*Rename Variables
rename s12q23 value_asset
rename s12q24 recvd_sources

*Saving Dataset----------------------*
save "$wave3/section_12c.dta", replace
*************************----------------------------***************************
*------------------------Use Dataset Section_12(d).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_12d.dta"
*Rename Variables
rename s12q25 have_pension
rename s12q26 number_pension
rename s12q27 total_pension

*Saving Dataset----------------------*
save "$wave3/section_12d.dta", replace
*************************----------------------------***************************
*----------------------Merging datsets in section 12(a-d)----------------------*
*************************----------------------------***************************

use "$wave3/section_12c.dta"
merge m:1 hhid using "$wave3/section_12d.dta", keep(match using)
drop _merge
save "$wave3/section_12cd.dta", replace
use "$wave3/section_12cd.dta"
use "$wave3/section_12b.dta"
merge m:m hhid using "$wave3/section_12a.dta"
drop _merge
save "$wave3/section_12ab.dta", replace
use "$wave3/section_12ab.dta"
merge m:m hhid using "$wave3/section_12cd.dta", keep(match using)
drop _merge
save "$merged_data/credit_saving_financ.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_13(a).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_13a.dta"
order member_id, before(giftid)
*Rename Variables
rename s13q03 recpnt_caste
rename s13q04a donor_in_roster
rename s13q04c reason_not_roster
rename s13q05 reln_to_recipnt
rename s13q06d dist_recipnt
rename s13q07a amt_transfer
rename s13q07b value_kind_trans
rename s13q08a_1 purpose_nondurbl
rename s13q08a_2 purpose_durbl
rename s13q08a_3 purpose_educ 
rename s13q08a_4 purpose_health
rename s13q08a_5 purpose_busns_input
rename s13q08a_6 purpose_busns_equip
rename s13q08a_7 purpose_land
rename s13q08a_8 purpose_animals
rename s13q08a_9 purpose_farmuse
rename s13q08a_10 purpose_newdwellng
rename s13q08a_11 purpose_impdwell
rename s13q08a_12 purpose_ceremonies
rename s13q08a_13 purpose_migrtn
rename s13q08a_14 purpose_debtrepay
rename s13q08a_15 purpose_persuse
rename s13q08_s purpose_other


*Saving Dataset----------------------*
save "$wave3/section_13a.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_13(b).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_13b.dta"
order member_id, after (hhid)
*Rename variables***
rename s13q12 donor_caste
rename s13q13a recpnt_in_roster
rename s13q13c reason_notin_roster
rename s13q14 reln_with_donor
rename s13q15d donor_district
rename s13q16a amt_recvd
rename s13q16b amt_inkind
rename s13q17a_1 purpoz_nondurble
rename s13q17a_2 purpoz_durble
rename s13q17a_3 purpoz_educ
rename s13q17a_4 purpoz_health
rename s13q17a_5 purpoz_businput
rename s13q17a_6 purpoz_busequip
rename s13q17a_7 purpoz_land
rename s13q17a_8 purpoz_animal
rename s13q17a_9 purpoz_farm
rename s13q17a_10 purpoz_dwellbuy
rename s13q17a_11 purpoz_dwellimpr
rename s13q17a_12 purpoz_ceremny
rename s13q17a_13 purpoz_migrtn
rename s13q17a_14 purpoz_debtrepay
rename s13q17a_15 purpoz_otherpersonal

*Saving Dataset----------------------*
save "$wave3/section_13b.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_13(c).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_13c.dta"
*Rename variables*********
rename s13q19a amt_assistance
rename s13q19c value_kind_assistance
rename s13q20 recvde_before_months
rename s13q21a_1 prpoz_nondurbl
rename s13q21a_2 prpoz_durbl
rename s13q21a_3 prpoz_educ
rename s13q21a_4 prpoz_health
rename s13q21a_5 prpoz_businput
rename s13q21a_6 prpoz_busequip
rename s13q21a_7 prpoz_land
rename s13q21a_8 prpoz_animal
rename s13q21a_9 prpoz_farm
rename s13q21a_10 prpoz_newdwell
rename s13q21a_11 prpoz_impdwell
rename s13q21a_12 prpoz_ceremony
rename s13q21a_13 prpoz_migration
rename s13q21a_14 prpoz_repaydebt
rename s13q21a_15 prpoz_otherprsnal

*Saving dataset--------------------------------*
save "$wave3/section_13c.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_13(d).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_13d.dta"

*Rename variables*********
rename s13q22 donation_made
rename s13q23 donation_amt
rename s13q24a hhmember_part_community
rename s13q24b_1 group_savings
rename s13q24b_2 group_religious
rename s13q24b_3 group_youth
rename s13q24b_4 group_womens
rename s13q24b_5 group_forest
rename s13q24b_6 group_social
rename s13q24b_7 group_water
rename s13q24b_998 group_other
rename s13q24c group_type_other
*Saving the dataset--------------------------------*
save "$wave3/section_13d.dta", replace
*************************----------------------------***************************
*------------------------Mergig Dataset with section 13------------------------*
*************************----------------------------***************************

//use "$data/section_13a.dta"
use "$wave3/section_13b.dta"
use "$wave3/section_13c.dta"
use "$wave3/section_13d.dta"
merge 1:m hhid using "$wave3/section_13c.dta", keep(match master)
drop _merge
save "$wave3/section_13cd.dta", replace

merge m:m hhid using  "$wave3/section_13b.dta", keep(match master)
drop _merge
save "$wave3/section_13cdb.dta", replace

merge m:m hhid using "$wave3/section_13a.dta", keep(match master)
drop _merge
save "$merged_data/Private_assistance.dta", replace

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
*------------------------Use Dataset Section_15(a).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_15a.dta"
*Renaming Variables***********************
rename s15q02 shock_effect
rename s15q03 value_loss
rename s15q04 month_shock
rename s15q05a spend_shock
rename  s15q06a_1 spend_saving
rename s15q06a_2 spend_pawned_house
rename s15q06a_3 spend_pawn_animalfarm
rename s15q06a_4 spend_pawn_other
rename s15q06a_5 sold_house
rename s15q06a_6 sold_farmanim
rename s15q06a_7 sold_other
rename s15q06a_8 borrow_pvtbank
rename s15q06a_9 borrow_govnbank
rename s15q06a_10 borrow_moneylender
rename s15q06a_11 borrow_famfriend
rename s15q06a_12 borrow_cooperative

rename s15q06a_998 borrow_other

rename s15q07a reduce_food
rename s15q07b_1 reduce_food_cons
rename s15q07b_2 shift_cheap_food
rename s15q07b_3 rely_home_food
rename s15q07b_998 rely_other
rename s15q08a reduce_nonfood
rename s15q08b_1 reduce_nonfood_cons
rename s15q08b_2 shift_cheap_nonfood
rename s15q08b_3 stop_postpone_nonfood
rename s15q08b_998 nonfood_other
rename s15q09a shock_educ
rename s15q09b_1 pvtschool_public
rename s15q09b_2 withdraw_admission
rename s15q09b_3 skip_school
rename s15q09b_4 shift_cheap_supply
rename s15q09b_5 reduce_allowance_child
rename s15q09b_6 performance_effect
rename s15q09b_7 repeat_grade
rename s15q09b_998 educ_other
rename s15q10a rcvd_help_othr
rename s15q10b_1 assistance_relatives_finan
label var assistance_relatives_finan "Financial assistance from relatives"
rename s15q10b_2 assistance_relatives_other
label var assistance_relatives_other "Other assistance from relatives"
rename s15q10b_3 assistance_friends_finan
label var assistance_friends_finan "Financial assistance from friends/neighbors"
rename s15q10b_4 assistance_friends_other
label var assistance_friends_other "Other assistance from friends/relatives"
rename s15q10b_5 assistance_govn
label var assistance_govn "Assistance from government"
rename s15q10b_6 assistance_ngo
label var assistance_ngo "Assistance from NGO/Church"

rename s15q10c_1 cash_assistance
rename s15q10c_2 food_assistance
rename s15q10c_3 nonfood_assistance
rename s15q10d cash_amount
rename s15q10e time_rcpt_asstnce
rename s15q10f_1 applied_asstnce
rename s15q10f_2 connections_asstnce
rename s15q10f_3 nothing_asstnce
rename s15q10f_998 other_asstnce
rename s15q11a employment
rename  s15q11b_1 hhh_work_more
rename s15q11b_2 hh_look_more
rename s15q11b_3 spouse_work
rename s15q11b_4 children_5to17_work

rename s15q11b_5 child_18plus_work
rename s15q11b_6 memb_60plus_work
rename s15q11b_998 other 

rename s15q11c other_strategies

rename s15q12a living_changed
rename s15q12b_1 moved_relatives
rename s15q12b_2 relatives_move_in
rename s15q12b_3 relatives_moved_away
rename s15q12b_4 postpone_child
rename s15q12b_998 others

rename s15q12c other_specifc
rename s15q13a first_strategy
rename s15q13b second_strategy
rename s15q14 comments_shock
rename s15q06b_998 comment_shock_other

*Saving the Dataset----------------------*
save "$wave3/section_15a.dta", replace

*************************----------------------------***************************
*------------------------Use Dataset Section_15(b).dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_15b.dta"
*Renaming Variables***********************
rename s15q16a_1 get_5000_saving
rename s15q16a_2 get_5000_relativenoint
rename s15q16a_3 get_5000_relatint
rename s15q16a_4 get_5000_bank
rename s15q16a_5 get_5000_cboloan
rename s15q16a_6 get_5000_savinggroup
rename s15q16a_7 get_5000_moneylender
rename s15q16a_8 get_5000_shopkeeper
rename s15q16a_9 get_5000_other
rename s15q16a_10 get_5000_pawnhouse
rename s15q16a_11 get_5000_pawnanim
rename s15q16a_12 get_5000_pawnprop

rename s15q16a_998 get_5000_nosource

rename s15q16b_1 get_25000_saving
rename s15q16b_2 get_25000_relativenoint
rename s15q16b_3 get_25000_relatint
rename s15q16b_4 get_25000_bank
rename s15q16b_5 get_25000_cboloan
rename s15q16b_6 get_25000_savinggroup
rename s15q16b_7 get_25000_moneylender
rename s15q16b_8 get_25000_shopkeeper
rename s15q16b_9 get_25000_other
rename s15q16b_10 get_25000_pawnhouse
rename s15q16b_11 get_25000_pawnanim
rename s15q16b_12 get_25000_pawnprop
rename s15q16b_998 get_25000_nosource


*Saving the dataset--------------------------------*
save "$wave3/section_15b.dta", replace

*************************----------------------------***************************
*------------------------Merge dataset 15a and 15b-----------------------------*
*************************----------------------------***************************
use "$wave3/section_15a.dta"
merge m:1  hhid using "$wave3/section_15b.dta", keep (match using)
drop _merge

save "$merged_data/shocks_psychological.dta", replace
*duplicates tag unique_id, gen(dups)//to check the duplicate observations


*************************----------------------------***************************
*------------------------Use Dataset Section_16.dta-------------------------*
*************************----------------------------***************************
use "$raw_data_3/Section_16.dta"
*Renaming Variables***********************
rename s16q01 birth_certificate
rename s16q02 birthdate
rename s16q03 age
rename s16q04 measurement_result
rename s16q05 height

rename s16q05a height_second
rename s16q05b height_third

rename s16q06 height_method
rename s16q07a weight

rename s16q07a_1 weight_second
rename s16q07a_2 weight_third
rename s16q07b measure_mid_upprarm
rename s16q07b_1 measure_mid_upprarm2
*Saving Dataset----------------------*
save "$merged_data/anthropometry.dta", replace

*************************----------------------------***************************
*------------------------Merging all the datasets------------------------------*
*************************----------------------------***************************
use "$merged_data/housing_access_services.dta"
merge 1:1 hhid using "$merged_data/consent_info.dta"
drop _merge
save "$merged_data/section0_4.dta", replace

use "$merged_data/education.dta"

merge 1:m hhid member_id using "$merged_data/hh_basic_info.dta", keep (match using) 
drop _merge
save "$merged_data/section1_2.dta", replace
use "$merged_data/health.dta" 
merge 1:1 hhid member_id using "$merged_data/section1_2.dta"
drop _merge
save "$merged_data/section1_2_3.dta", replace
use "$merged_data/section0_4.dta"
merge 1:m hhid using "$merged_data/section1_2_3.dta", keep (match master)
drop _merge
order member_id, after(hhid)
save "$merged_data/0_to_4.dta",replace

merge m:m hhid using "$merged_data/foodexp_homeprodn.dta"
drop _merge
save "$merged_data/0_to_5.dta", replace
use "$merged_data/nonfood_inventory.dta"
merge m:m hhid using "$merged_data/0_to_5.dta"
drop _merge
order member_id, after(hhid)
save "$merged_data/0_to_6.dta", replace
use "$merged_data/0_to_6.dta"

merge m:m hhid member_id using "$merged_data/job_time_use.dta", keep (match using master)
drop _merge
save "$merged_data/0_to_7.dta", replace
use "$merged_data/wages_salaries.dta"
merge m:m hhid member_id using "$merged_data/0_to_7.dta", keep (match using)
drop _merge
order member_id, after(hhid)
save "$merged_data/0_to_8.dta", replace
use "$merged_data/farming_livestock.dta"
merge m:m hhid using "$merged_data/0_to_8.dta", keep (match using)
drop _merge
order member_id, after (hhid)
save "$merged_data/0_to_9.dta", replace

use "$merged_data/0_to_9.dta"
merge m:m hhid using "$merged_data/non_agri_enterprise.dta", keep (match master)
drop _merge
save "$merged_data/0_to_10.dta", replace

use "$merged_data/0_to_10.dta" 

merge m:1 hhid member_id using "$merged_data/migration_remittance.dta", keep (match master using)
drop _merge
save "$merged_data/0_to_11.dta", replace
merge m:m hhid member_id using  "$merged_data/credit_saving_financ.dta", keep (match master using)
drop _merge
save "$merged_data/0_to_12.dta", replace
use "$merged_data/0_to_12.dta"
merge m:m hhid using "$merged_data/Private_assistance.dta"
drop _merge
save "$merged_data/0_to_13.dta", replace
use "$merged_data/0_to_13.dta"
merge m:m hhid using "$merged_data/Public_Assistance.dta"
drop _merge
save "$merged_data/0_to_14.dta", replace
use "$merged_data/0_to_14.dta"
merge m:m hhid using "$merged_data/shocks_psychological.dta"

drop _merge
save "$merged_data/0_to_15.dta", replace
use "$merged_data/0_to_15.dta"
merge m:1 hhid member_id using "$merged_data/anthropometry.dta", keep(match using master)
drop _merge
gen year=2018 //generating year variable for each dataset//
order year, after (member_id)
save "$merged_data/wave_3.dta", replace

