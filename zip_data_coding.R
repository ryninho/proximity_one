# this script codes some of the data from http://proximityone.com/zipdata.htm with human-readable names

path <- "?"  # wherever you put the uncoded file
# warning: takes over a minute to import with read.csv
z <- read.csv(path)
dim(z)
prettyNum(prod(dim(z)),big.mark = ",") # 25 million values

z$zip <- as.integer(z$zip)

table(sapply(z,class)) # only three factor variables- rest are integer or numeric

names(z)
head(z$st)
# factor variables are st (state), time_zone and time_zone_dst

table(z$time_zone,z$time_zone_dst) # daylight savings time only between MST and PST?
unique(
  z[z$time_zone != z$time_zone_dst,"st"]
) # looks like it's just Arizona (so can just use time_zone for convenience)

prettyNum(sum(z$D001),big.mark = ",") # total population: 306 million


# derive variables from zip dataset ----------------------------------------

z$total_pop <- z$D001  # % of total population
z$male <- z$D002 / z$D001  # % of total population
z$under_20 <- (z$D004 +  z$D005 + z$D006 + z$D007) / z$D001  # % of total population
z$over_65 <- (z$D014 + z$D015 + z$D016) / z$D001  # % of total population
z$age_median <- z$D017
z$units_per_person <- z$D081 / z$D001  # % of total population
z$units_per_household <- z$D081 / z$S001  # % of total households
z$married_w_children <- z$S005 / z$S001  # % of total households
z$single_mothers <- z$S009 / z$S001  # % of total households
z$nonfamily <- z$S010 / z$S001  # % of total households
z$household_size_avg <- z$S015
z$family_size_avg <- z$S016
z$recent_birth <- z$S036 / z$D001  # % of total population
z$grandparents_live_w_grandkids <- z$S043 / z$D001  # % of total population
z$grandparents_watch_grandkids <- z$S049 / z$D001  # % of total population
z$in_k_12 <- z$S056 / z$D001  # % of total population
z$in_college <- z$S057 / z$D001  # % of total population
z$droput_ms_hs <- (z$S059 + z$S060) / z$D001  # % of total population
z$pct_HS_or_higher <- z$S066 / 100
z$pct_BA_or_higher <- z$S067 / 100
z$veterans <- z$S069 / z$D001  # % of total population
z$small_recent_move <- z$S081 / z$D001  # % of total population
z$big_recent_move <- z$S084 / z$D001  # % of total population
z$abroad_last_year <- z$S085 / z$D001  # % of total population
z$born_usa <- z$S088 / z$D001  # % of total population
z$non_english_home <- z$S112 / z$D001  # % of total population
z$labor_force <- z$E002 / z$D001  # % of total population
z$unemployment <- z$E005 / z$E002  # % of of pop in labor force
z$military_job <- z$E006 / z$E002  # % of of pop in labor force
z$drive_alone <- z$E019 / z$E002  # % of of pop in labor force
z$carpool <- z$E020 / z$E002  # % of of pop in labor force
z$wfh <- z$E024 / z$E002  # % of of pop in labor force
z$commute <- z$E025 / 100
z$service_jobs <- z$E028 / z$E026  # % of civilian pop over 16
z$construction_etc_jobs <- z$E030 / z$E026  # % of civilian pop over 16
z$income_median <- z$E062
z$public_assistance <- z$E072 / z$S001  # % of total households
z$public_assistance_recently <- z$E074 / z$S001  # % of total households
z$income_per_capita <- z$E088
z$vacancy_rate <- z$H003 / z$H001  # % of total housing units
z$mobile_homes <- z$H014 / z$H001  # % of total housing units
z$new_homes <- z$H017 / z$H001  # % of total housing units
z$homes_built_preWWII <- z$H025 / z$H001  # % of total housing units
z$rooms_median <- z$H036
z$bedrooms_3_plus <- (z$H041 + z$H042 + z$H043) / z$H001  # % of total housing units
z$renter_occupied <- z$H046 / z$H001  # % of total housing units
z$moved_in_during_2000s <- (z$H050 + z$H051) / z$H049  # % of occupied housing units
z$vehicles_none <- z$H057 / z$H049  # % of occupied housing units
z$vehicles_2_plus <- z$H059 / z$H049  # % of occupied housing units
z$coal_tanks_wood <- (z$H063 + z$H066 + z$H067) / z$H049  # % of occupied housing units
z$incomplete_plumbing <- z$H072 / z$H049  # % of occupied housing units
z$incomplete_kitchen <- z$H073 / z$H049  # % of occupied housing units
z$no_telephone <- z$H074 / z$H049  # % of occupied housing units
z$value_median <- z$H088

# check
z[which(z$zip %in% c(94108,98107)),772:825]

write.csv(z,"Proximity_One_Zip_Data_Coded_v2.csv")



# suggested variable set from zip data (paste this into your R script to use these in modeling):
x_zip <- c(
  'total_pop',
  'male',
  'under_20',
  'over_65',
  'age_median',
  'units_per_person',
  'units_per_household',
  'married_w_children',
  'single_mothers',
  'nonfamily',
  'household_size_avg',
  'family_size_avg',
  'recent_birth',
  'grandparents_live_w_grandkids',
  'grandparents_watch_grandkids',
  'in_k_12',
  'in_college',
  'droput_ms_hs',
  'pct_HS_or_higher',
  'pct_BA_or_higher',
  'veterans',
  'small_recent_move',
  'big_recent_move',
  'abroad_last_year',
  'born_usa',
  'non_english_home',
  'labor_force',
  'unemployment',
  'military_job',
  'drive_alone',
  'carpool',
  'wfh',
  'commute',
  'service_jobs',
  'construction_etc_jobs',
  'income_median',
  'public_assistance',
  'public_assistance_recently',
  'income_per_capita',
  'vacancy_rate',
  'mobile_homes',
  'new_homes',
  'homes_built_preWWII',
  'rooms_median',
  'bedrooms_3_plus',
  'renter_occupied',
  'moved_in_during_2000s',
  'vehicles_none',
  'vehicles_2_plus',
  'coal_tanks_wood',
  'incomplete_plumbing',
  'incomplete_kitchen',
  'no_telephone',
  'value_median'  
)