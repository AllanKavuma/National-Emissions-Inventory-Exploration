NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Decided to not include Non-Road Equipment
mvSources <- SCC[sapply('Vehicles', grepl, SCC$EI.Sector),'SCC']

mvData <- NEI[NEI$SCC %in% mvSources, ]

baltimoreMvData <- NEI[NEI$fips == "24510",]

laCountyMvData <- NEI[NEI$fips == "06037",]

options(scipen=10000)

png(filename='plot6.1.png')
par(mfcol = c(2,1))
with(baltimoreMvData, 
     boxplot(Emissions~year, outline=FALSE, main='Motor Vehicle Emissions Trends Per Year, Baltimore City\n(outliers removed)', 
             xlab='Year', 
             ylab='PM2.5 Emissions (tons)')
)
with(laCountyMvData, 
     boxplot(Emissions~year, outline=FALSE, main='Motor Vehicle Emissions Trends Per Year, LA County\n(outliers removed)', 
             xlab='Year', 
             ylab='PM2.5 Emissions (tons)')
)
dev.off()