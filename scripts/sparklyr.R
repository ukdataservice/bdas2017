## Load required packages.
library(dplyr)
library(sparklyr)
library(nycflights13)
library(ggplot2)
library(lubridate)

## Set config parameters for training laptops. 
config = spark_config()
config$spark.executor.cores = 4      # parallel::detectCores()
config$spark.executor.memory = "4G"  # approx. .5 * memory.size()
config$spark.driver.memory = "4G"

## Check sparklyr.
sc = spark_connect("local", config = config)
flights_sdf = copy_to(sc, flights, "flights", overwrite = TRUE)
flights_sdf %>%
  select(year, month, day, dep_delay, arr_delay) %>%
  filter(!is.na(arr_delay)) %>%
  mutate(gain = dep_delay - arr_delay) %>%
  filter(gain > 60) %>%
  collect() %>%
  mutate(date = make_date(year, month, day)) %>%         
  ggplot(aes(date, gain)) + 
    geom_point(alpha = 0.5, col = "darkseagreen", cex = 2)
