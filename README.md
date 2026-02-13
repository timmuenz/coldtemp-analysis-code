# Temperatures around conception affect metabolic health in adulthood
This repository contains the Stata (version 18) code used for the statistical analyses in the manuscript "Temperatures around conception affect metabolic health in adulthood" (Münz et al., Communications Medicine). The study links UK Biobank data with derived ambient temperature exposure measures around the estimated date of conception. 

The analysis workflow is executed via "0_Master do-file", which sequentially runs: (1) construction of the UK Biobank dataset (1_ukb.do), (2) renaming and cleaning of variables (2_Housekeeping.do), (3) merging of derived temperature measures (3_Merging.do), (4) sample restriction and encoding (4_Sample restriction.do), (5) final recoding (5_Recoding.do, which saves "Full dataset.dta"), and (6) regression anaslyses (6_Regressions.do). 

The study uses UK Biobank data (access required); individual-level data cannot be shared due to data access restrictions. 

*Corresponding Author
Name: Reyn van Ewijk
Address: Jakob-Welder-Weg 4, 55128 Mainz, Germany
Phone number: +49 (0) 6131 / 39 - 24790
Email: vanewijk@uni-mainz.de 
