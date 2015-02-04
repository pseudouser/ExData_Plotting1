temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
cons <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",skip=66000,nrows=5000)
header <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",nrows=1)
names(cons) <- unlist(header)
unlink(temp)

cons1 <- subset(cons,as.character(cons$Date)=="1/2/2007")
cons2 <- subset(cons,as.character(cons$Date)=="2/2/2007")
needed <- rbind(cons1,cons2)
library(dplyr)
needed2 <- mutate(needed,DateTime=paste(Date,Time))
needed2$DateTime <- strptime(needed2$DateTime,format="%d/%m/%Y %H:%M:%S")

##For Plot 1
plot1 <- hist(as.numeric(as.character(needed2$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")
dev.copy(png,height=480,width=480,units="px",filename="C:/Users/uma.aiyer/Documents/RLearning/plot1.png")
dev.off()