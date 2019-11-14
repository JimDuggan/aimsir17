library(readr)
library(lubridate)
library(dplyr)
library(devtools)

START_YEAR  <- 2018
FINISH_YEAR <- 2018

stations <- tibble(
  station = character(),
  county  = character(),
  height = numeric(),
  latitude = numeric(),
  longitude=numeric()
)

# Removing some vars to save on space...
prepare <- function(file,station,l_skip=17){
  f <- read_csv(file,skip=l_skip) %>%
       select(date,rain,temp,-wetb,-dewpt,-vappr,rhum,-msl,wdsp,wddir,-starts_with("ind")) %>%
       mutate(date=dmy_hm(date),
              year=year(date),
              month=month(date),
              day=day(date),
              hour=hour(date),
              station=station)    %>%
       select(station, year, month, day, hour, everything(), -date) %>%
       filter(year >= START_YEAR, year <= FINISH_YEAR)
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

# (4) Carlow Oak Park
oak_park <- prepare("data-raw/original data/carlow/hly375/hly375.csv","OAK PARK")
stations <- add_row(stations,station="OAK PARK",county="Carlow",height=62,latitude=52.861,longitude=-6.915)

# (*) Mace Head weather observing station
mace_head <- prepare("data-raw/original data/mace head/hly275.csv","MACE HEAD")
stations  <- add_row(stations,station="MACE HEAD",county="Galway",height=21,latitude=53.326,longitude=-9.901)


observations <- athenry               %>%
                bind_rows(ballyhaise) %>%
                bind_rows(belmullet)  %>%
                bind_rows(oak_park)   %>%
                bind_rows(mace_head)

use_data(observations,overwrite = T)

# Save Stations tibble
use_data(stations,overwrite = T)

