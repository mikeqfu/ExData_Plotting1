## Construct the Plot 3

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

# Convert each of the last three columns to numeric class
for (i in 7:ncol(data)) {
    data[[i]] <- as.numeric(data[[i]])
}
rm(i)


## Select data for the dates 2007-02-01 and 2007-02-02.
dat <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")


## Delete the original data
rm(data)


## Create the graph - Plot 3

x <- as.POSIXct(paste(dat$Date, dat$Time))  # x-axis
y1 <- dat$Sub_metering_1                    # 1st y-axis
y2 <- dat$Sub_metering_2                    # 2nd y-axis
y3 <- dat$Sub_metering_3                    # 3rd y-axis

# Graphical device for a PNG format bitmap file
png("plot3.png", width=480, height=480, bg="transparent")

plot(x, y1, type='l', xlab="", ylab="Energy sub metering", col="black") # 1st
lines(x, y2, col="red")                                                 # 2nd
lines(x, y3, col="blue")                                                # 3rd
legend("topright", legend=names(dat)[7:9], lty=1, col=c("black","red", "blue"))

# Shut down the current device
dev.off()
