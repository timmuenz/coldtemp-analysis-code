** Regression analysis **

use "Full dataset", clear 


********************************* Descriptive Statistics (depicted in Table 1) *********************************

estpost tabstat bmi wc haemo trigl cholest, statistics(mean sd n) 
esttab using descriptives_outcomes.csv, replace title(Table. Descriptive statistics - Metabolic outcomes) substitute("\fonttbl{\f0\fnil Times New Roman" "\fonttbl{\f0\fnil Calibri") cells("bmi(fmt(3)) wc(fmt(3)) haemo(fmt(3)) trigl(fmt(3)) cholest(fmt(3))")

estpost tabstat overweight highwc highhb hightrigl highcholest, statistics(mean sd n) 
esttab using descriptives_outcomes_binary.csv, replace title(Table. Descriptive statistics - Metabolic outcomes) substitute("\fonttbl{\f0\fnil Times New Roman" "\fonttbl{\f0\fnil Calibri") cells("overweight(fmt(3)) highwc(fmt(3)) highhb(fmt(3)) hightrigl(fmt(3)) highcholest(fmt(3))")

estpost tabstat age female, statistics(mean sd n) 
esttab using desc_agefemale.csv, replace title(Table. Descriptive statistics - Metabolic outcomes) substitute("\fonttbl{\f0\fnil Times New Roman" "\fonttbl{\f0\fnil Calibri") cells("age(fmt(3)) female(fmt(3))")


********************************* COEFFICIENT PLOTS *********************************

********************************* Inverse Distance Weighting (Main Results, depicted in Figure 3) *********************************


// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass female, fe i(rm) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export idw.png, as(png) replace


********************************* Inverse Distance Weighting (Main Results, Bonferroni-Holm correction, depicted in Table 2) *********************************

log using "Bonferroni-Holm", replace


* Define then number of outcomes

local num_outcomes = 5 

* Initialize a matrix to store p-values for each exposure separately


foreach exposure in dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
matrix pvals = J(1,`num_outcomes',.)

local i = 1


foreach outcome in bmi wc haemo trigl cholest {
	
	
xtreg `outcome' `exposure' yob year_ass female, fe i(rm) vce(cluster region)


     local pvalue = 2*normal(-abs(_b[`exposure'] / _se[`exposure']))
		
		matrix pvals[1,`i'] = `pvalue'
		
        local i = `i' + 1
		
		}
	

* List the p-values matrix

display "P-values for exposure `exposure'"

matrix list pvals


* Sort the p-values and store the sorted order

matrix pvals_sorted = J(1,`num_outcomes',.)

matrix order = J(1,`num_outcomes',.)

matrix pvals_orig = pvals 


forvalues j = 1/`num_outcomes' {
	
    local min_index = 1
	
    local min_val = pvals[1,1]
	
    forvalues k = 2/`num_outcomes' {
		
        if (pvals[1,`k'] < `min_val') {
			
            local min_val = pvals[1,`k']
			
            local min_index = `k'
        }
    }
	
    matrix pvals_sorted[1,`j'] = `min_val'
	
    matrix order[1,`j'] = `min_index'
	
    matrix pvals[1,`min_index'] = .
	
}


* List the sorted p-values matrix

display "Sorted p-values for exposure `exposure'"

matrix list pvals_sorted

matrix list order


* Apply Bonferroni-Holm correction

local m = `num_outcomes'

matrix adjusted_pvals = J(1,`num_outcomes',.)


forvalues j = 1/`num_outcomes' {
	
    local corrected_pval = pvals_sorted[1,`j'] * (`m' - `j' + 1)
	
    if (`corrected_pval' > 1) local corrected_pval = 1
	
    matrix adjusted_pvals[1,`j'] = `corrected_pval'
	
}


* List the adjusted p-values

display "Adjusted p-values for exposure `exposure'"

matrix list adjusted_pvals


* Reorder the adjusted p-values back to the original order

matrix final_pvals = J(1,`num_outcomes',.)

forvalues j = 1/`num_outcomes' {
	
    local orig_index = order[1,`j']
	
    matrix final_pvals[1,`orig_index'] = adjusted_pvals[1,`j']
	
}


* List the final adjusted p-values in the original order

display "Final adjusted p-values for exposure `exposure'"

matrix list final_pvals



}


********************************* Nearest Neighbor (depicted in Supplementary Figure 2) *********************************

// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc dev_2 dev_31 dev_42 dev_53 {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass female, fe i(rm) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc dev_2 dev_31 dev_42 dev_53 {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc = "DOC" ///
                   dev_2 = "-2 w ; DOC" ///	   
                   dev_31 = "-3 w ; +1 w" ///	   
                   dev_42 = "-4 w ; +2 w" ///	   
                   dev_53 = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export nn.png, as(png) replace


********************************* Binary outcomes (depicted in Supplementary Figure 3) *********************************


label var overweight "BMI >= 25 kg/m²"

label var highwc "WC >= 94 cm (Men), WC >= 80 cm (Women)"

label var highhb "Glycated Haemoglobin >= 39 mmol/mol"

label var hightrigl "Triglycerides >= 1.7 mmol/l"

label var highcholest "Total Cholesterol >= 5.2 mmol/l"


// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist overweight highwc highhb hightrigl highcholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': logit `y' `d' yob year_ass female i.rm, or vce(cluster region)
    }
}



local outcomes overweight highwc highhb hightrigl highcholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
		eform ///
        keep(`d') ///
        drop(yob year_ass female _cons *.rm) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(1) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export binary.png, as(png) replace


********************************* Restricted to women (depicted in Supplementary Figure 4) *********************************

// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass if female == 1, fe i(rm) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export female.png, as(png) replace


********************************* Restricted to men (Supplementary Figure 5) *********************************


// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass if female == 0, fe i(rm) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export male.png, as(png) replace


********************************* Winter Conception (depicted in Supplementary Figure 6) *********************************


// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass female if winter_con == 1, fe i(rm) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export wintercon.png, as(png) replace


********************************* Excluding teenage pregnancies (depicted in Supplementary Figure 7) *********************************

// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass female if mage_teen != 1, fe i(rm) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export teen.png, as(png) replace


********************************* Controlling for maternal smoking (depicted in Supplementary Figure 8) *********************************


// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass female maternal_smoking, fe i(rm) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female maternal_smoking _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export msmoke.png, as(png) replace


********************************* Balancing tests (depicted in Supplementary Figure 9) *********************************

replace number_brothers = . if number_brothers == -3 | number_brothers == -1

replace number_sisters = . if number_sisters == -3 | number_sisters == -1

gen numsib = number_brothers + number_sisters 


rename n_20022_0_0 birthweight 

label var birthweight "Birth Weight"

label var numsib "Number of Siblings"


// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist birthweight numsib {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': xtreg `y' `d' yob year_ass female, fe i(rm) vce(cluster region)
    }
}



local outcomes birthweight numsib 

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export balancing.png, as(png) replace


********************************* Month-Year FE (depicted in Supplementary Figure 10) *********************************

// Clear any previous estimates

estimates clear

// Loop over the deviation variables `d`

foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
	
    foreach y of varlist bmi wc haemo trigl cholest  {
		
        // Create a unique name for each estimation
		
        local estname `y'_`d'
		
        // Run the regression and store the estimates
		
        eststo `estname': reghdfe `y' `d' yob year_ass female, absorb(mob_yob r) vce(cluster region)
    }
}



local outcomes bmi wc haemo trigl cholest

local graphlist 


foreach y of varlist `outcomes' {
	
    local estlist
	
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
		
    local estlist `estlist' `y'_`d'
		
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        xline(0) ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)
		local graphlist `graphlist' `y'_coefplot
		
}


graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2) 

graph export mob_yob.png, as(png) replace


********************************* Conception October - December vs. January - March (depicted in Supplementary Figure 11) *********************************


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist bmi {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,10,11,12), fe i(rm) vce(cluster region)
    }
}

local outcomes bmi
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.10   // left limit
local xmax   0.10   // right limit
local step   0.02   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export bmi_octdec.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist bmi {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,1,2,3), fe i(rm) vce(cluster region)
    }
}

local outcomes bmi
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.10   // left limit
local xmax   0.10   // right limit
local step   0.02   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export bmi_janmar.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist wc {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,10,11,12), fe i(rm) vce(cluster region)
    }
}

local outcomes wc
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.25   // left limit
local xmax   0.25   // right limit
local step   0.05   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export wc_octdec.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist wc {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,1,2,3), fe i(rm) vce(cluster region)
    }
}

local outcomes wc
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.25   // left limit
local xmax   0.25   // right limit
local step   0.05   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export wc_janmar.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist haemo {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,10,11,12), fe i(rm) vce(cluster region)
    }
}

local outcomes haemo
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.08   // left limit
local xmax   0.08   // right limit
local step   0.02   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export haemo_octdec.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist haemo {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,1,2,3), fe i(rm) vce(cluster region)
    }
}

local outcomes haemo
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.08   // left limit
local xmax   0.08   // right limit
local step   0.02   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export haemo_janmar.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist trigl {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,10,11,12), fe i(rm) vce(cluster region)
    }
}

local outcomes trigl
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.02   // left limit
local xmax   0.02   // right limit
local step   0.005   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.3f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export trigl_octdec.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist trigl {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,1,2,3), fe i(rm) vce(cluster region)
    }
}

local outcomes trigl
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.02   // left limit
local xmax   0.02   // right limit
local step   0.005   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.3f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export trigl_janmar.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist cholest {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,10,11,12), fe i(rm) vce(cluster region)
    }
}

local outcomes cholest
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.04   // left limit
local xmax   0.04   // right limit
local step   0.01   // tick spacing

foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export cholest_octdec.png, as(png) replace


// Clear any previous estimates
estimates clear

// Loop over the deviation variables `d`
foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
	
    // Loop over the outcome variables `y`
    foreach y of varlist cholest {
		
        // Create a unique name for each estimation
        local estname `y'_`d'
		
        // Run the regression and store the estimates
        eststo `estname': xtreg `y' `d' yob year_ass female ///
            if inlist(moc,1,2,3), fe i(rm) vce(cluster region)
    }
}

local outcomes cholest
local graphlist

// --- Set manual x-axis scaling ---
local xmin  -0.04   // left limit
local xmax   0.04   // right limit
local step   0.01   // tick spacing
foreach y of varlist `outcomes' {
	
    local estlist
    foreach d of varlist dev_doc_idw dev_2_idw dev_31_idw dev_42_idw dev_53_idw {
        local estlist `estlist' `y'_`d'
    }
		 
	local displayname : variable label `y'
	 
    coefplot `estlist', ///
        keep(`d') ///
        drop(yob year_ass female _cons) ///
		coeflabels(dev_doc_idw = "DOC" ///
                   dev_2_idw  = "-2 w ; DOC" ///	   
                   dev_31_idw = "-3 w ; +1 w" ///	   
                   dev_42_idw = "-4 w ; +2 w" ///	   
                   dev_53_idw = "-5 w ; +3 w") ///   
        /// ---- manually control x-axis ----
        xline(0, lc(gs8)) ///
        xscale(range(`xmin' `xmax')) ///
        xlabel(`xmin'(`step')`xmax', format(%4.2f) angle(horizontal)) ///
        ///
		legend(off) ///
		scheme(s1mono) ///
		grid(none) ///
		msymbol(0) mcolor(blue) lcolor(blue) msize(medium) ciopts(bcolor(blue)) ///
		title("`displayname'", size(medsmall)) /// 
        name(`y'_coefplot, replace)

	local graphlist `graphlist' `y'_coefplot
}

graph combine `graphlist', ///
    saving(combined_graph.gph, replace) ///
    imargin(medium) ///
	scheme(s1mono) ///
    cols(2)

graph export cholest_janmar.png, as(png) replace


