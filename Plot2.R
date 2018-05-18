library(dplyr)
library(lubridate)

#We load the data indicating the specific separator of file.
datos2 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)



#Subsetting Date, (we only need 01/02/2007 to 02/02/2007). (My key is Spanish, and hence at first the format of dates is Spanish too)
subdatos2 <- subset(datos2, Date == "1/2/2007" | Date == "2/2/2007")


#We are going to join the Date and Time columns, (we use mutate from dplyr library).
subdatos2 <-  subdatos2 %>%
  mutate(datetime = paste(Date, Time, sep = " "))

#We convert the datetime variable to Date format.
subdatos2$datetime <- strptime(subdatos2$datetime, "%d/%m/%Y %H:%M:%S") #Result in POSIXlt format.

subdatos2$datetime <- ymd_hms(subdatos2$datetime) #Result in POSIXct format, (before we use an utility from lubridate library)

#We draw the plot, (in this case it appear the days of week in Spanish, like my keyboard).
png("plot2.png", width = 480, height = 480) #Open the device.
with(subdatos2,plot(datetime,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off() #Close the device.