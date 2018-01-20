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

##plot2
plot(household.data$Global_active_power~t$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
