# plot1.R will show histogram of Global Active Power
# double check that working directory is set to location of "household_power_consumption.txt"

# load package
if (!require(sqldf)) {
    install.packages("sqldf")
    library(sqldf)
}

# read data only from 1/2/2007 and 2/2/2007
d <- read.csv.sql("household_power_consumption.txt", sql = 'SELECT * FROM file WHERE Date = "1/2/2007" OR Date = "2/2/2007"', header = TRUE, sep = ";")

# convert Date column to POSIXlt 
d$Date <- strptime(d$Date, "%e/%m/%Y")

# plot Global Active Power
hist(d$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

# copy screen to PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
