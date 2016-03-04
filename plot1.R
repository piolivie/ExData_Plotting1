#  Check if file exists and download file
if(!file.exists("data")){dir.create("data")}

# Set working directory
setwd("./data")

### Download and unzip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
dest <-"household_power_consumption.zip";
download.file(url, destfile= dest)
file<-unzip (dest)

### Load dataset and filter dates
library("sqldf");
df <-read.csv.sql(file, sql = "select * from file where Date in('1/2/2007','2/2/2007')", header = TRUE, sep = ";")
sqldf() # close connection
df$DateTime<-strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S") # Create datetime (POSIXtl format)

### Print to 1 row and 1 column
par(mfrow=c(1,1))

### Plot1 (histogram)
png(filename = "plot1.png", width = 480, height = 480) # output as png
hist(df$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Reset device
dev.off()
par(mfrow=c(1,1))

