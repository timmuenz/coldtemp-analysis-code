** Recoding & creating additional variables **

* Generate date variables *

gen yoc_moc = monthly(moc, "YM") // String to date variable 

format yoc_moc %tm

label var yoc_moc "Year-month of conception"

drop moc 

gen dm = dofm(yoc_moc)

format dm %d 

gen yoc = year(dm)

gen moc = month(dm)

label var moc "Month of conception"

label var yoc "Year of conception"

gen yob_mob = ym(yob, mob)

format yob_mob %tm 

label var yob_mob "Year-month of birth"

drop dm 


* Generate binary outcomes *

gen overweight = . // Being overweight

replace overweight = 1 if bmi >= 25 & bmi < . 

replace overweight = 0 if bmi < 25 

label var overweight "BMI >= 25"


gen highwc = . // Having high risk waist circumference

replace highwc = 1 if wc >= 80 & female == 1 & wc < . 

replace highwc = 0 if wc < 80 & female == 1  

replace highwc = 1 if wc >= 94 & female == 0 & wc < . 

replace highwc = 0 if wc < 94 & female == 0  

label var highwc "WC >= 94 (Men), WC >= 80 (Women)"


gen hightrigl = . // Having high risk triglycerides levels 

replace hightrigl = 1 if trigl >= 1.7 & trigl < . 

replace hightrigl = 0 if trigl < 1.7

label var hightrigl "Triglycerides >= 1.7"


gen highcholest = . // Having high risk cholesterol levels 

replace highcholest = 1 if cholest >= 5.2 & cholest < . 

replace highcholest = 0 if cholest < 5.2

label var highcholest "Cholesterol >= 5.2"


gen highhb = . // Prediabetes indicator 

replace highhb = 1 if haemo >= 39 & haemo < . 

replace highhb = 0 if haemo < 39

label var highhb "Glyc. Haemoglobin >= 39"


* Variables for balancing tests * 

replace maternal_smoking = . if maternal_smoking == -1 

replace maternal_smoking = . if maternal_smoking == -3 


replace maternal_age= . if maternal_age == -1 

replace maternal_age = . if maternal_age == -3


gen mage_birth = maternal_age - age // Calculating mother's age at birth 

replace mage_birth = . if mage_birth == 0  // Error in data or typo 

label var mage_birth "Maternal age at birth"


gen mage_teen = .

replace mage_teen = 1 if mage_birth <= 19 

replace mage_teen = 0 if mage_birth > 19 & mage_birth < .

label var mage_teen "Maternal age <= 19 at birth"


* Additional variables *

gen winter_con = . // Conceived in winter (Oct- Mar)

replace winter_con = 1 if moc == 10 | moc == 11 | moc == 12 | moc == 1 | moc == 2 | moc == 3

replace winter_con = 0 if moc == 9 | moc == 8 | moc == 7 | moc == 6 | moc == 5 | moc == 4

label var winter_con "Conceived in winter time (Oct - Mar)"


gen winter_decfeb = . // Conceived in winter (Dec- Feb)

replace winter_decfeb = 1 if moc == 12 | moc == 1 | moc == 2 

replace winter_decfeb = 0 if moc >= 3 & moc <= 11

label var winter_decfeb "Conceived in winter time (Dec - Feb)"


* Region of birth *
 
encode region, gen(region2)

drop region

rename region2 region 

label var region "Region 2nd level administrative"


egen rm = group(region mob)

label var rm "Region - month of birth groups (2nd level administrative)"


* Year of attending assesment centre *

gen year_ass = year(ts_53_0_0)

label var year_ass "Year of attending assessment centre"


* Labelling metabolic outcomes *

label var bmi "Body Mass Index (BMI, kg/m²)"

label var wc "Waist Circumference (cm)"

label var haemo "Glycated Haemoglobin (HbA1c, mmol/mol)"

label var cholest "Total Cholesterol (mmol/l)"

label var trigl "Triglycerides (mmol/l)"


* Region and month-by-year of birth groups * 

egen r = group(region)

egen mob_yob = group(mob yob)












