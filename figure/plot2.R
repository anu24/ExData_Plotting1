library(datasets)

# check if the 'Data' folder exists, if not then create one.
if(!file.exists("Data")){dir.create("Data")}

# store the URL of the data file location
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download the data file and unzip it
download.file(fileurl, destfile = "./data/power_consumption.zip")
unzip("./Data/power_consumption.zip")

#read the file into R
data <- read.table("household_power_consumption.txt", sep = ";", header = T)

#check the attributes of the given dataset
names(data)

#check the classes of the variables of the dataset
lapply(data,class)

#add a new variable to the data frame 'data' by concatinating the date & time
data$DateTime <- paste(data$Date, data$Time)

# now change the 'DateTime' variable format to yyyy-mm-dd hh:mm:ss
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

# now will take the data from 2007-02-01 to 2007-02-02
DataFrom <-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d")) # data starts from this row
DataTo<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S")) # data ends at this row

data <- data[DataFrom:DataTo,]

# plot the global active power vs DateTime
# the global active power data in the dataset is in the form of 'factor' so
#converted the data to numeric with the format "as.numeric(levels(f))[f]"
plot(data$DateTime, as.numeric(levels(data$Global_active_power))[data$Global_active_power], 
     ylab = "global Active Power (kilowatts)", type = "l")

#create a PNG file of the graph
dev.copy(png, file="plot2.PNG", width = 480, height = 480)
dev.off()
