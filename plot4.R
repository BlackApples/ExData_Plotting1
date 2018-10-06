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

# Reformat Time column and create a new DateTime column with data+time
data$Time=hms(data$Time)
data=data.frame(data,DateTime=with(data,update(Date,hour=hour(Time),minute=minute(Time),second=second(Time))))

# Open a png device
png(filename="plot4.png",width=480,height=480)

# Graph 4  plots of the Global active power, Voltage, Energy submetering, and Global reactive power
par(mfrow=c(2,2))

  #plot1
plot(data$DateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power")
  #plot2
plot(data$DateTime,data$Voltage,type="l",xlab="datetime",ylab="Voltage")
  #plot3
plot(data$DateTime,data$Sub_metering_1,pch=20,type="n",xlab="",ylab="Energy sub metering")
points(data$DateTime,data$Sub_metering_1,col="black",type="l")
points(data$DateTime,data$Sub_metering_2,col="red",type="l")
points(data$DateTime,data$Sub_metering_3,col="blue",type="l")
legend("topright",col=c("Black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = "solid")
  #plot4
plot(data$DateTime,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

# Close png device
dev.off()