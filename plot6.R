# read the data
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# make a subset of pollution data with SCC == 10100101 (“Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”)
subset_coal_combustion = subset(NEI, SCC==10100101)

# make a subset of petroleum caused pollution from the SCC dataframe
subset_petroleum = subset(SCC, SCC.Level.One == "Petroleum and Solvent Evaporation")

# extract the list of SCC codes for the above pollution cause
SCC_petroleum_list <- c(subset_petroleum$SCC)

# make a subset of NEI dataframe with petroleum caused pollution
NEI_petroleum <- NEI[NEI$SCC %in% SCC_petroleum_list,]

# aggregate the subset by year sums and rename the columns
aggregated_Petroleum = aggregate(NEI_petroleum$Emissions, by=list(NEI_petroleum$year), FUN=sum)
aggregated_coal = aggregate(subset_coal_combustion$Emissions, by=list(subset_coal_combustion$year), FUN=sum)

names(aggregated_coal)[names(aggregated_coal) == 'Group.1'] <- 'year'
names(aggregated_coal)[names(aggregated_coal) == 'x'] <- 'Emissions'

names(aggregated_Petroleum)[names(aggregated_Petroleum) == 'Group.1'] <- 'year'
names(aggregated_Petroleum)[names(aggregated_Petroleum) == 'x'] <- 'Emissions'

# add group names to the aggregated dataframes before combining them into one dataframe
aggregated_coal$group <- "coal"
aggregated_Petroleum$group <- "Petroleum"

# combine the aggregated
comparison_coal_vs_petroleum <- rbind(aggregated_coal, aggregated_Petroleum)

# plot the results
g1 <- ggplot(comparison_coal_vs_petroleum, aes(x=year, y=Emissions, col=group, fill=group)) + geom_line(size=2) + xlab("Year") + ylab("Emissions")
g1 + theme(axis.text=element_text(size=12), axis.title=element_text(size=14,face="bold"))

# write the plot to png file
dev.print(png, file = "plot6.png", width = 700, height = 480)
