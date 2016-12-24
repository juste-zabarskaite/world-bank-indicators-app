destfile_processed = "WDI_Data_Processed.csv"

if(file.exists(destfile_processed)) { 
  
  ## read processed csv file
  data <- read.csv(destfile_processed, check.names=FALSE)
  
} else {  
  
  ## download original csv file
  csvfile = "WDI_Data.csv"
  if(!file.exists(csvfile)) { 
    temp <- tempfile()
    download.file("http://databank.worldbank.org/data/download/WDI_csv.zip",temp)
    unzip(temp, file=csvfile)
    unlink(temp)
  } 
  
  ## read csv file
  library(data.table)
  data_orig <- fread(csvfile, header = TRUE, sep = ",")
  
  ## add continent
  library(countrycode)
  df <- data_orig
  names(df)[names(df)=="Indicator Name"] <- "Indicator"
  names(df)[names(df)=="Country Name"] <- "Country"
  df$Region <- countrycode(df$`Country Code`,"iso3c", "continent")
  
  ## remove columns
  df <-df[,c("Country","Region", "Indicator","2016","2015","2014")]
  
  ## reshape data
  library(reshape2)
  df1 <- df
  df1 <- melt(df1) 
  df2 <- dcast(df1, Country+Region+variable ~ Indicator, value.var="value")
  names(df2)[names(df2)=="variable"] <- "Year"
  
  ## remove predictors with missing values
  df3 <- df2
  df3 <- df3[ which(df3$Year=="2015"), ]
  df3 <- df3[colSums(is.na(df3)) < 0.25*nrow(df3)]
  
  ## save processed csv file
  data <- df2[,names(df3)]
  write.csv(data, file = destfile_processed)
} 

indicators <- names(data)
indicators <- indicators[!indicators %in% c("Country","Region","Year")]
years <- unique(data$Year)