library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
names(NEI)
pm25_stat=ddply(NEI, .(year), summarise, total_emission=sum(Emissions))

png("Plot1.png")
plot(pm25_stat$year, pm25_stat$total_emission, pch = 20, type = "l", xlab = "year", ylab = "Total Emissions Each Year (In Tons)", xaxt = "n")
axis(1, at=pm25_stat$year)
dev.off()

png("Plot2.png")
baltimore_pm25_stat=ddply(NEI[{NEI$fips=="24510"},], .(year), summarise, total_emission=sum(Emissions))
plot(baltimore_pm25_stat$year, baltimore_pm25_stat$total_emission, pch = 20, type = "l", xlab = "year", ylab = "Total Emissions Per Year (In Tons)", xaxt = "n")
axis(1, at=baltimore_pm25_stat$year)
dev.off()

library(ggplot2)
png("Plot3.png")
baltimore_type_pm25_stat=ddply(NEI[{NEI$fips=="24510"},], .(year, type), summarise, total_emission=sum(Emissions))
plot=ggplot(baltimore_type_pm25_stat, aes(x=year, y=total_emission, col=type))
plot + geom_line() + scale_x_continuous(breaks=baltimore_type_pm25_stat$year)+xlab("year")+ylab("Total Emissions Per Year (In Tons)")
dev.off()

joined_pm25_tbl=join(NEI, SCC, by=("SCC"),type="left")

png("Plot4.png")
comb_coal_pm25=joined_pm25_tbl[grepl("^Fuel Comb.*Coal$",joined_pm25_tbl$EI.Sector),]
comb_coal_pm25_stat=ddply(comb_coal_pm25, .(year), summarise, total_emission=sum(Emissions))
plot=ggplot(comb_coal_pm25_stat, aes(x=year, y=total_emission))
plot+geom_line() + scale_x_continuous(breaks=comb_coal_pm25_stat$year)+xlab("year")+ylab("Total Emissions Per Year (In Tons)")
dev.off()

png("Plot5.png")
vehicel_pm25=joined_pm25_tbl[grepl("^Mobile.*Vehicles$", joined_pm25_tbl$EI.Sector) & joined_pm25_tbl$fips=="24510",]
vehicel_pm25_stat=ddply(vehicel_pm25, .(year), summarise, total_emission=sum(Emissions))
plot=ggplot(vehicel_pm25_stat, aes(x=year, y=total_emission))
plot+geom_line() + scale_x_continuous(breaks=vehicel_pm25_stat$year)+xlab("year")+ylab("Total Emissions Per Year (In Tons)")
dev.off()

png("Plot6.png")
vehicel_pm25=joined_pm25_tbl[grepl("^Mobile.*Vehicles$", joined_pm25_tbl$EI.Sector) & joined_pm25_tbl$fips %in% c("24510","06037"),]
vehicel_pm25_stat=ddply(vehicel_pm25, .(year, fips), summarise, total_emission=sum(Emissions))
plot=ggplot(vehicel_pm25_stat, aes(x=year, y=total_emission, col=fips))
plot+geom_line() + scale_x_continuous(breaks=vehicel_pm25_stat$year)+xlab("year")+ylab("Total Emissions Per Year (In Tons)")+scale_color_discrete(breaks=c("24510","06037"), labels=c("Baltimore","Los Angeles"))
dev.off()
