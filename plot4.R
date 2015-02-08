## check the location of workdirectory
library(data.table)

# download the file to the default location 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption"
download.file(url, file, method = "curl")

# unzp the file
unzip(file, exdir = "Exploratory-Data-Analysis")

#read data with fread
data <- fread("household_power_consumption.txt")


data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# foramt the data time of date

data_sub <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

# Convert data subset to a data.frame
class(data_subset)
data_sub <- data.frame(data_sub)

# Convert columns to numeric
for(i in c(3:9)) {data_sub[,i] <- as.numeric(as.character(data_sub[,i]))}

# Create Date_Time variable as char
data_sub$DateTime <- paste(data_sub$Date, data_sub$Time)

# Convert DateTime variable to proper format
data_sub$DateTime <- strptime(data_sub$DateTime, format="%Y-%m-%d %H:%M:%S")


png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 2), cex=.5)

#plot 1 top left 
plot(data_sub$DateTime, data_sub$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
# create the line between points
lines(data_sub$DateTime, data_sub$Global_active_power)

#plot 2 top right
plot(data_sub$DateTime, data_sub$Voltage, xlab = "datetime", ylab = "Voltage" , type = "n")
# create the line between points
lines(data_sub$DateTime, data_sub$Voltage)

# plot 3 lower left

# plot without any data
plot(data_sub$DateTime, data_sub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
# create the line between points for Sub_metering_1
lines(data_sub$DateTime, data_sub$Sub_metering_1, col = "black")
# create the line between points for Sub_metering_2
lines(data_sub$DateTime, data_sub$Sub_metering_2, col = "red")
# create the line between points for Sub_metering_3
lines(data_sub$DateTime, data_sub$Sub_metering_3, col = "blue")
#create the legende
legend("topright", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# plot 4 lower right
plot(data_sub$DateTime, data_sub$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power" , type = "n")
# create the line between points
lines(data_sub$DateTime, data_sub$Global_reactive_power)

dev.off()
