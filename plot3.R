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

### Plot3 (submetering)
png(filename = "plot3.png", width = 480, height = 480)
plot(df$DateTime,df$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(df$DateTime,df$Sub_metering_2, type="l", col="red")
lines(df$DateTime,df$Sub_metering_3, type="l", col="blue")
# Create a legend in the top-left corner
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, lwd=1, bty="y"); 

# Reset device
dev.off()
par(mfrow=c(1,1))

