## construct plot 4: multiple plots

# set the URL
sURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download zip file and unzip
download.file(sURL, destfile = "household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

# read data, filter the missing values
PCons <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?")

# Take only Feb. 1 and 2, 2007
PConsFeb <- subset(PCons, Date %in% c("1/2/2007","2/2/2007"))

# Concatenate Date and Time and convert
PConsFeb$Date <- as.Date(PConsFeb$Date, format="%d/%m/%Y")
# Create a new variable for date / time
DateTime <- paste(as.Date(PConsFeb$Date), PConsFeb$Time)
PConsFeb$DateTime <- as.POSIXct(DateTime)

# Construct Plot 4
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
# Plot 1.1: Global active power
with(PConsFeb,plot(Global_active_power~DateTime, type="l",ylab="Global Active Power (kilowatts)", xlab=""))

# Plot 1.2: Voltage
with(PConsFeb,plot(Voltage~DateTime, type="l", xlab="datetime", ylab="Voltage"))

# Plot 2.1: Sub metering
with(PConsFeb,plot(Sub_metering_1~DateTime, type="l",ylab="Energy sub metering", xlab=""))
with(PConsFeb,lines(Sub_metering_2~DateTime, col="red"))
with(PConsFeb,lines(Sub_metering_3~DateTime, col="blue"))
legend("topright", lty=1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

# Plot 2.2: Global reactive power
with(PConsFeb,plot(Global_reactive_power~DateTime, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()  # Close the Graphical Device