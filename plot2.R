## construct plot 2: evolution of Global_active_power variable

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

# Construct Plot 2: evolution of Global active power over the days (french version in the plot)
png("plot2.png", width=480, height=480)
with(PConsFeb,plot(Global_active_power~DateTime, type="l",ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()  # Close the Graphical Device