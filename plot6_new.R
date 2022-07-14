library(ggplot2)
# read the data
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# subset for Los Angeles
LosAngeles_df <- subset(NEI, fips=="06037" & type=="ON-ROAD")

# subset for Baltimore
Baltimore_df <- subset(NEI, fips=="24510" & type=="ON-ROAD")


# aggregate the subset by year sums and rename the columns
aggregated_Petroleum_LosAngeles = aggregate(Emissions~year,LosAngeles_df,sum)
aggregated_Petroleum_Baltimore = aggregate(Emissions~year,Baltimore_df,sum)

names(aggregated_Petroleum_LosAngeles)[names(aggregated_Petroleum_LosAngeles) == 'Group.1'] <- 'year'
names(aggregated_Petroleum_LosAngeles)[names(aggregated_Petroleum_LosAngeles) == 'x'] <- 'Emissions'

names(aggregated_Petroleum_Baltimore)[names(aggregated_Petroleum_Baltimore) == 'Group.1'] <- 'year'
names(aggregated_Petroleum_Baltimore)[names(aggregated_Petroleum_Baltimore) == 'x'] <- 'Emissions'

# add group names to the aggregated dataframes before combining them into one dataframe
aggregated_Petroleum_LosAngeles$group <- "LosAngeles"
aggregated_Petroleum_Baltimore$group <- "Baltimore"

# combine the aggregated
comparison_LA_vs_Baltimore <- rbind(aggregated_Petroleum_LosAngeles, aggregated_Petroleum_Baltimore)

# plot the results
g1 <- ggplot(comparison_LA_vs_Baltimore, aes(x=year, y=Emissions, col=group, fill=group)) + geom_line(size=2) + xlab("Year") + ylab("Emissions")
g1 + theme(axis.text=element_text(size=12), axis.title=element_text(size=14,face="bold"))

# write the plot to png file
dev.print(png, file = "plot6.png", width = 700, height = 480)
