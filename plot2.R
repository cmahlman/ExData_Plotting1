# plot2.R will show line plot of Global Active Power over two days 
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
plot(d$DateTime, d$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# copy screen to PNG
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
