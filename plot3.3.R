library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- NEI[NEI$fips == "24510",]
differentTypes <- split(NEI, NEI$type)
sums <- lapply(differentTypes, function(x) {
        with(x, tapply(Emissions, year, sum))
}
)
df <- data.frame(
        "type" = rep(names(sums), times = rep(4, 4)), 
        "year" = unlist(lapply(sums, names)),
        "total" = unlist(lapply(sums, function(x) x))
)
options(scipen = 5)
png(filename='plot3.png')
plt <- qplot(
        year,
        total,
        data = df,
        facets = .~type,
        main = 'PM2.5 Trends over Time by Source for Baltimore City',
        ylab = 'PM2.5 Totals (tons)',
        xlab = 'Year'
)
print(plt)
dev.off()