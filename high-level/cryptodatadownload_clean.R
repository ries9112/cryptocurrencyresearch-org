
binance_eth$Date.Time <- paste0(substr(binance_eth$Date,1,13),":00:00")

binance_eth$Date.Time <- as.POSIXct(binance_eth$Date.Time, tz='UTC')


for(i in 1:nrow(binance_eth)){
  
  if (substr(binance_eth[1][i,],15,17) == "PM"){
    binance_eth$Date.Time[i] <- binance_eth$Date.Time[i] + lubridate::hours(12)
  }

}

binance_eth <- select(binance_eth, -Volume.ETH) #depends on import

binance_eth$Symbol <- "ETH" #also depends on import




binance_eth <- binance_eth %>% arrange(Date.Time)

# get pkey
binance_eth$pkey <- paste0(binance_eth$Date, binance_eth$Symbol)
# distinct
binance_eth <- binance_eth %>% distinct(pkey, .keep_all = T)

# remove pkey
binance_eth <- binance_eth %>% select(-pkey)

# Adjust Date
binance_eth$Date <- substr(binance_eth$Date,1,10)

# Adjust Date
binance_eth$Date <- as.Date(binance_eth$Date)


# Remove data before September 1st 2017
binance_eth <- subset(binance_eth, Date > '2017-12-31 00:00:00')

# Remove 08/10 for eth
binance_eth <- subset(binance_eth, Date < '2020-08-10') 


# Make into tibble
binance_eth <- as_tibble(binance_eth)

# Rename columns (or don't if want to keep data prep step in the tutorial)
binance_eth <- binance_eth %>% rename(VolumeUSDT='Volume.USDT', DateTime='Date.Time')

# Here upload to pins
board_register("github", repo = "predictcrypto/pins", token='FILL TOKEN')

# PIN DATA
pin(binance_eth, board='github', name='cryptodatadownload_NEO_Binance')











# Tutorial steps
# convert date
binance_eth$Date <- anytime::anytime(binance_eth$Date, tz='UTC')

# AFTER FILLING GAPS USING TS

# lag data
binance_eth <- binance_eth %>%
  arrange(Date.Time) %>% 
  mutate(Lag.1Hour = dplyr::lag(Open, n = 1, default = NA))

# lag data
binance_eth <- binance_eth %>%
  arrange(Date.Time) %>% 
  mutate(Lag.6Hour = dplyr::lag(Open, n = 6, default = NA))

# lag data
binance_eth <- binance_eth %>%
  arrange(Date.Time) %>% 
  mutate(Lag.24Hour = dplyr::lag(Open, n = 24, default = NA))

# lag data
binance_eth <- binance_eth %>%
  arrange(Date.Time) %>% 
  mutate(Lag.7Day = dplyr::lag(Open, n = 168, default = NA))

# lag data
binance_eth <- binance_eth %>%
  arrange(Date.Time) %>% 
  mutate(Lag.30Day = dplyr::lag(Open, n = 720, default = NA))



# ^ IF USING IN THE FUTURE, ADJUST LAGS TO MATCH THE DATA AS PINNED
#Also some new steps:
binance_eth <- select(binance_eth, -DateTime, DateTime)


