## Construct the Plot 2

rm(list = ls())             # clear objects
graphics.off()              # close graphics windows

## Load the data (with all values being characters)
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   colClasses = "character")

# Replace missing values with NA
data[data == "?"] = NA

# Convert the first column to Date class in the format of "yyyy-mm-dd"
data$Date = as.Date(data$Date, "%d/%m/%Y")


## Select data for the dates 2007-02-01 and 2007-02-02.
dat <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")


## Delete the original data
rm(data)


## Create the graph - Plot 2

x <- as.POSIXct(paste(dat$Date, dat$Time))  # x-axis
y <- as.numeric(dat$Global_active_power)    # y-axis

# Graphical device for a PNG format bitmap file
png("plot2.png", width=480, height=480, bg="transparent")

plot(x, y, type='l', xlab="", ylab="Global Active Power (kilowatts)")

# Shut down the current device
dev.off()
