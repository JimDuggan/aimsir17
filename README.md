### aimsir17
Irish Weather Data from Ireland's [Weather Observing Stations](https://www.met.ie/climate/weather-observing-stations) in 2017. It now includes energy generation data for 2017 in the tibble *eirgrid17*.

Hourly records from January-December based on the following weather observation stations:

- Athenry, Co. Galway
- Ballyhaise, Co. Cavan
- Belmullet, Co. Mayo
- Casement Aerodrome, Co. Dublin
- Claremorris, Co. Mayo
- Cork Airport, Co. Cork
- Dublin Airport, Co. Dublin
- Dunsany (Grange), Co. Meath
- Finner Camp, Co. Donegal
- Gurteen, Co. Tipperary
- Johnstown Castle, Co. Wexford
- Knock Airport, Co. Mayo
- Mace Head, Co. Galway
- Malin Head, Co. Donegal
- Markree Castle, Co. Sligo
- Moore Park, Co. Cork
- Mount Dillon, Co. Roscommon
- Mullingar, Co. Westmeath
- Newport Furnace, Co. Mayo
- Oak Park, Co. Carlow
- Phoenix Park, Co. Dublin
- Roches point SWS, Co. Cork
- Shannon Airport, Co. Clare
- Sherkin Island, Co. Cork
- Valentia Observatory, Co. Kerry

See also, [major weather events](https://www.met.ie/climate/major-weather-events), which in 2017 including [Storm Ophelia](https://en.wikipedia.org/wiki/Hurricane_Ophelia_(2017)) (October 9, 2017 – October 18, 2017)

### Examples
In order to maximise the usefulness of the observations, R's [tidyverse](https://www.tidyverse.org) tools such as **dplyr** and **ggplot2** can be used. Here are three examples showing their use.

- [Loading the weather data](
https://github.com/JimDuggan/aimsir17/tree/master/data-raw/Examples/01%20Loading%20Dataset)
- [Exploring a weather event: Storm Ophelia](
https://github.com/JimDuggan/aimsir17/tree/master/data-raw/Examples/02%20Storm%20Ophelia)
- [Summarising hourly rainfall into monthly values](
https://github.com/JimDuggan/aimsir17/tree/master/data-raw/Examples/03%20Rainfall%20Summary)
- [Exploring the eirgrid energy data](
https://github.com/JimDuggan/aimsir17/tree/master/data-raw/Examples/04%20Energy%20Data)

### Author Information

- Author: Jim Duggan
- Affiliations
  + [School of Computer Science, NUI Galway.](https://www.nuigalway.ie/engineering-informatics/information-technology/)
  + [Ryan Institute, NUI Galway.](http://www.nuigalway.ie/ryaninstitute/)
  + [Insight Centre for Data Analytics, NUI Galway.](https://www.insight-centre.org)

### Acknowledgement

- Copyright Met Éireann and EirGrid
- Source [www.met.ie](http://www.met.ie), http://www.eirgridgroup.com/how-the-grid-works/renewables/
- This data is published under a [Creative Commons Attribution 4.0 International (CC BY 4.0)]( https://creativecommons.org/licenses/by/4.0/)
- Met Éireann does not accept any liability whatsoever for any error or omission in the data, their availability, or for any loss or damage arising from their use.
- This material has been modified from the original, in terms of the following:
  + New columns added to the data for Year, Month, Day and Hour. 
  + Columns representing indicators removed.
  + The column date transformed to a `POSIXct` type
- For the energy data from EirGrid, please note that the data contained herein is indicative as it is based on raw 15-minute SCADA readings which have yet to be quality controlled. EirGrid as the Transmission System Operator (TSO) for Ireland and SONI as the TSO for Northern Ireland make no warranties or representations of any kind with respect of this document, including, without limitation, its quality, accuracy and completeness.
While every effort has been made in the compilation of this report to ensure that the information
herein is correct, the TSOs do not accept liability for any loss or damage arising from the use of this
document or any reliance on the information it contains. Use of this document and the information it
contains is at the user’s sole risk. In addition, the TSOs strongly recommend that any party wishing
to make a decision based on the content of this document should consult the TSOs in advance.
