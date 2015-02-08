# read a subset of the original dataset, which was unzipped into the working directory
fpc <- file("household_power_consumption.txt","r");
powerConsumption <- read.table(text = grep("^[1,2]/2/2007", readLines(fpc), value=TRUE), sep=";", na.strings="?") 							 
closeAllConnections()

# set names to columns
names(powerConsumption)<- c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity",
							"SubMetering1", "SubMetering2", "SubMetering3")

# paste Date and Time together into a new column and convert to Date/Time classes in R
DateTime <- paste(powerConsumption$Date, powerConsumption$Time)
powerConsumption$DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")

# the new column replaces Date and Time columns
power <- powerConsumption[,c("DateTime", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity",
							"SubMetering1","SubMetering2","SubMetering3")]
# head(power)

# create Plot 3
png(filename="plot3.png", width=480, height=480, units="px", bg="white")
plot(power$DateTime, power$SubMetering1, type="l", xlab="", ylab="Energy sub metering")
lines(power$DateTime, power$SubMetering2, type="l", col="red")
lines(power$DateTime, power$SubMetering3, type="l", col="blue")
legend("topright", lty=1, lwd=1, col=c("black", "blue", "red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	   
# close graphic device
dev.off()