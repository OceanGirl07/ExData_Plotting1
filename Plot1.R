# Plot 1

#load "data.table" so we can use fread to quickly read in files
library("data.table")

#read data from textfile
power <- data.table::fread(input = "household_power_consumption.txt",
                             na.strings = "?") #after looking at text file, missing values are "?"

#use hint in prompt: you may find it useful to convert Data and Time Variables to Date/Time classes using as.Date() function.
# Note, in the txt file, dates are day/month/Year.
power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#Filter dates for the two days required: Feb 1 and Feb 2, 2007
power <- power[(Date >= "2007-02-01") & (Date <= "2007-02-02")] #cuts down to 2880 obs of 9 variables instead of 2075259 obs of 9 variables

# call graphics device, name figure plot1.png and size it 480 x 480 per the instructions
png("plot1.png", width= 480, height = 480)

#plot
hist(power[, Global_active_power], main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "Red")

#turn off device
dev.off()
