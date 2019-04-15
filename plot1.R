#Read files
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

#question 1
#plot showing the total PM2.5 emission from all sources for 
#each of the years 1999, 2002, 2005, and 2008.
png(filename = "plot1.png")
with(nei_data, boxplot(log10(Emissions) ~ year, 
                       main = "Box plot for Year Emissions", 
                       ylab = "log10(Emissions)", 
                       xlab = "Years"))
dev.off()

##Yes, total emissions from PM2.5 decreased in the 
##United States from 1999 to 2008