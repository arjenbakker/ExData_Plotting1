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

# create plot2.pgn
png(filename = "plot2.png", width = 480, height = 480)
plot(datetime, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()