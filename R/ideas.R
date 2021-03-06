#boxplot(df$age ~ df$race)
#hist(df$age,breaks=length(unique(df$age))*0.5)
#hist(df$date,breaks=length(unique(df$date))*0.5)

#plot(x=df$date, y=df$age, col=df$race, pch=19)

# library(psych) and also describe all of these

#rev(sort(table(df$first_name)))[1:10]

#rev(sort(table(df$last_name)))[1:10]

library(psych)
library(ggplot2)
library(grid)
library(RColorBrewer)

df = read.csv("table.datecleaned.csv")
df$link1 = NULL
df$link2 = NULL

#ggplot(df, aes(x=date,y=age,colour=race)) + geom_point(size=3) + 
#  scale_x_continuous(breaks=c(1980,1985,1990,1995,2000,2005,2010,2015)) +
#  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm"))

ggplot(df, aes(x=age,fill=race) ) + geom_histogram(binwidth=3,colour="white") +
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm")) + scale_fill_brewer(palette="Spectral") +
  theme(plot.title = element_text(size=25, vjust=2)) +
  theme(axis.title.x = element_text(size=20, vjust=-1)) +
  theme(axis.title.y = element_text(size=20, vjust=3))  +
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm")) +
  ggtitle("Histogram of age, bins grouped by race")

ggplot(df, aes(x=age, fill=race)) + geom_density(alpha=0.3) +
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm")) +
  theme(plot.title = element_text(size=25, vjust=2)) +
  theme(axis.title.x = element_text(size=20, vjust=-1)) +
  theme(axis.title.y = element_text(size=20, vjust=-1)) +
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm")) +
  ggtitle("Density plot of age (for each race)")

ggplot(df, aes(x=date,fill=race) ) + geom_histogram(binwidth=3,colour="white") +
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm")) + scale_fill_brewer(palette="Spectral") +
  theme(plot.title = element_text(size=25, vjust=2)) +
  theme(axis.title.x = element_text(size=20, vjust=-1)) +
  theme(axis.title.y = element_text(size=20, vjust=3))  +
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm")) +
  ggtitle("Histogram of execution count by year, bins grouped by race")



# ---

library(tm)
library(wordcloud)

txt = Corpus(DirSource("wordcloud/"))
txt = tm_map(txt, stripWhitespace)
txt = tm_map(txt, tolower)
txt = tm_map(txt, removeWords, stopwords("english"))
txt = tm_map(txt, removePunctuation)

col.scheme = c("#fd8d3c","#fc4e2a","#e31a1c","#bd0026","#800026")

png("final-output.png",width=1600,height=800) # create a png graphics device
wordcloud(txt,
          scale=c(25,0.02),
          random.order=FALSE,
          max.words=1500,
          colors=col.scheme,
          rot.per=0,
          fixed.asp=FALSE,
          random.color=TRUE)
dev.off() # turn off the device -- i.e. write it to disk now!