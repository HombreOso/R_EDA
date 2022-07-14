# read the data
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# make subset for Baltimore
Baltimore_df <- subset(NEI, fips==24510)

# construct the plot3 aggregating by year (sum) and grouping by type
# "scales='free' adjusts plot scales for each facet, so that the plot is scaled to its limits"
ggplot(Baltimore_df) + stat_summary(aes(x = year, y = Emissions), fun = sum, geom = "line") + facet_grid(type~., scales = "free")


# write the plot to png file
dev.print(png, file = "plot3.png", width = 700, height = 480)
