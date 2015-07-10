## Construct the Plot 4

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

# Convert each of the last six columns to numeric class
for (i in 3:ncol(data)) {
    data[[i]] <- as.numeric(data[[i]])
}
rm(i)
# Alternatively, convert each column one by one
if (FALSE) {
    data$Global_active_power = as.numeric(data$Global_active_power)
    data$Global_reactive_power = as.numeric(data$Global_reactive_power)
    data$Voltage = as.numeric(data$Voltage)
    data$Global_intensity = as.numeric(data$Global_intensity)
    data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
    data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
    data$Sub_metering_3 = as.numeric(data$Sub_metering_3)   
}


## Select data for the dates 2007-02-01 and 2007-02-02.
dat <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")


## Delete the original data
rm(data)


## Create graphs - Plot 4

# Graphical device for a PNG format bitmap file
png("plot4.png", width=480, height=480, bg="transparent")

# Set up drawing of multiple plots by row
par(mfrow=c(2,2))
# par(mar=c(5,4,4,2)) + 0.1

# Plot 4-1
x1 <- as.POSIXct(paste(dat$Date, dat$Time))     # x-axis
y1 <- dat$Global_active_power                   # y-axis
plot(x1, y1, type='l', xlab="", ylab="Global Active Power")

# Plot 4-2
x2 <- as.POSIXct(paste(dat$Date, dat$Time))     # x-axis
y2 <- dat$Voltage                               # y-axis
plot(x2, y2, type='l', xlab="datetime", ylab="Voltage")

# Plot 4-3
x3 <- as.POSIXct(paste(dat$Date, dat$Time))     # x-axis
y3_1 <- dat$Sub_metering_1                      # 1st y-axis
y3_2 <- dat$Sub_metering_2                      # 2nd y-axis
y3_3 <- dat$Sub_metering_3                      # 3rd y-axis
lc <- c("black","red", "blue")                  # Specify different colours

plot(x3, y3_1, type='l', xlab="", ylab="Energy sub metering", col=lc[1]) # 1st
lines(x3, y3_2, col=lc[2])                                               # 2nd
lines(x3, y3_3, col=lc[3])                                               # 3rd
legend("topright", legend=names(dat)[7:9], lty=1, bty="n", col=lc)

# plot 4-4
x4 <- as.POSIXct(paste(dat$Date, dat$Time))     # x-axis
y4 <- dat$Global_reactive_power                 # y-axis
plot(x4, y4, type='l', xlab="datetime", ylab="Global_reactive_power")

# Shut down the current device
dev.off()
