# Plot 4 (assignment goal: 4 subplots)

############ this snippet of code is the same as for Plot 2 and Plot 3

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

############ this is new code specific to Plot4.

# call graphics device, name figure plot4.png and size it 480 x 480 per the instructions
png("plot4.png", width= 480, height = 480)

# alter parameters to have 4 subplots that are filled row-wise
par(mfrow = c(2,2))

# plot 1, upper left
plot(power[, DateTime], power[, Global_active_power], type = "l", xlab = "", ylab = "Global Active Power")

# plot 2, upper right
plot(power[, DateTime], power[, Voltage], type = "l", xlab = "datetime", ylab = "Voltage")

# plot 3, lower left.  
# Cut and paste code snippet from Plot3.R
plot(power[, DateTime], power[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
# add lines for 2 other variables
lines(power[, DateTime], power[, Sub_metering_2], col = "red")
lines(power[, DateTime], power[, Sub_metering_3], col = "blue")


# make a legend
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1),
       bty = "n", # no box around legend
       cex = .5) # scaling of text and symbols relative to default


# plot 4, lower right
plot(power[, DateTime], power[, Global_reactive_power], type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#turn off device
dev.off()