library(ggplot2)

args<-commandArgs(TRUE)
data = read.csv(args[1], header = F, sep = "\t")
#print (data)

countries = data[,1]
population = data[,2]
print(countries)
print(population)
# Create test data.
dat = data.frame(count=population, category=countries)
#print (dat)

# Add addition columns, needed for drawing with geom_rect.
dat$fraction = dat$count / sum(dat$count)
dat = dat[order(dat$fraction), ]
dat$ymax = cumsum(dat$fraction)
dat$ymin = c(0, head(dat$ymax, n=-1))

pdf(args[2], width = 14, height = 7.1)
par(oma = c(0, 0, 0, 0), mar = c(0.01, 0, 0, 34), xpd=TRUE)

#ggplot(dat, aes(fill=category, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
#     geom_rect(colour="grey30") +
#     coord_polar(theta="y") +
#     xlim(c(0, 4)) +
#     theme_bw() +
#     theme(panel.grid=element_blank()) +
#     theme(axis.text=element_blank()) +
#     theme(axis.ticks=element_blank()) +
#     labs(title="Languages by native speaker")

# Pie Chart with Percentages
slices <- population 
lbls <- countries
pct <- round(slices/sum(slices)*100)
lbls_pct <- paste(pct,"%",sep="") # ad % to labels 

pie(slices,labels = NA, col=rainbow(length(slices)), bty='L')
legend("topright", inset=c(-0.9,0.01), legend=lbls, cex = 1.0,fill = rainbow(length(slices)), ncol=3)
#library(gridExtra)
#png("ring_plots_1.png", height=4, width=8, units="in", res=120)
#grid.arrange(p2, nrow=1)
dev.off()
