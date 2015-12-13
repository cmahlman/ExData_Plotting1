# plot3.R shows plot of Energy Sub Metering over two days

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
plot(d$DateTime, d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
points(d$DateTime, d$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(d$DateTime, d$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), inset = .05)

# copy screen to PNG
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
