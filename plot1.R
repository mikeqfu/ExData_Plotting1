## Construct the Plot 1

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


## Select data from the dates 2007-02-01 and 2007-02-02.
dat <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")


## Delete the original data
rm(data)


## Create the graph - Plot 1

# Graphical device for a PNG format bitmap file
png("plot1.png", width=480, height=480, bg="transparent")

# Draw the histogram
hist(as.numeric(dat$Global_active_power), 
     main = "Global Active Power", 
     col = "red", 
     xlab = "Global Active Power (kilowatts)")

# Shut down the current device
dev.off()
