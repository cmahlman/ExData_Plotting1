# plot4.R shows a combination of 4 plots

# double check that working directory is set to location of "household_power_consumption.txt"

# load package
if (!require(sqldf)) {
    install.packages("sqldf")
    library(sqldf)
}

# read data only from 1/2/2007 and 2/2/2007
d <- read.csv.sql("household_power_consumption.txt", sql = 'SELECT * FROM file WHERE Date = "1/2/2007" OR Date = "2/2/2007"', header = TRUE, sep = ";")
detach("package:sqldf")

# convert Date column to POSIXlt 
d$Date <- strptime(d$Date, "%e/%m/%Y")
d$DateTime <- as.POSIXct(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S")

# plot Global Active Power
par(mfrow = c(2, 2))
# top left plot
plot(d$DateTime, d$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# top right plot
plot(d$DateTime, d$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

# bottom left plot
plot(d$DateTime, d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
points(d$DateTime, d$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(d$DateTime, d$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
# legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", box.lwd = 0, cex = .75, inset = .1)
legend("top", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", box.lwd = 0, cex = .75)

# bottom right plot
plot(d$DateTime, d$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

# copy screen to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
