* Renaming *

rename n_31_0_0 male
label var male "Male dummy"
rename n_34_0_0 yob
rename n_52_0_0 mob 

rename n_48_0_0 wc
rename n_48_1_0 wc_1
rename n_48_2_0 wc_2
rename n_48_3_0 wc_3

rename n_49_0_0 hc
rename n_49_1_0 hc_1
rename n_49_2_0 hc_2
rename n_49_3_0 hc_3

rename n_129_0_0 ncb
rename n_129_1_0 ncb_1
rename n_129_2_0 ncb_2

rename n_130_0_0 ecb
rename n_130_1_0 ecb_1
rename n_130_2_0 ecb_2

rename n_1647_0_0 birth_country
rename n_1647_1_0 birth_country_1
rename n_1647_2_0 birth_country_2

rename n_1767_0_0 adopted 
rename n_1767_1_0 adopted_1
rename n_1767_2_0 adopted_2
rename n_1767_3_0 adopted_3

rename n_1777_0_0 multiple_birth
rename n_1777_1_0 multiple_birth_1
rename n_1777_2_0 multiple_birth_2

rename n_1787_0_0 maternal_smoking 
rename n_1787_1_0 maternal_smoking_1
rename n_1787_2_0 maternal_smoking_2

rename n_1845_0_0 maternal_age 
rename n_1845_1_0 maternal_age_1 
rename n_1845_2_0 maternal_age_2 
rename n_1845_3_0 maternal_age_3

rename n_1873_0_0 number_brothers
rename n_1873_1_0 number_brothers_1
rename n_1873_2_0 number_brothers_2
rename n_1873_3_0 number_brothers_3

rename n_1883_0_0 number_sisters
rename n_1883_1_0 number_sisters_1
rename n_1883_2_0 number_sisters_2
rename n_1883_3_0 number_sisters_3

rename n_2443_0_0 diabetes
rename n_2443_1_0 diabetes_1
rename n_2443_2_0 diabetes_2
rename n_2443_3_0 diabetes_3

rename n_2946_0_0 father_age
rename n_2946_1_0 father_age_1
rename n_2946_2_0 father_age_2
rename n_2946_3_0 father_age_3

rename n_5057_0_0 older_siblings
rename n_5057_1_0 older_siblings_1
rename n_5057_2_0 older_siblings_2
rename n_5057_3_0 older_siblings_3

rename n_21000_0_0 ethnic
rename n_21000_1_0 ethnic_1
rename n_21000_2_0 ethnic_2

rename n_21001_0_0 bmi 
rename n_21001_1_0 bmi_1
rename n_21001_2_0 bmi_2
rename n_21001_3_0 bmi_3

rename n_21022_0_0 age

rename n_23105_0_0 basal 
rename n_23105_1_0 basal_1
rename n_23105_2_0 basal_2
rename n_23105_3_0 basal_3

rename n_23405_0_0 ldl
rename n_23405_1_0 ldl_1

rename n_30690_0_0 cholest
rename n_30690_1_0 cholest_1

rename n_30740_0_0 glucose
rename n_30740_1_0 glucose_1

rename n_30750_0_0 haemo
rename n_30750_1_0 haemo_1

rename n_30760_0_0 hdl 
rename n_30760_1_0 hdl_1

rename n_30870_0_0 trigl
rename n_30870_1_0 trigl_1

rename n_120007_0_0 diabetes_ever

* Generating dummy for being a woman * 

gen female = .
replace female = 0 if male == 1
replace female = 1 if male == 0
label var female "Female dummy" 