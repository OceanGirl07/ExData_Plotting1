# Plot 3 (assignment goal: overlay three plots on one graph)

############ this snippet of code is the same as for Plot 2

# load "data.table" so we can use fread to quickly read in files
library("data.table")

# read data from textfile
power <- data.table::fread(input = "household_power_consumption.txt",
                           na.strings = "?") #after looking at text file, missing values are "?"

# use hint in prompt: you may find it useful to convert Data and Time Variables to Date/Time classes using as.Date() function.
# Note, in the txt file, dates are day/month/Year.


# coerce to POSIXct date/time.  combine "Date" and "Time" into "DateTime" and coerce to POSIXct.  
# this creates a 10th variable "DateTime" in the data frame "power."
power[, DateTime := as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S")] 

#Filter dates for the two days required: Feb 1 and Feb 2, 2007
power <- power[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03")] #cuts down to 1441 obs of 10 variables 

############ this is new code specific to Plot3.

# call graphics device, name figure plot3.png and size it 480 x 480 per the instructions
png("plot3.png", width= 480, height = 480)

# plot 3 variables (#7,8,9 from power data frame) from the data frame against DateTime on the same graph
plot(power[, DateTime], power[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
    # add lines for 2 other variables
lines(power[, DateTime], power[, Sub_metering_2], col = "red")
lines(power[, DateTime], power[, Sub_metering_3], col = "blue")

# make a legend
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1))
#lty is line type, lwd is line width.


#turn off device
dev.off()