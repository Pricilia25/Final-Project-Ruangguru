clear
set more off
global data "C:\Users\user\Documents\Semester 5\Ekonometrika Lanjutan\Praktikum\data"
global log "C:\Users\user\Documents\Semester 5\Ekonometrika Lanjutan\Praktikum\log"
global output "C:\Users\user\Documents\Semester 5\Ekonometrika Lanjutan\Praktikum\output"

log using "C:\Users\user\Documents\Semester 5\Ekonometrika Lanjutan\Praktikum\logfile\metlit", replace

use "$data\metlit3"
keep Seberaparutinandamenggunakan Gender ApakahandamengikutiOrganisasi Semester Apakahandamelakukanshalat5w Apakahandalangsungmelaksanaka ApakahandaseringmembacaAlQu Apakahandamengikutikegiatank Apakahandaberdoasetiaphari
ren ApakahandamengikutiOrganisasi Organisasi
ren Seberaparutinandamenggunakan AplikasiIslami
ren Apakahandamelakukanshalat5w Sholat
ren Apakahandalangsungmelaksanaka Adzan
ren ApakahandaseringmembacaAlQu Alquran
ren Apakahandamengikutikegiatank KegiatanAgama
ren Apakahandaberdoasetiaphari Berdoa

tab Gender
gen gender2=1 if Gender=="Perempuan"
replace gender2=0 if gender2==.
label define gender2 1 "1: Perempuan" 0 "0: Laki-Laki"
label values gender2 gender2
tab gender2
drop Gender
ren gender2 Gender
recode KegiatanAgama (1/2=0) (3/4=1)
label values KegiatanAgama KegiatanAgama
recode Berdoa (1/2=0) (3/4=1)
label values Berdoa Berdoa

probit Alquran Semester Organisasi Gender AplikasiIslami
mfx
outreg2 using metlit3.doc
margins, dydx(*) post
outreg2 using metlit3.doc, append

log close
