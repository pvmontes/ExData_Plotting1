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


#We convert the variables Sub_metering_1, Sub_metering_2 and Sub_metering_3 from factor to numeric:
subdatos2$Sub_metering_1 <- as.numeric(as.character(subdatos2$Sub_metering_1))
subdatos2$Sub_metering_2 <- as.numeric(as.character(subdatos2$Sub_metering_2))
subdatos2$Sub_metering_3 <- as.numeric(as.character(subdatos2$Sub_metering_3))

#We draw the plot.
png("plot3.png", width = 480, height = 480) #Open the device.
plot(subdatos2$Sub_metering_1 ~ subdatos2$datetime, type="l", xlab = " ", ylab = "Energy sub metering")  
lines(subdatos2$Sub_metering_2 ~ subdatos2$datetime, type = "l", col = "red")
lines(subdatos2$Sub_metering_3 ~ subdatos2$datetime, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off() #Close the device.