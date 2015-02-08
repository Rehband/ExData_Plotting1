# read a subset of the original dataset, which was unzipped into the working directory
fpc <- file("household_power_consumption.txt", "r")
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

# create Plot 1
png(filename="plot1.png", width=480, height=480, units="px", bg="white")
hist(power$GlobalActivePower, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

# close graphic device
dev.off()