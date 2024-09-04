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

*Specifying the path to the folder where I have the raw Dataset. I have three different
*folders for Raw Data as phase 1, 2 and 3
global wave1 "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work/data/Final_Data/analysis_1/data/wave_1/merged_data"
global wave2 "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work/data/Final_Data/analysis_1/data/wave_2/merged_data"
global wave3 "/Users/rameshdulal/Documents/Dissertation Materials/Nepal Earthquake /Data_Work/data/Final_Data/analysis_1/data/wave_3/merged_data"


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
*==============================================================================*
*------------------------------------------------------------------------------*
*==============================================================================*
use "$final/wave_1_2_3.dta"

drop health_preven_usual_act prevent_shrawan72 prevent_bhadra72 prevent_asoj72 prevent_kartik72 prevent_mangsir72 prevent_poush72 prevent_magh72 prevent_falgun72 prevent_chaitra72 prevent_baisakh73 prevent_jestha73 prevent_asar73 prevent_shrawan73 prevent_bhadra73 days_stopped_shrawan72 days_stopped_bhadra72 days_stopped_asoj72 days_stopped_kartik72 days_stopped_mangsir72 days_stopped_poush72 days_stopped_magh72 days_stopped_falgun72 days_stopped_chaitra72 days_stopped_baisakh73 days_stopped_jestha73 days_stopped_asar73 days_stopped_shrawan73 days_stopped_bhadra73 consult_treatment cosult_doctor_gov consult_paramed_gov consult_kabiraj_gov consult_paramed_gvt consult_doctor_pvt consult_pharmcst consult_paramed_pvt consult_tradnl consult_other amt_doctor amt_diagnosis amt_medcns amt_transpt_med amt_other diarrhoea_suffer diarrhoea_shrawan72 diarrhoea_bhadra72 diarrhoea_asoj72 diarrhoea_kartik72 diarrhoea_mangsir72 diarrhoea_poush72 diarrhoea_magh72 diarrhoea_falgun72 diarrhoea_chaitra72 diarrhoea_baisakh73 diarrhoea_jestha73 diarrhoes_asar73 diarrhoea_shrawan73 diarrhoea_bhadra73 diarrhoea_ors_treat

drop scholarship_recvd scholarship_source scholarship_govn scholarship_school scholarship_ngo scholarship_help scholarship_other scholarship_othrdetl scholarship_type scholarship_amt school_exp tuition_exp uniform_exp supplies_exp trans_exp lunch_exp other_exp school_trans pct_absent missing_reason missing_reason_other days_didnot_go reason_didnot_go reason_other

drop slope_plot num_storey ownership rented rent_recvd occupancy rent_paid only_hh_occup rooms_occup_hhmemb alwys_lived_house years_lived alwys_lived_vdc alwys_lived_dist kitchen_garden plot_unit housing_plot_ropani housing_plot_Aana housing_plot_Pathi housing_plot_bigha housing_plot_kaththa housing_plot_dhur dwell_length dwell_width wall_matter foundation_matter roof_matter build_house_year value_house water_piped water_well water_handpump water_openwell water_spring water_river water_other amt_paid_water toilet_type amt_paid_elect telephone mobile cable_tv internet amt_paid_commn fuel_type stove_type nearest_mkt nearest_mkt_foot nearest_mkt_cycle nearest_mkt_motbike nearest_mkt_carbus nearest_mkt_time nearest_bank_foot nearest_bank_cycle nearest_bank_motbike nearest_bank_carbus nearest_bank_dist nearest_bank_time near_blacktop_foot near_blacktop_cycle near_blacktop_motbike near_blacktop_carbus near_blacktop_dist near_blacktop_time near_motorable_foot near_motorable_cycle near_motorable_motbike near_motorable_carbus near_motorable_dist near_motorable_time near_primskool_foot near_primskool_cycle near_primskool_motbike near_primskool_carbus near_primskool_dist near_primskool_time near_secskool_foot near_secskool_cycle near_secskool_motbike near_secskool_carbus near_secskool_dist near_secskool_time near_helthpst_foot near_helthpst_cycle near_helthpst_motbike near_helthpst_carbus near_helthpst_dist near_helthpst_time firewood_used firewood_collected

drop value_kind_paddy value_kind_wheat value_kind_maize value_kind_meals value_kind_cloth value_kind_other kind_nthng

drop lngtrm_kind_paddy lngtrm_kind_wheat lngtrm_kind_maize lngtrm_kind_meals lngtrm_kind_cloth lngtrm_kind_other lngtrm_nthng

drop disability willing_partcpt school_type
**I am changing the values in the publcashid to columns**
tabulate pubcashid, generate(pubcashid_)

drop pubcashid pubcashid_1 pubcashid_2 pubcashid_3 pubcashid_4 pubcashid_5 pubcashid_6 pubcashid_7 pubcashid_10 pubcashid_11 pubcashid_12 pubcashid_13 pubcashid_14

drop remit_bank remit_friends remit_hundi remit_other remit_use_nondurble remit_use_durble remit_use_educ remit_use_health remit_use_business remit_use_busequip remit_use_land remit_use_animal remit_use_farm remit_use_dwelling remit_use_improvedwell remit_use_ceremony remit_use_migr remit_debtpmt remit_use_other remit_other_sector

drop migrate_marriage migrate_follow migrate_otherfamreason migrate_education migrate_train migrate_worksearch migrate_newjobbus migrate_jobtrans migrate_conflictfam migrate_disas migrate_easylife migrate_other migrate_otherreasn

drop migration_cost_loan migration_cost_saving migration_cost_saleasst migration_cost_other

drop migrant_ill migrant_day_disturb amt_spent_treat migrant_back overseas_destntn_other firstmemb_id secondmemb_id thirdmemb_id

drop assisted_by_commty assisted_by_socmoblizer assisted_by_vdcrep assisted_by_othrgov assisted_by_othrbenef assisted_by_famfrnd assisted_by_others assisted_by_none face_diffculty reachvdc_difficult no_docs no_support_vdc other_reason other_specify difficult_access pmt_irregular info_lack diff_vdcreach other_prblm grievnce_filed grievance_about grievance_filedwith reason_notfiling

drop rcvd_from_bank have_bank_acc diff_face_transfer transfer_easier convnance_type

drop connected_waste garbage_disposal garbage_pmt sep_kitchen assisted_other_specify other_prblm_spec 

drop suggsn_transfer grievance_filed_with first_month_migration cost_migrating primary_work work_types work_types_other

keep if inlist(district, 7, 9, 10, 11, 12, 13, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 35, 36, 37, 38, 39, 40, 43, 44, 45, 46, 47, 48, 51)  
