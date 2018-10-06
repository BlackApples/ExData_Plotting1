# Load libraries
library(lubridate)

# Download and unzip the data
if (!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

# Load the data and remove all but 2007-02-01 and 2007-02-02
data=read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")
data$Date=dmy(data$Date)
startdate = ymd("2007-02-01")
enddate = ymd("2007-02-02")
data=subset(data,startdate<=Date & Date<=enddate)

# Open a png device
png(filename="plot1.png",width=480,height=480)

# Graph a histogram of the Global Active Power
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

# Close png device
dev.off()