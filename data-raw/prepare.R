library(readr)
library(lubridate)
library(dplyr)
library(devtools)

START_YEAR  <- 2017
FINISH_YEAR <- 2017

stations <- tibble(
  station = character(),
  county  = character(),
  height = numeric(),
  latitude = numeric(),
  longitude=numeric()
)

# Removing some vars to save on space...
prepare <- function(file,station,l_skip=17){
  f <- read_csv(file,skip=l_skip)
  # add a column for wind speed if it is missing
  if(!("wdsp" %in% names(f))){
    f <- mutate (f,wdsp=NA)
  }

  if(!("wddir" %in% names(f))){
    f <- mutate (f,wddir=NA)
  }

  f %>% select(date,rain,temp,-wetb,-dewpt,-vappr,rhum,msl,wdsp,wddir,-starts_with("ind")) %>%
        mutate(date=dmy_hm(date),
              year=year(date),
              month=month(date),
              day=day(date),
              hour=hour(date),
              station=station)    %>%
       select(station, year, month, day, hour, everything()) %>%
       filter(year >= START_YEAR, year <= FINISH_YEAR)
}

eirgrid <- function(){
  d <- read_csv("data-raw/EirGrid/System-Data-Qtr-Hourly-2017.csv") %>%
               select(-`GMT Offset`) %>%
               rename(date=DateTime,
                      NIGeneration=`NI Generation`,
                      NIDemand=`NI Demand`,
                      NIWindAvailability=`NI Wind Availability`,
                      NIWindGeneration=`NI Wind Generation`,
                      IEGeneration=`IE Generation`,
                      IEDemand=`IE Demand`,
                      IEWindAvailability=`IE Wind Availability`,
                      IEWindGeneration=`IE Wind Generation`
                      ) %>%
               mutate(date=dmy_hm(date),
                      year=year(date),
                      month=month(date),
                      day=day(date),
                      hour=hour(date),
                      minute=minute(date)) %>%
                      select(year, month, day, hour, minute, everything())

  d

}

# (1) Athenry weather observing station
athenry   <- prepare("data-raw/original data/athenry/hly1875/hly1875.csv","ATHENRY")
stations  <- add_row(stations,station="ATHENRY",county="Galway",height=40,latitude=53.289,longitude=-8.786)

# (2) Ballyhaise weather observing station
ballyhaise <- prepare("data-raw/original data/ballyhaise/hly675/hly675.csv","BALLYHAISE")
stations   <- add_row(stations,station="BALLYHAISE",county="Cavan",height=78,latitude=54.051,longitude=-7.310)

# (3) Belmullet weather observing station
belmullet <- prepare("data-raw/original data/belmullet/hly2375/hly2375.csv","BELMULLET",l_skip=22)
stations   <- add_row(stations,station="BELMULLET",county="Mayo",height=9,latitude=54.228,longitude=-10.007)

# (4) Casement
casement <- prepare("data-raw/original data/casement aerodrome/hly3723/hly3723.csv","CASEMENT",l_skip = 23)
stations <- add_row(stations,station="CASEMENT",county="Dublin",height=91,latitude=53.306,longitude=-6.439)


# (5) Claremorris
claremorris <- prepare("data-raw/original data/claremorris/hly2175/hly2175.csv","CLAREMORRIS")
stations <- add_row(stations,station="CLAREMORRIS",county="Mayo",height=68,latitude=53.711,longitude=-8.993)

# (6) Cork Airport
cork <- prepare("data-raw/original data/cork airport/hly3904/hly3904.csv","CORK AIRPORT",l_skip = 23)
stations <- add_row(stations,station="CORK AIRPORT",county="Cork",height=155,latitude=51.847 ,longitude=-8.486)

# (7) Dublin Airport
dublin <- prepare("data-raw/original data/dublin airport/hly532/hly532.csv","DUBLIN AIRPORT",l_skip = 23)
stations <- add_row(stations,station="DUBLIN AIRPORT",county="Dublin",height=71,latitude=53.428 ,longitude=-6.241)

# (8) Dunsany
dunsany <- prepare("data-raw/original data/dunsany/hly1375/hly1375.csv","DUNSANY")
stations <- add_row(stations,station="DUNSANY",county="Meath",height=83,latitude=53.516,longitude=-6.660)

# (9) Finner
finner <- prepare("data-raw/original data/finner/hly2075/hly2075 fix2.csv","FINNER",l_skip=0)
stations <- add_row(stations,station="FINNER",county="Donegal",height=33,latitude=54.494,longitude=-8.243)

# (10) Gurteen
gurteen <- prepare("data-raw/original data/gurteen/hly1475/hly1475.csv","GURTEEN")
stations <- add_row(stations,station="GURTEEN",county="Tipperary",height=75,latitude=53.053,longitude=-8.009)

# (11) Johnstown Castle
j_castle <- prepare("data-raw/original data/johnstown castle/hly1775/hly1775.csv","JOHNSTOWNII")
stations <- add_row(stations,station="JOHNSTOWNII",county="Wexford",height=62,latitude=52.298,longitude=-6.497)

# (12) Knock
knock <- prepare("data-raw/original data/knock airport/hly4935/hly4935.csv","KNOCK AIRPORT",l_skip = 23)
stations <- add_row(stations,station="KNOCK AIRPORT",county="Mayo",height=201,latitude=53.906,longitude=-8.817)

# (13) Mace Head weather observing station
mace_head <- prepare("data-raw/original data/mace head/hly275.csv","MACE HEAD")
stations  <- add_row(stations,station="MACE HEAD",county="Galway",height=21,latitude=53.326,longitude=-9.901)


# (14) Malin Head weather observing station
malin_head <- prepare("data-raw/original data/malin head/hly1575/hly1575.csv","MALIN HEAD",l_skip=23)
stations  <- add_row(stations,station="MALIN HEAD",county="Donegal",height=20,latitude=55.372,longitude=-7.339)

# (15) Markree weather observing station
markree <- prepare("data-raw/original data/markree/hly1275/hly1275.csv","MARKREE",l_skip = 15)
stations  <- add_row(stations,station="MARKREE",county="Sligo",height=34,latitude=54.175,longitude=-8.456)

# (16) Moore Park (Fermoy)
moore_park <- prepare("data-raw/original data/fermoy/hly575/hly575.csv","MOORE PARK")
stations <- add_row(stations,station="MOORE PARK",county="Cork",height=46,latitude=52.164,longitude=-8.264)

# (17) Mount Dillon
mt_dillon <- prepare("data-raw/original data/mount dillon/hly1975/hly1975.csv","MT DILLON")
stations  <- add_row(stations,station="MT DILLON",county="Roscommon",height=39,latitude=53.727 ,longitude=-7.981)

# (18)  Mullingar
mullingar <- prepare("data-raw/original data/mullingar/hly875/hly875.csv","MULLINGAR")
stations  <- add_row(stations,station="MULLINGAR",county="Westmeath",height=101,latitude=53.537 ,longitude=-7.362)

# (19)  Newport
newport <- prepare("data-raw/original data/newport/hly1175/hly1175.csv","NEWPORT")
stations  <- add_row(stations,station="NEWPORT",county="Mayo",height=22,latitude=53.922 ,longitude=-9.572)

# (20) Oak Park
oak_park <- prepare("data-raw/original data/carlow/hly375/hly375.csv","OAK PARK")
stations <- add_row(stations,station="OAK PARK",county="Carlow",height=62,latitude=52.861,longitude=-6.915)

# (21) Pheonix Park
pheonix_park <- prepare("data-raw/original data/pheonix park/hly175/hly175.csv","PHOENIX PARK",l_skip = 15)
stations <- add_row(stations,station="PHOENIX PARK",county="Dublin",height=48,latitude=53.364,longitude=-6.350)

# (22) Roches Point
roches_point <- prepare("data-raw/original data/roches point/hly1075/hly1075.csv","ROCHES POINT")
stations <- add_row(stations,station="ROCHES POINT",county="Cork",height=40,latitude=51.793,longitude=-8.244)

# (23) Shannon Airport
shannon <- prepare("data-raw/original data/shannon airport/hly518/hly518.csv","SHANNON AIRPORT",l_skip = 23)
stations <- add_row(stations,station="SHANNON AIRPORT",county="Clare",height=15,latitude=52.690,longitude=-8.918)

# (24) Sherkin Island
sherkin <- prepare("data-raw/original data/sherkin island/hly775/hly775.csv","SherkinIsland")
stations <- add_row(stations,station="SherkinIsland",county="Cork",height=21,latitude=51.476,longitude=-9.428)

# (25) Valentia
valentia<- prepare("data-raw/original data/valentia/hly2275/hly2275.csv","VALENTIA OBSERVATORY",l_skip = 23)
stations <- add_row(stations,station="VALENTIA OBSERVATORY",county="Kerry",height=24,latitude=51.938,longitude=-10.241)


observations <- athenry                  %>%       # (01)
                bind_rows(ballyhaise)    %>%       # (02)
                bind_rows(belmullet)     %>%       # (03)
                bind_rows(casement)      %>%       # (04)
                bind_rows(claremorris)   %>%       # (05)
                bind_rows(cork)          %>%       # (06)
                bind_rows(dublin)        %>%       # (07)
                bind_rows(dunsany)       %>%       # (08)
                bind_rows(finner)        %>%       # (09)
                bind_rows(gurteen)       %>%       # (10)
                bind_rows(j_castle)      %>%       # (11)
                bind_rows(knock)         %>%       # (12)
                bind_rows(mace_head)     %>%       # (13)
                bind_rows(malin_head)    %>%       # (14)
                bind_rows(markree)       %>%       # (15)
                bind_rows(moore_park)    %>%       # (16)
                bind_rows(mt_dillon)     %>%       # (17)
                bind_rows(mullingar)     %>%       # (18)
                bind_rows(newport)       %>%       # (19)
                bind_rows(oak_park)      %>%       # (20)
                bind_rows(pheonix_park)  %>%       # (21)
                bind_rows(roches_point)  %>%       # (22)
                bind_rows(shannon)       %>%       # (23)
                bind_rows(sherkin)       %>%       # (24)
                bind_rows(valentia)                # (25)

use_data(observations,overwrite = T)

# Save Stations tibble
use_data(stations,overwrite = T)

# Check rainfall records
check_year <- observations %>%
            group_by(station) %>%
            summarise(Records =n(),
                      MissingRecords=sum(is.na(rain)),
                      TotalRain=sum(rain,na.rm=T)) %>%
            arrange(station)


check_month <- observations %>%
  group_by(month,station) %>%
  summarise(Records =n(),
            MissingRecords=sum(is.na(rain)),
            TotalRain=sum(rain,na.rm=T)) %>%
  arrange(station)

check_data <- select(check_month,station,month,TotalRain)

check_wide <- pivot_wider(check_data,names_from = month,values_from = TotalRain)

# To test values, see https://www.met.ie/climate/available-data/monthly-data

# August 2020, Adding Eirgrid data

eirgrid17 <- eirgrid()

use_data(eirgrid17,overwrite = T)



