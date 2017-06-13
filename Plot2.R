# Plot 2

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


# call graphics device, name figure plot2.png and size it 480 x 480 per the instructions
png("plot2.png", width= 480, height = 480)

# plot
plot(x = power[, DateTime], 
     y = power[, Global_active_power],
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
     

#turn off device
dev.off()