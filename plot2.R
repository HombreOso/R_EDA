# read the data
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# make subset for Baltimore
Baltimore_df <- subset(NEI, fips==24510)

# aggregate pollutions by year
total_emissions_by_year_Baltimore <- aggregate(Baltimore_df$Emissions, by=list(year=Baltimore_df$year), FUN=sum)

# plot the results
plot(total_emissions_by_year_Baltimore$year, total_emissions_by_year_Baltimore$x, pch=19, cex=3, xlab = "year", ylab = "total pollution in Baltimore")

# write the plot to png device
dev.print(png, file = "plot2.png", width = 700, height = 480)
