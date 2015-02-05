temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
cons <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",skip=66000,nrows=5000)
header <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",nrows=1)
names(cons) <- unlist(header)
##unlink(temp)

cons1 <- subset(cons,as.character(cons$Date)=="1/2/2007")
cons2 <- subset(cons,as.character(cons$Date)=="2/2/2007")
needed <- rbind(cons1,cons2)
library(dplyr)
needed2 <- mutate(needed,DateTime=paste(Date,Time))
needed2$DateTime <- strptime(needed2$DateTime,format="%d/%m/%Y %H:%M:%S")

##For Plot 4
png(height=480,width=480,units="px",filename="C:/Users/uma.aiyer/Documents/RLearning/plot4.png",bg="transparent")
par(mfrow=c(2,2),mar=c(4, 4, 1, 2),oma = c(0, .5, 0,0.5 ))

Plot1 <- plot(needed2$DateTime,as.numeric(as.character(needed$Global_active_power)),type="l",xlab=" ",ylab="Global Active Power")

Plot2 <- plot(needed2$DateTime,as.numeric(as.character(needed2$Voltage)),type="l",xlab="datetime",ylab="Voltage")

Plot3<- plot(needed2$DateTime,as.numeric(as.character(needed2$Sub_metering_1)),type="l",xlab=" ",ylab="Energy Sub Metering") +
lines(needed2$DateTime,y=as.numeric(as.character(needed2$Sub_metering_2)),col="red") +
lines(needed2$DateTime,y=needed2$Sub_metering_3,col="blue")+
legend("topright", col = c("black", "red", "blue"), lty = c("solid", "solid", "solid"), legend = names(needed2[,7:9]),x.intersp=0.6,bty="n")

Plot4 <- plot(needed2$DateTime,as.numeric(as.character(needed2$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")

par(mfrow=c(1,1),mar=c(5, 4, 4, 2) + 0.1)
dev.off()