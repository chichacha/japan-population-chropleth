## Japan Train Data from Ekidata
## http://www.ekidata.jp/  using API http://www.ekidata.jp/api/

library(tidyverse)
library(xml2)


### Functions 
get.trains <- function(p_num) {
  tmp <- read_xml(paste0("http://ekidata.jp/api/p/",p_num,".xml"))
  tmp.df <- tibble(
    p.num = tmp %>% xml_find_all("pref") %>% xml_find_all("code") %>% xml_text(),
    p.name = tmp %>% xml_find_all("pref") %>% xml_find_all("name") %>% xml_text(),
    line.cd = tmp %>% xml_find_all("line") %>% xml_find_all("line_cd") %>% xml_text(),
    line.name = tmp %>% xml_find_all("line") %>% xml_find_all("line_name") %>% xml_text()
  )
  tmp.df
}

get.coord <- function(line.url) {
  tmp <- read_xml(line.url)
  tmp.df <- tibble(
    station = tmp %>% xml_find_all("station") %>% xml_find_all("station_name") %>% xml_text(),
    station.cd = tmp %>% xml_find_all("station") %>% xml_find_all("station_cd") %>% xml_text(),
    lat = tmp %>% xml_find_all("station") %>% xml_find_all("lat") %>% xml_text() %>% as.numeric,
    lon = tmp %>% xml_find_all("station") %>% xml_find_all("lon") %>% xml_text() %>% as.numeric
  )
  tmp.df
}

get.prefs <- function(station.url) {
  tmp <- read_xml(station.url) %>% xml_find_all("station") %>% xml_find_all("pref_cd") %>% xml_text()
}

train.lines <- tibble(
  p_num = c(1:47),
  train.dtl = map(p_num, get.trains)
)

train.lines <- train.lines %>% unnest()
train.lines <- train.lines %>% mutate(line.url = paste0("http://www.ekidata.jp/api/l/",line.cd,".xml"))

## Because some train lines go through different prefectures.  
train.lines.min <- train.lines %>% group_by(line.name, line.cd, line.url) %>% summarise(p_count = n())

train.lines.dtl <- train.lines.min %>% mutate(line.detail = map(line.url,get.coord))

train.lines.df <- train.lines.dtl %>% unnest()

## I can get station details. such as pref_cd
train.lines.df <-train.lines.df %>% group_by(line.name, line.cd) %>% 
  mutate(station.cnt=n(), station.n = row_number(), 
         station.url=paste0("http://www.ekidata.jp/api/s/",station.cd,".xml"))

train.lines.df <- train.lines.df %>% mutate(prefs_cd = map_chr(station.url, get.prefs))

## Above takes very wrong time, so save it
write_rds(train.lines.df, "JapanStationData.rds")