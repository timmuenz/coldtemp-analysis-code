***************************************************************************************************************
*        Temperatures around conception affect metabolic health in adulthood
*        Data: UK Biobank
*        Timo S. Münz, Fabienne Pradella, Nathalie J. Lambrecht, Sabine Gabrysch, Reyn van Ewijk
*
***************************************************************************************************************

*****************************************
*  Content
*****************************************

* 1. Construct UKB dataset 
* 2. Renaming & recoding variables
* 3. Merge derived temperature measures 
* 4. Sample restriction & encoding
* 5. Recoding 
* 6. Regression analysis 

*****************************************
*  1. Construct UKB dataset  
*****************************************

do "1_ukb.do"

*****************************************
*  2. Renaming & recoding variables
*****************************************

do "2_Housekeeping.do"

*****************************************
*  3. Merge derived temperature measures 
*****************************************

do "3_Merging.do"

*****************************************
*  4. Sample restriction & encoding  
*****************************************

do "4_Sample restriction.do"

*****************************************
*  5. Recoding 
*****************************************

do "5_Recoding.do"

save "Full dataset.dta", replace 


*****************************************
*  6. Regression analysis
*****************************************

do "6_Regressions.do"

