# read the data
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# make a subset of pollution data with SCC == 10100101 (“Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”)
subset_coal_combustion = subset(NEI, SCC==10100101)

# aggregate and plot the results while making them properly visible
g <- ggplot(subset_coal_combustion) + stat_summary(aes(x = year, y = Emissions), fun = sum, geom = "line") + xlab("year") + ylab("total emissions coal combustion across USA")
g + theme(axis.text=element_text(size=12), axis.title=element_text(size=14,face="bold"))



# write the plot to png file
dev.print(png, file = "plot4.png", width = 900, height = 700)
