#import libraries required for  script
library(dplyr)

#Read files
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

##Question 2
##Have total emissions from PM2.5 decreased in the 
##Baltimore City, Maryland (fips == "24510") from 1999 to 2008

###create balt_dt to store Baltimore, Maryland data
balt_dt <- nei_data %>% filter(fips == "24510")
##Box plot
png(filename = "plot2.png")
with(balt_dt, boxplot(log10(Emissions) ~ year, 
                       main = "Box plot for Baltimore, Maryland Year Emissions", 
                       ylab = "log10(Emissions)", 
                       xlab = "Years"))
dev.off()

##Yes, total emissions from PM2.5 decreased in the 
##Baltimore City, Maryland