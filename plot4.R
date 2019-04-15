#import libraries required for  script
library(dplyr)
library(ggplot2)

#Read files
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

##Question 4
##Across the United States, how have emissions from coal 
##combustion-related sources changed from 1999-2008?

##create indices for subsetting nei_data for only the 
##coal related observations
cl <- grepl("[Cc]oal", scc_data$Short.Name)
dcl <- scc_data[cl,]
dcl_u <- unique(dcl$SCC)

##subset the nei_data for coal related emmissions
coal_data <- nei_data %>% filter(SCC %in% dcl_u)
#coal_data <- nei_data[nei_data$SCC %in% dcl_u,]


##plot the graph for comparison over the years
png(filename = "plot4.png")
ggplot(data = coal_data, aes(year, Emissions)) + 
        geom_point(aes(color = year)) + 
        labs(title = "Emissions from coal combustion-related sources from 1999-2008")
dev.off()
ggsave(file = "plot4.png")

##No big spikes of pollution
##Lower emissions from coal