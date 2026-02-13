/* SAS program ukb.do created by ukb2sta.cpp Mar 14 2018 16:01:21 */
clear all
label define m_0009 1 "Male" 0 "Female"
label define m_0008 12 "December" 10 "October" 7 "July" 1 "January" 4 "April" 9 "September" 3 "March" 8 "August" 11 "November" 6 "June" 2 "February" 5 "May"
label define m_100258 1 "Yes - pounds and ounces" 2 "Yes - Kilograms" 9 "No"
label define m_0170 -1 "Location could not be mapped"
label define m_100291 -1 "Do not know" -3 "Prefer not to answer"
label define m_100294 1 "Less than 18,000" 2 "18,000 to 30,999" 3 "31,000 to 51,999" 4 "52,000 to 100,000" 5 "Greater than 100,000" -1 "Do not know" -3 "Prefer not to answer"
label define m_100290 -10 "Less than a year" -1 "Do not know" -3 "Prefer not to answer"
label define m_100301 1 "Never/rarely" 2 "Sometimes" 3 "Usually" 4 "Always" -1 "Do not know" -3 "Prefer not to answer"
label define m_100306 -2 "Never went to school" -1 "Do not know" -3 "Prefer not to answer"
label define m_100420 1 "England" 2 "Wales" 3 "Scotland" 4 "Northern Ireland" 5 "Republic of Ireland" 6 "Elsewhere" -1 "Do not know" -3 "Prefer not to answer"
label define m_100349 1 "Yes" 0 "No" -1 "Do not know" -3 "Prefer not to answer"
label define m_100511 1 "Yes, all of the time" 2 "Yes, most of the time" 3 "Yes, sometimes" 4 "No, never" -1 "Do not know" -3 "Prefer not to answer"
label define m_100305 1 "College or University degree" 2 "A levels/AS levels or equivalent" 3 "O levels/GCSEs or equivalent" 4 "CSEs or equivalent" 5 "NVQ or HND or HNC or equivalent" 6 "Other professional qualifications eg: nursing, teaching" -7 "None of the above" -3 "Prefer not to answer"
label define m_100292 1 "Husband, wife or partner" 2 "Son and/or daughter (include step-children)" 3 "Brother and/or sister" 4 "Mother and/or father" 5 "Grandparent" 6 "Grandchild" 7 "Other related" 8 "Other unrelated" -3 "Prefer not to answer"
label define m_100295 1 "In paid employment or self-employed" 2 "Retired" 3 "Looking after home and/or family" 4 "Unable to work because of sickness or disability" 5 "Unemployed" 6 "Doing unpaid or voluntary work" 7 "Full or part-time student" -7 "None of the above" -3 "Prefer not to answer"
label define m_100510 1 "Attendance allowance" 2 "Disability living allowance" 3 "Blue badge" -7 "None of the above" -1 "Do not know" -3 "Prefer not to answer"
label define m_100625 1 "Cholesterol lowering medication" 2 "Blood pressure medication" 3 "Insulin" -7 "None of the above" -1 "Do not know" -3 "Prefer not to answer"
label define m_0090 2 "Current" 1 "Previous" -3 "Prefer not to answer" 0 "Never"
label define m_1001 4001 "Caribbean" 3001 "Indian" 1 "White" 2001 "White and Black Caribbean" 1001 "British" 3002 "Pakistani" 2 "Mixed" 4002 "African" 1002 "Irish" 2002 "White and Black African" 3003 "Bangladeshi" 3 "Asian or Asian British" 4003 "Any other Black background" 1003 "Any other white background" 2003 "White and Asian" 3004 "Any other Asian background" 4 "Black or Black British" 2004 "Any other mixed background" 5 "Chinese" 6 "Other ethnic group" -1 "Do not know" -3 "Prefer not to answer"
label define m_0502 1 "Yes" 0 "No" -818 "Prefer not to answer" -121 "Do not know"

cd "D:\Timo\Cold Temperature\Full dataset\"
infile using "ukb49640.dct", using("ukb49640.raw")
label values n_31_0_0 m_0009
format %18.14f n_48_0_0
format %13.1f n_48_1_0
format %18.14f n_48_2_0
format %18.14f n_49_0_0
format %13.1f n_49_1_0
format %18.14f n_49_2_0
label values n_52_0_0 m_0008
gen double ts_53_0_0 = date(s_53_0_0,"DMY")
format ts_53_0_0 %td
drop s_53_0_0
label variable ts_53_0_0 "Date of attending assessment centre"
gen double ts_53_1_0 = date(s_53_1_0,"DMY")
format ts_53_1_0 %td
drop s_53_1_0
label variable ts_53_1_0 "Date of attending assessment centre"
gen double ts_53_2_0 = date(s_53_2_0,"DMY")
format ts_53_2_0 %td
drop s_53_2_0
label variable ts_53_2_0 "Date of attending assessment centre"
gen double ts_53_3_0 = date(s_53_3_0,"DMY")
format ts_53_3_0 %td
drop s_53_3_0
label variable ts_53_3_0 "Date of attending assessment centre"
label values n_55_0_0 m_0008
label values n_55_1_0 m_0008
label values n_55_2_0 m_0008
label values n_55_3_0 m_0008
label values n_120_0_0 m_100258
label values n_120_1_0 m_100258
label values n_120_2_0 m_100258
label values n_129_0_0 m_0170
label values n_129_1_0 m_0170
label values n_129_2_0 m_0170
label values n_130_0_0 m_0170
label values n_130_1_0 m_0170
label values n_130_2_0 m_0170
label values n_709_0_0 m_100291
label values n_709_1_0 m_100291
label values n_709_2_0 m_100291
label values n_709_3_0 m_100291
label values n_738_0_0 m_100294
label values n_738_1_0 m_100294
label values n_738_2_0 m_100294
label values n_738_3_0 m_100294
label values n_757_0_0 m_100290
label values n_757_1_0 m_100290
label values n_757_2_0 m_100290
label values n_757_3_0 m_100290
label values n_767_0_0 m_100291
label values n_767_1_0 m_100291
label values n_767_2_0 m_100291
label values n_767_3_0 m_100291
label values n_806_0_0 m_100301
label values n_806_1_0 m_100301
label values n_806_2_0 m_100301
label values n_806_3_0 m_100301
label values n_816_0_0 m_100301
label values n_816_1_0 m_100301
label values n_816_2_0 m_100301
label values n_816_3_0 m_100301
label values n_845_0_0 m_100306
label values n_845_1_0 m_100306
label values n_845_2_0 m_100306
label values n_1647_0_0 m_100420
label values n_1647_1_0 m_100420
label values n_1647_2_0 m_100420
label values n_1767_0_0 m_100349
label values n_1767_1_0 m_100349
label values n_1767_2_0 m_100349
label values n_1767_3_0 m_100349
label values n_1777_0_0 m_100349
label values n_1777_1_0 m_100349
label values n_1777_2_0 m_100349
label values n_1787_0_0 m_100349
label values n_1787_1_0 m_100349
label values n_1787_2_0 m_100349
label values n_1845_0_0 m_100291
label values n_1845_1_0 m_100291
label values n_1845_2_0 m_100291
label values n_1845_3_0 m_100291
label values n_1873_0_0 m_100291
label values n_1873_1_0 m_100291
label values n_1873_2_0 m_100291
label values n_1873_3_0 m_100291
label values n_1883_0_0 m_100291
label values n_1883_1_0 m_100291
label values n_1883_2_0 m_100291
label values n_1883_3_0 m_100291
label values n_2443_0_0 m_100349
label values n_2443_1_0 m_100349
label values n_2443_2_0 m_100349
label values n_2443_3_0 m_100349
label values n_2946_0_0 m_100291
label values n_2946_1_0 m_100291
label values n_2946_2_0 m_100291
label values n_2946_3_0 m_100291
label values n_4674_0_0 m_100511
label values n_4674_1_0 m_100511
label values n_4674_2_0 m_100511
label values n_4674_3_0 m_100511
label values n_5057_0_0 m_100291
label values n_5057_1_0 m_100291
label values n_5057_2_0 m_100291
label values n_5057_3_0 m_100291
label values n_6138_0_0 m_100305
label values n_6138_0_1 m_100305
label values n_6138_0_2 m_100305
label values n_6138_0_3 m_100305
label values n_6138_0_4 m_100305
label values n_6138_0_5 m_100305
label values n_6138_1_0 m_100305
label values n_6138_1_1 m_100305
label values n_6138_1_2 m_100305
label values n_6138_1_3 m_100305
label values n_6138_1_4 m_100305
label values n_6138_1_5 m_100305
label values n_6138_2_0 m_100305
label values n_6138_2_1 m_100305
label values n_6138_2_2 m_100305
label values n_6138_2_3 m_100305
label values n_6138_2_4 m_100305
label values n_6138_2_5 m_100305
label values n_6138_3_0 m_100305
label values n_6138_3_1 m_100305
label values n_6138_3_2 m_100305
label values n_6138_3_3 m_100305
label values n_6138_3_4 m_100305
label values n_6138_3_5 m_100305
label values n_6141_0_0 m_100292
label values n_6141_0_1 m_100292
label values n_6141_0_2 m_100292
label values n_6141_0_3 m_100292
label values n_6141_0_4 m_100292
label values n_6141_1_0 m_100292
label values n_6141_1_1 m_100292
label values n_6141_1_2 m_100292
label values n_6141_1_3 m_100292
label values n_6141_1_4 m_100292
label values n_6141_2_0 m_100292
label values n_6141_2_1 m_100292
label values n_6141_2_2 m_100292
label values n_6141_2_3 m_100292
label values n_6141_2_4 m_100292
label values n_6141_3_0 m_100292
label values n_6141_3_1 m_100292
label values n_6141_3_2 m_100292
label values n_6141_3_3 m_100292
label values n_6142_0_0 m_100295
label values n_6142_0_1 m_100295
label values n_6142_0_2 m_100295
label values n_6142_0_3 m_100295
label values n_6142_0_4 m_100295
label values n_6142_0_5 m_100295
label values n_6142_0_6 m_100295
label values n_6142_1_0 m_100295
label values n_6142_1_1 m_100295
label values n_6142_1_2 m_100295
label values n_6142_1_3 m_100295
label values n_6142_1_4 m_100295
label values n_6142_2_0 m_100295
label values n_6142_2_1 m_100295
label values n_6142_2_2 m_100295
label values n_6142_2_3 m_100295
label values n_6142_2_4 m_100295
label values n_6142_3_0 m_100295
label values n_6142_3_1 m_100295
label values n_6142_3_2 m_100295
label values n_6142_3_3 m_100295
label values n_6146_0_0 m_100510
label values n_6146_0_1 m_100510
label values n_6146_0_2 m_100510
label values n_6146_1_0 m_100510
label values n_6146_1_1 m_100510
label values n_6146_1_2 m_100510
label values n_6146_2_0 m_100510
label values n_6146_2_1 m_100510
label values n_6146_2_2 m_100510
label values n_6146_3_0 m_100510
label values n_6146_3_1 m_100510
label values n_6177_0_0 m_100625
label values n_6177_0_1 m_100625
label values n_6177_0_2 m_100625
label values n_6177_1_0 m_100625
label values n_6177_1_1 m_100625
label values n_6177_1_2 m_100625
label values n_6177_2_0 m_100625
label values n_6177_2_1 m_100625
label values n_6177_2_2 m_100625
label values n_6177_3_0 m_100625
label values n_6177_3_1 m_100625
label values n_6177_3_2 m_100625
format %18.15f n_20022_0_0
format %18.15f n_20022_1_0
format %18.15f n_20022_2_0
label values n_20116_0_0 m_0090
label values n_20116_1_0 m_0090
label values n_20116_2_0 m_0090
label values n_20116_3_0 m_0090
label values n_20117_0_0 m_0090
label values n_20117_1_0 m_0090
label values n_20117_2_0 m_0090
label values n_20117_3_0 m_0090
label values n_21000_0_0 m_1001
label values n_21000_1_0 m_1001
label values n_21000_2_0 m_1001
format %18.14f n_21001_0_0
format %18.14f n_21001_1_0
format %18.14f n_21001_2_0
format %18.14f n_21001_3_0
format %18.14f n_21002_0_0
format %18.14f n_21002_1_0
format %18.14f n_21002_2_0
format %18.14f n_21002_3_0
format %19.16f n_22407_2_0
label values n_22501_0_0 m_100306
format %13.2f n_22605_0_0
format %13.2f n_22605_0_1
format %13.2f n_22605_0_2
format %13.2f n_22605_0_3
format %13.2f n_22605_0_4
format %13.2f n_22605_0_5
format %13.2f n_22605_0_6
format %13.2f n_22605_0_7
format %13.2f n_22605_0_8
format %13.1f n_22605_0_9
format %13.2f n_22605_0_10
format %13.1f n_22605_0_11
format %13.2f n_22605_0_12
format %13.1f n_22605_0_13
format %13.1f n_22605_0_14
format %13.1f n_22605_0_15
format %13.1f n_22605_0_16
format %13.1f n_22605_0_17
format %13.1f n_22605_0_18
format %13.1f n_22605_0_23
format %18.14f n_23098_0_0
format %18.14f n_23098_1_0
format %18.14f n_23098_2_0
format %18.14f n_23098_3_0
format %20.17f n_23405_0_0
format %19.16f n_23405_1_0
format %19.16f n_23413_0_0
format %19.16f n_23413_1_0
format %19.16f n_23414_0_0
format %19.16f n_23414_1_0
format %18.15f n_23442_0_0
format %18.15f n_23442_1_0
format %20.17f n_23444_0_0
format %20.17f n_23444_1_0
format %18.15f n_23445_0_0
format %18.15f n_23445_1_0
format %18.15f n_23446_0_0
format %18.15f n_23446_1_0
format %18.15f n_23448_0_0
format %18.15f n_23448_1_0
format %19.16f n_23467_0_0
format %19.16f n_23467_1_0
format %18.14f n_23479_0_0
format %18.14f n_23479_1_0
format %18.14f n_30600_0_0
format %18.14f n_30600_1_0
format %19.16f n_30640_0_0
format %19.16f n_30640_1_0
format %18.15f n_30690_0_0
format %18.15f n_30690_1_0
format %19.16f n_30740_0_0
format %18.15f n_30740_1_0
format %18.14f n_30750_0_0
format %18.14f n_30750_1_0
format %19.16f n_30760_0_0
format %19.16f n_30760_1_0
format %19.16f n_30870_0_0
format %19.16f n_30870_1_0
label values n_120007_0_0 m_0502
