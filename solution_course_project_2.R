# read the data
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# construct a dataframe with total amount of pollution by year
total_emissions_by_year <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)

# plot the results (the plot shows decrease of pollution amounts from 1999 to 2008)
plot(total_emissions_by_year$year, total_emissions_by_year$x, pch=19, cex=3, xlab = "year", ylab = "total pollution")

# write the plot to png file
dev.print(png, file = "plot1.png", width = 480, height = 480)
