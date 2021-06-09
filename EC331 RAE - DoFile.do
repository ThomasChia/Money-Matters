set maxvar 10000
// Change directory
use "/Volumes/G-DRIVE mobile USB-C/Year 3/EC331/Stata/Data/GSS Data/GSS Dataset RAE.dta"
// Start using a log file to record stata session
// Use command: log on using DoFile.log
// Pause/resume logging with "log on" and "log off"
// Close with "log close"

drop if year<=2000

// GENDER VARIABLE
sum sex
tab sex
codebook sex
gen female = sex
recode female 1=0 2=1


// AGE VARIABLE
sum age
*codebook age, tab(100)
drop if age==.n
gen agesq = age*age
* Use c.age#c.age instead

// EDUCATION VARIABLE
sum educ
*tab educ
*codebook educ, tab(100)
drop if educ==.d
drop if educ==.n
hist educ


// REGION VARIABLE
sum region
tab region
codebook region, tab(9)


// RACE VARIABLE
sum race
tab race
codebook race


*sum occyrs
*tab occyrs
*codebook occyrs, tab(100)
*drop if occyrs==.n
*hist occyrs
// No observations


*sum genderwk
*tab genderwk
*codebook genderwk
*gen majfemale = .
*replace majfemale=0 if genderwk>=5 & genderwk<=7
*replace majfemale=1 if genderwk>=1 & genderwk<=3
*tab majfemale
// No observations


// INDUSTRY VARIABLE
* sum isco08
* desc isco08
* tab isco08
* codebook isco08, tab(221)
* recode isco08 (1120 1211 1212 1219 1221 1222 1223 1321 1342 1345 1412 = 1 Management) (2141 2142 2149 2151 3100 3112 3123 4322 9329 = 2 Engineering) (2212 2221 2262 2264 2265 2266 2269 3210 3211 3221 3251 3255 5321 5322 = 3 Medicine) (2310 2330 2341 2342 2352 2358 2359 2635 4411 5311 = 4 Education) (2411 2412 2413 2421 3311 3312 3315 3321 3322 3323 3331 3334 3339 4214 4311 4312 4313 4321 = 5 Finance) (2423 2431 2432 3432 5222 5223 5249 = 6 Marketing) (2511 2512 2513 2514 2521 3512 4132 7421 = 7 Technology) (2611 = 8 Law) (2621 2622 = 9 History) (2631 2632 2634 3314 = 10 Academia) (2642 2651 2654 = 11 Media) (3341 3343 4110 4222 4223 4226 4416 4419 = 12 HR) (2131 3353 3411 4412 5100 5111 5120 5131 5141 5142 5412 5413 5414 5419 7515 8219 9111 9112 9321 9412 9421 = 13 Other), gen(industry08)
* tab industry08

sum indus10
desc indus10
* codebook indus10, tab(201)
recode indus10 (170 180 280 290 3870 3890 7480 570 580 670 690 2070 2680 6070 6080 6170 6180 6290 6370 6380 6390 = 1) (1470 1480 1570 1590 1670 1680 1890 2170 2190 2270 2280 2290 2370 2390 2470 2490 2570 2590 2670 2770 2870 2880 2980 3070 3080 3190 3470 3490 3580 3590 3670 3690 3970 3980 3990 8870 770 4870 = 2) (3570 4070 4080 4170 4180 4190 4260 4270 4380 4390 4470 4490 4560 4580 4585 4590 4670 4680 4690 4770 4790 5090 5170 5180 5190 5270 5370 5380 5390 5470 5480 5490 5570 5580 5592 5680 5690 5790 7080 8770 = 3) (1090 1170 1180 1190 1270 1280 1290 1370 4970 4980 4990 5590 5670 7670 8660 8680 8690 = 4) (6870 6880 6890 6970 6990 7270 7280 7070 = 5) (3370 3380 3390 6470 6480 6490 6570 6670 6680 6690 6695 6780 7470 8790 7290 7370 7380 7390 7460 7490 = 6) (7580 7590 7690 7770 7780 7680 7790 9370 9380 9390 9470 9480 9490 9570 9590 9670 9680 9770 9790 = 7) (6770 7860 7870 7880 7890 = 8) (5070 5080 7970 7980 7990 8080 8090 8170 8180 8190 8270 8290 8370 8380 8390 8470 8570 8580 8590 9170 9180 = 9) (1990 7190 8560 8880 8970 8980 8990 9070 9090 9160 9190 9290 = 0), gen(indus)
label def indus 1 "Agriculture, energy, transport & storage" 2 "Manufacturing & construction" 3 "Wholesale, retail & repair of motor vehicles" 4 "Accommodation & food services" 5 "Financial, insurance, & real estate activities" 6 "Professional, communication, scientific & technological activities" 7 "Administrative, support services & defence; social security" 8 "Education" 9 "Human health & social work activities" 0 "Other services"
label value indus indus
drop if indus==.n
* combined (agriculture with mining, energy & water supply), (manufacturing with construction), (financial & insurance with real estate), (information & communication with professional, scientific & technical) 
* Other services is the default
gen agri=.
replace agri=1 if indus==1
replace agri=0 if indus!=1
tab agri
gen mannu=.
replace manu=1 if indus==2
replace manu=0 if indus!=2
tab manu
gen wholesale=.
replace wholesale=1 if indus==3
replace wholesale=0 if indus!=3
tab wholesale
gen accom=.
replace accom=1 if indus==4
replace accom=0 if indus!=4
tab agri
gen fin=.
replace fin=1 if indus==5
replace fin=0 if indus!=5
tab fin
gen prof=.
replace prof=1 if indus==6
replace prof=0 if indus!=6
tab prof
gen admin=.
replace admin=1 if indus==7
replace admin=0 if indus!=7
tab admin
gen education=.
replace education=1 if indus==8
replace education=0 if indus!=8
tab education
gen social=.
replace social=1 if indus==9
replace social=0 if indus!=9
tab social
gen others=.
replace others=1 if indus==0
replace others=0 if indus!=0
tab others


// OCCUPATION VARIABLE
sum occ80
* codebook occ80, tab(100)
recode occ80 (13 15 16 19 37 = 1) (3 7 23 25 26 53 59 85 89 173 174 178 204 205 206 207 208 213 216 234 235 383 445 446 447 448 558 633 = 2) (5 8 27 36 303 305 307 313 326 327 329 335 336 337 338 339 343 377 378 379 = 3) (14 95 96 97 98 99 103 104 105 106 123 129 139 143 154 155 156 157 158 159 163 175 217 218 223 224 225 228 229 308 314 385 386 387 389 486 487 498 523 525 529 575 585 = 4) (17 43 55 56 64 65 67 73 78 84 166 167 169 176 183 184 185 188 189 194 195 199 203 417 418 423 424 425 426 431 687 804 808 809 825 = 5) (33 34 164 165 186 187 197 243 253 254 255 256 257 259 264 265 266 267 274 275 276 277 283 317 318 319 323 375 376 406 407 433 434 435 436 438 439 443 444 458 465 467 468 469 473 479 666 667 677 683 689 789 877 885 888 889 = 6) (29 344 347 354 355 356 359 363 364 365 368 373 415 449 453 637 706 719 733 738 739 744 747 748 749 753 754 759 769 774 777 779 785 796 799 859 869 = 0), gen(occupation)
label def occupation 1 "Managers and Senior Officials" 2 "Professional Occupations" 3 "Admin and Secretarial" 4 "Personal Services" 5 "Skilled Trades" 6 "Sales and Customer Services" 0 "Process, Plant, and Machine Operatives"
label value occupation occupation
drop if occupation==.i
* Process, Plant, and Machine Operatives is the default

// OCCUPATION VARIABLE
sum occ80
* codebook occ80, tab(100)
recode occ80 (13 15 16 19 37 803 = 1) (573 634 503 505 507 509 508 514 515 516 517 518 413 414 427 456 457 3 7 23 25 26 53 59 85 89 173 174 178 204 205 206 207 208 213 216 234 235 383 445 446 447 448 558 633 44 48 57 63 68 69 75 77 78 79 83 214 215 226 227 678 679 684 686 696 699 = 2) (5 8 9 27 36 303 305 307 313 326 327 329 335 336 337 338 339 343 377 378 379 = 3) (459 466 474 475 476 477 113 124 127 128 137 177 14 95 96 97 98 99 103 104 105 106 123 129 139 143 154 155 156 157 158 159 163 175 217 218 223 224 225 228 229 308 314 385 386 387 389 486 487 498 523 525 529 575 585 328 357 366 = 4) (709 714 717 723 727 734 735 737 757 766 495 496 263 268 269 278 35 17 43 55 56 64 65 67 73 78 84 166 167 169 176 183 184 185 188 189 194 195 199 203 417 418 423 424 425 426 431 687 804 808 809 825 534 536 539 543 544 547 549 555 557 563 565 567 576 577 579 593 595 596 597 598 599 616 643 647 653 657 668 783 787 = 5) (773 583 589 33 34 164 165 186 187 197 243 253 254 255 256 257 259 264 265 266 267 274 275 276 277 283 317 318 319 323 375 376 406 407 433 434 435 436 438 439 443 444 458 465 467 468 469 473 479 666 667 677 683 689 789 877 885 888 889 875 887 = 6) (883 29 344 347 354 355 356 359 363 364 365 368 373 415 449 453 637 706 719 733 738 739 744 747 748 749 753 754 759 769 774 777 779 785 796 799 859 869 28 805 806 823 829 844 848 853 856 865 = 0), gen(occupationm)
label def occupationm 1 "Managers and Senior Officials" 2 "Professional Occupations" 3 "Admin and Secretarial" 4 "Personal Services" 5 "Skilled Trades" 6 "Sales and Customer Services" 0 "Process, Plant, and Machine Operatives"
label value occupationm occupationm
drop if occupationm==.i

// HOURS WORKED VARIABLE
sum hrs1
*codebook hrs1, tab(100)
drop if hrs1==.i
drop if hrs1==.d
gen hrs1sq = hrs1*hrs1

// MAJOR VARIABLE
*sum majorcol
*tab majorcol
*codebook majorcol, tab (100)
*tab female if majorcol==.d
*tab female if majorcol==.i
*tab female if majorcol==.n
*drop if majorcol==.d
*drop if majorcol==.i
*drop if majorcol==.n


// INCOME VARIABLE
sum realrinc, detail
*codebook realrinc, tab(100)
*tab age if realrinc==.i
// Inapplicable answers do not seem correlated
drop if realrinc==.i
// 50 observations deleted
sum realrinc, detail
codebook realrinc, tab(100)
hist realrinc
gen lrealrinc = ln(realrinc)
sum lrealrinc, detail
hist lrealrinc
// Generate binary variable for above average (median) earnings
gen medianlearnings=.
replace medianlearnings=1 if lrealrinc>=10.08986
replace medianlearnings=0 if lrealrinc<10.08986
tab medianlearnings
// FEMALE EARNINGS
gen lrealrincf = lrealrinc if female==1
sum lrealrincf, detail
// Generate binary variable for above average female (median) earnings
gen medianflearnings=.
replace medianflearnings=1 if lrealrinc>=9.657187
replace medianflearnings=0 if lrealrinc<9.657187
tab medianflearnings

sum lrealrincf if indus==0, detail
gen medianflearningsother=.
replace medianflearningsother=1 if lrealrinc>=9.05991
replace medianflearningsother=0 if lrealrinc<9.05991
tab medianflearningsother

sum lrealrincf if indus==1, detail
gen medianflearningsagri=.
replace medianflearningsagri=1 if lrealrinc>=9.872176
replace medianflearningsagri=0 if lrealrinc<9.872176
tab medianflearningsagri

sum lrealrincf if indus==2, detail
gen medianflearningsmanu=.
replace medianflearningsmanu=1 if lrealrinc>=9.753057
replace medianflearningsmanu=0 if lrealrinc<9.753057
tab medianflearningsmanu

sum lrealrincf if indus==3, detail
gen medianflearningswholesale=.
replace medianflearningswholesale=1 if lrealrinc>=9.399358
replace medianflearningswholesale=0 if lrealrinc<9.399358
tab medianflearningswholesale

sum lrealrincf if indus==4, detail
gen medianflearningsaccom=.
replace medianflearningsaccom=1 if lrealrinc>=9.05991
replace medianflearningsaccom=0 if lrealrinc<9.05991
tab medianflearningsaccom

sum lrealrincf if indus==5, detail
gen medianflearningsfinance=.
replace medianflearningsfinance=1 if lrealrinc>=9.824242
replace medianflearningsfinance=0 if lrealrinc<9.824242
tab medianflearningsfinance

sum lrealrincf if indus==6, detail
gen medianflearningsprof=.
replace medianflearningsprof=1 if lrealrinc>=10.06321
replace medianflearningsprof=0 if lrealrinc<10.06321
tab medianflearningsprof

sum lrealrincf if indus==7, detail
gen medianflearningsadmin=.
replace medianflearningsadmin=1 if lrealrinc>=9.824242
replace medianflearningsadmin=0 if lrealrinc<9.824242
tab medianflearningsadmin

sum lrealrincf if indus==8, detail
gen medianflearningseduc=.
replace medianflearningseduc=1 if lrealrinc>=9.824242
replace medianflearningseduc=0 if lrealrinc<9.824242
tab medianflearningseduc

sum lrealrincf if indus==9, detail
gen medianflearningshealth=.
replace medianflearningshealth=1 if lrealrinc>=9.657187
replace medianflearningshealth=0 if lrealrinc<9.657187
tab medianflearningshealth


// PERFORMANCE PAY VARIABLE
sum extrapay
tab extrapay
*codebook extrapay, tab(100)
*tab age if extrapay==.i
// Inapplicable answers do not seem correlated
tab age if extrapay==.d
// Do not answers do not seem correlated
tab age if extrapay==.n
// No answers do not seem correlated
drop if extrapay==.i
drop if extrapay==.d
drop if extrapay==.n
// Recode to binary variable
recode extrapay 2=0
tab extrapay
*codebook extrapay, tab(100)
label define extrapay1 0 "no" 1 "yes"
label value extrapay extrapay1
tab extrapay

gen perfpay=.
replace perfpay = 1 if extrapay==1 & female==1
*replace perfpay = 1 if extrapay==1 & female==1 & indperf==1
replace perfpay = 0 if extrapay==0 & female==1
drop if perfpay==.
label define perfpay1 0 "no" 1 "yes"
label value perfpay perfpay1
tab perfpay

// codebook conrinc, tab(100)
// sum conrinc, detail
// hist conrinc
// gen lconrinc = ln(conrinc)
// sum lconrinc, detail
// hist lconrinc

// DESCRIPTIVE STATISTICS

tab female perfpay
**Not sure as shows women only, how useful and descriptive is it really?
tab medianflearnings perfpay


// REGRESSION ANALYSIS


pwcorr medianflearnings perfpay educ region race indus occupation age agesq majorcol hrs1 hrs1sq

reg medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq
estimates store LPM
predict yhat1
predict resid1, residuals
twoway scatter yhat1 resid1

logit medianflearnings i.perfpay educ region race indus occupation age agesq majorcol hrs1 hrs1sq
logit medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq

logit medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq, cluster(occupation)
* Not totally sure what the clustering thing does
logit medianflearnings i.perfpay educ i.region i.race i.indus i.occupation age agesq hrs1 hrs1sq, vce(robust)
logit medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq, vce(robust)
*logit medianflearnings i.perfpay educ occupation age agesq hrs1 hrs1sq, vce(robust)
*logistic
estimates store Logit

predict yhat
predict resid, residuals
twoway (scatter resid yhat, yline(0))
gen index=_n
scatter resid index, yline(0)
scatter resid index, yline(0) mlabel(id)
estat classification
* This gives a plot of the residuals and the prediction table

lfit
findit collin
collin perfpay educ region race indus occupation age agesq hrs1 hrs1sq
* VIF and Tolerance should be around 1 if there is no multicollinearity

linktest
* This tests a models specification, _hat should be sig, while _hatsq should not be. If this is the case then the model is correctly specified

margins, dydx(*) atmeans
marginsplot
margins perfpay, atmeans
display .6091682 - .4490042
* This gives marginal effects

test 1.perfpay


probit medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq
estimates store Probit

ssc inst estout
esttab LPM Probit Logit, b(%5.3f) se(%5.3f) mtitles
* This produces a table of comparison between the LPM, Logit, and Probit models



// REGRESSIONS BY INDUSTRY

* Agriculture, energy, transport & storage - Not significant, n=70
logit medianflearningsagri i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==1, vce(robust)
test 1.perfpay
scalar define agri = r(p)
* Manufacturing & construction - Significant, n=87
logit medianflearningsmanu i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==2, vce(robust)
test 1.perfpay
scalar define manu = r(p)
* Wholesale, retail & repair of motor vehicles - Not significant, n=163
logit medianflearningswholesale i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==3, vce(robust)
test 1.perfpay
scalar define whole = r(p)
* Accommodation & food services - Significant, n=133
logit medianflearningsaccom i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==4, vce(robust)
test 1.perfpay
scalar define accom = r(p)
* Financial, insurance, & real estate activities - Not significant, n=142
logit medianflearningsfin i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==5, vce(robust)
test 1.perfpay
scalar define fin = r(p)
* Professional, communication, scientific & technological activities - Significant, n=102
logit medianflearningsprof i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==6, vce(robust)
test 1.perfpay
scalar define prof = r(p)
* Administrative, support service & defence; social security - Not significant, n=120
logit medianflearningsadmin i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==7, vce(robust)
test 1.perfpay
scalar define admin = r(p)
* Education - Not significant, n=202
logit medianflearningseduc i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==8, vce(robust)
test 1.perfpay
scalar define educ = r(p)
* Human health & social work activities - Significant, n=345
logit medianflearningshealth i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==9, vce(robust)
test 1.perfpay
scalar define health = r(p)
* Other services - Not significant, n=81
logit medianflearningsother i.perfpay educ region race occupation age agesq hrs1 hrs1sq if indus==0, vce(robust)
test 1.perfpay
scalar define other = r(p)

scalar list

logit agri i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10 
logit manu i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10 
logit wholesale i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10 
logit accom i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10 
logit fin i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10 
logit prof i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10
logit admin i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10
logit education i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10
logit social i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10
logit others i.perfpay educ hrs1 hrs1sq marital childs paind10 maind10

quietly logit medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq childs, vce(robust)
margins, dydx(*) atmeans
quietly logit medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq marital, vce(robust)
margins, dydx(*) atmeans
quietly logit medianflearnings i.perfpay educ region race indus occupation age agesq hrs1 hrs1sq satjob, vce(robust)
margins, dydx(*) atmeans
