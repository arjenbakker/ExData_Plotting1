sourcefile<-"household_power_consumption.txt"

# download and unzip sourcefile if it is not there already
if (!file.exists(sourcefile)) {
        url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp<-tempfile()
        download.file(url, temp)
        unzip(temp, "household_power_consumption.txt")
}

# read file, filter on date, and set correct datatype
hpc<-read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = "character")
hpc<-subset(hpc, Date=="1/2/2007" | Date=="2/2/2007")
hpc[,3:9]<-sapply(hpc[,3:9], as.numeric)

# create datetime variable
datetime<-strptime(paste(hpc$Date, hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# create plot3.pgn
png(filename = "plot3.png", width = 480, height = 480)
plot(datetime, hpc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, hpc$Sub_metering_2, col="red")
lines(datetime, hpc$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
