fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('./Fhousehold power consumption.zip')){
  download.file(fileurl,'./Fhousehold power consumption.zip', mode = 'wb')
  unzip("Fhousehold power consumption.zip", exdir = getwd())
}
household.data<-read.csv('./household_power_consumption.txt', header = TRUE, sep = ";")
household.data$Date <- as.Date(household.data$Date, format= "%d/%m/%Y")
household.data <- subset(household.data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
household.data <- household.data[complete.cases(household.data),]
DateTime <- paste(household.data$Date, household.data$Time)
DateTime <- setNames(DateTime, "DateTime")
household.data <- household.data[ ,!(names(household.data) %in% c("Date","Time"))]
household.data <- cbind(DateTime, household.data)
household.data$DateTime <- as.POSIXct(DateTime)

##plot1
hist(household.data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

##plot2
plot(household.data$Global_active_power~t$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

##plot3
with(household.data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

##plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
