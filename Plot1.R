

#We load the data indicating the specific separator of file.
datos2 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Subsetting Date, (we only need 01/02/2007 to 02/02/2007). (My key is Spanish, and hence at first the format of dates is Spanish too ;-)
subdatos2 <- subset(datos2, Date == "1/2/2007" | Date == "2/2/2007")


#We transform the format of Global_active_power to numeric format, (to avoid lossing information first of all we have to convert to a character type).
subdatos2$Global_active_power <- as.numeric(as.character(subdatos2$Global_active_power))

#We draw the plot.
#At first we use the driver to using the graphic device.
png("plot1.png", width = 480, height = 480)
hist(subdatos2$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off() #Close the device.