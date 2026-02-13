merge 1:1 n_eid using "Merged dataset.dta"

drop if _merge == 1 | _merge == 2

drop _merge

*** Adding additional labels ***

label var nd_1_2 "Number of days below -2 degrees Celsius (1 week before)"
label var nd_1_3 "Number of days below -3 degrees Celsius (1 week before)"
label var nd_1_5 "Number of days below -5 degrees Celsius (1 week before)"
label var nd_2_2 "Number of days below -2 degrees Celsius (2 weeks before)"
label var nd_2_3 "Number of days below -3 degrees Celsius (2 weeks before)"
label var nd_2_5 "Number of days below -5 degrees Celsius (2 weeks before)"
label var nd_31_2 "Number of days below -2 degrees Celsius (3 weeks before - 1 week after)"
label var nd_31_3 "Number of days below -3 degrees Celsius (3 weeks before - 1 week after)"
label var nd_31_5 "Number of days below -5 degrees Celsius (3 weeks before - 1 week after)"
label var nd_42_2 "Number of days below -2 degrees Celsius (4 weeks before - 2 weeks after)"
label var nd_42_3 "Number of days below -3 degrees Celsius (4 weeks before - 2 weeks after)"
label var nd_42_5 "Number of days below -5 degrees Celsius (4 weeks before - 2 weeks after)"
label var nd_53_2 "Number of days below -2 degrees Celsius (5 weeks before - 3 weeks after)"
label var nd_53_3 "Number of days below -3 degrees Celsius (5 weeks before - 3 weeks after)"
label var nd_53_5 "Number of days below -5 degrees Celsius (5 weeks before - 3 weeks after)"

label var temp_53 "Actual temperature around conception (5 weeks before - 3 weeks after)"
label var hist_53 "Expected temperature around conception (5 weeks before - 3 weeks after)"
label var dev_53 "Temperature deviation around conception (5 weeks before - 3 weeks after)"
label var temp_53_idw "Actual temperature around conception IDW (5 weeks before - 3 weeks after)"
label var hist_53_idw "Expected temperature around conception IDW (5 weeks before - 3 weeks after)"
label var dev_53_idw "Temperature deviation around conception IDW (5 weeks before - 3 weeks after)"

label var temp_42 "Actual temperature around conception (4 weeks before - 2 weeks after)"
label var hist_42 "Expected temperature around conception (4 weeks before - 2 weeks after)"
label var dev_42 "Temperature deviation around conception (4 weeks before - 2 weeks after)"
label var temp_42_idw "Actual temperature around conception IDW (4 weeks before - 2 weeks after)"
label var hist_42_idw "Expected temperature around conception IDW (4 weeks before - 2 weeks after)"
label var dev_42_idw "Temperature deviation around conception IDW (4 weeks before - 2 weeks after)"

label var temp_31 "Actual temperature around conception (3 weeks before - 1 week after)"
label var hist_31 "Expected temperature around conception (3 weeks before - 1 week after)"
label var dev_31 "Temperature deviation around conception (3 weeks before - 1 week after)"
label var temp_31_idw "Actual temperature around conception IDW (3 weeks before - 1 week after)"
label var hist_31_idw "Expected temperature around conception IDW (3 weeks before - 1 week after)"
label var dev_31_idw "Temperature deviation around conception IDW (3 weeks before - 1 week after)"

label var temp_2 "Actual temperature around conception (2 weeks before)"
label var hist_2 "Expected temperature around conception (2 weeks before)"
label var dev_2 "Temperature deviation around conception (2 weeks before)"
label var temp_2_idw "Actual temperature around conception IDW (2 weeks before)"
label var hist_2_idw "Expected temperature around conception IDW (2 weeks before)"

label var temp_1 "Actual temperature around conception (1 week before)"
label var hist_1 "Expected temperature around conception (1 week before)"
label var dev_1 "Temperature deviation around conception (1 week before)"
label var temp_1_idw "Actual temperature around conception IDW (1 week before)"
label var hist_1_idw "Expected temperature around conception IDW (1 week before)"
label var dev_1_idw "Temperature deviation around conception IDW (1 week before)"

label var temp_dob "Actual temperature around birth (Date of birth)"
label var hist_dob "Expected temperature around birth (Date of birth)"
label var temp_dob_idw "Actual temperature around birth IDW (Date of birth)"
label var hist_dob_idw "Expected temperature around birth IDW (Date of birth)"
label var distance_nn "Distance to nearest weather station in km"
label var src_id_nn "ID of nearest weather station"
label var dev_dob "Temperature deviation around birth (Date of birth)"
label var dev_dob_idw "Temperature deviation around birth IDW (Date of birth)"

label var temp_doc "Actual temperature around conception (Date of conception)"
label var hist_doc "Expected temperature around conception (Date of conception)"
label var temp_doc_idw "Actual temperature around conception IDW (Date of conception)"
label var hist_doc_idw "Expected temperature around conception IDW (Date of conception)"
label var distance_nn "Distance to nearest weather station in km"
label var src_id_nn "ID of nearest weather station"
label var dev_doc "Temperature deviation around conception (Date of conception)"
label var dev_doc_idw "Temperature deviation around conception IDW (Date of conception)"

label var part_uk "Part of UK"
label var region "Region 2nd level administrative"

label var dev_2_idw "Temperature deviation around conception IDW (2 weeks before)
label var con_month "Month of conception"
rename con_month moc 

*** Merge additional data-fields ***

merge 1:1 n_eid using "Additional data-fields", keepusing(n_189_0_0 n_26410_0_0 n_26426_0_0 n_26427_0_0 n_670_0_0 n_670_1_0 n_670_2_0 n_670_3_0 n_6140_0_0 n_6140_0_1 n_6140_0_2 n_6140_1_0 n_6140_1_1 n_6140_1_2 n_6140_2_0 n_6140_2_1 n_6140_2_2 n_6140_2_3 n_6140_3_0 n_6140_3_1 n_699_0_0 n_699_1_0 n_699_2_0 n_699_3_0 n_767_0_0 n_767_1_0 n_767_2_0 n_767_3_0 n_3659_0_0 n_3659_1_0 n_3659_2_0 n_1717_0_0 n_1717_1_0 n_1717_2_0 n_1050_0_0 n_1050_1_0 n_1050_2_0 n_1050_3_0 n_1060_0_0 n_1060_1_0 n_1060_2_0 n_1060_3_0 n_1797_0_0 n_1797_1_0 n_1797_2_0 n_1797_3_0 n_1835_0_0 n_1835_1_0 n_1835_2_0 n_1835_3_0 n_6153_0_0 n_6153_0_1 n_6153_0_2 n_6153_0_3 n_6153_1_0 n_6153_1_1 n_6153_1_2 n_6153_1_3 n_6153_2_0 n_6153_2_1 n_6153_2_2 n_6153_2_3 n_6153_3_0 n_6153_3_1 n_6153_3_2 n_23099_0_0 n_23099_1_0 n_23099_2_0 n_23099_3_0 n_23278_2_0 n_23279_2_0 n_23100_0_0 n_23100_1_0 n_23100_2_0 n_23100_3_0 n_23101_0_0 n_23101_1_0 n_23101_2_0 n_23101_3_0 n_22432_2_0 n_22408_2_0 n_22408_3_0 n_22415_2_0 n_21085_2_0 n_21085_3_0 n_21086_2_0 n_21086_3_0 n_23281_2_0 n_23281_3_0 n_74_0_0 n_74_1_0 n_74_2_0 n_74_3_0 n_30500_0_0 n_30500_1_0 s_30503_0_0 s_30503_1_0 ts_30502_0_0 ts_30502_1_0 ts_22700_0_0 ts_22700_0_1 ts_22700_0_2 ts_22700_0_3 ts_22700_0_4 ts_22700_0_5 ts_22700_0_6 ts_22700_0_7 ts_22700_0_8 ts_22700_0_9 ts_22700_0_10 ts_22700_0_11 ts_22700_0_12 ts_22700_0_13 ts_22700_0_14 n_22607_0_0 n_22607_0_1 n_22607_0_2 n_22607_0_3 n_22607_0_4 n_22607_0_5 n_22607_0_6 n_22607_0_7 n_22607_0_8 n_22607_0_9 n_22607_0_10 n_22607_0_11 n_22607_0_12 n_22607_0_13 n_22607_0_14 n_22607_0_15 n_22607_0_16 n_22607_0_17 n_22607_0_18 n_22607_0_19 n_22607_0_20 n_22607_0_21 n_22607_0_22 n_22607_0_23 n_22607_0_24 n_22607_0_25 n_22607_0_26 n_22607_0_27 n_22607_0_28 n_22607_0_29 n_22607_0_30 n_22607_0_31 n_22607_0_32 n_22607_0_33 n_22607_0_34 n_22607_0_35 n_22607_0_36 n_22607_0_37 n_22607_0_38 n_22607_0_39 n_22608_0_0 n_22608_0_1 n_22608_0_2 n_22608_0_3 n_22608_0_4 n_22608_0_5 n_22608_0_6 n_22608_0_7 n_22608_0_8 n_22608_0_9 n_22608_0_10 n_22608_0_11 n_22608_0_12 n_22608_0_13 n_22608_0_14 n_22608_0_15 n_22608_0_16 n_22608_0_17 n_22608_0_18 n_22608_0_19 n_22608_0_20 n_22608_0_21 n_22608_0_22 n_22608_0_23 n_22608_0_24 n_22608_0_25 n_22608_0_26 n_22608_0_27 n_22608_0_28 n_22608_0_29 n_22608_0_30 n_22608_0_31 n_22608_0_32 n_22608_0_33 n_22608_0_34 n_22608_0_35 n_22608_0_36 n_22608_0_37 n_22608_0_38 n_22608_0_39)

drop if _merge == 1 | _merge == 2

drop _merge

