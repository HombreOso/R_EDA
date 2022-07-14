# read the data
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# make a subset of petroleum caused pollution from the SCC dataframe
subset_petroleum = subset(SCC, SCC.Level.One == "Petroleum and Solvent Evaporation")

# extract the list of SCC codes for the above pollution cause
SCC_petroleum_list <- c(subset_petroleum$SCC)

# make a subset of NEI dataframe with petroleum caused pollution
NEI_petroleum <- NEI[NEI$SCC %in% SCC_petroleum_list,]

# aggregate by year sums and plot the results
g <- ggplot(NEI_petroleum) + stat_summary(aes(x = year, y = Emissions), fun = sum, geom = "line") + xlab("year") + ylab("total emissions Petroleum across USA")
g + theme(axis.text=element_text(size=12), axis.title=element_text(size=14,face="bold"))

# write the plot to png file
dev.print(png, file = "plot5.png", width = 700, height = 480)

