** Sample restriction **

drop if ncb == . | ecb == . 

drop if ncb == -1 | ecb == -1 // Place of birth coordinates are not available 

keep if adopted == 0 // Keep only non-adopted volunteers 