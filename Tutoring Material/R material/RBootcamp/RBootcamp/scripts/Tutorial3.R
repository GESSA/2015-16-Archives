
## @knitr setup, include=FALSE
# set global chunk options
opts_chunk$set(fig.path='figure/slides3-', cache.path='cache/slides3-',fig.width=8,fig.height=6,message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,dev='svg',comment=NA,size='tiny')
options(width=70)
library(plyr)


## @knitr readdata
# Set working directory to the tutorial directory
# In RStudio can do this in "Tools" tab
setwd('~/GitHub/r_tutorial_ed')
#Load some data
load("data/smalldata.rda")
# Note if we don't assign data to 'df'
# R just prints contents of table


## @knitr table
table(df$grade,df$year)


## @knitr table2
table(df$year,df$race)


## @knitr table3
with(df[df$grade==3,],{table(year,race)})


## @knitr table3.2
df2<-subset(df,grade==3)
table(df2$year,df2$race)
rm(df2)


## @knitr table4,tidy=FALSE
with(df[df$race=="B",],{table(year,grade)})


## @knitr proftable
table(df$year,df$proflvl)


## @knitr raceproftable
table(df$race,df$proflvl)


## @knitr proptable1
prop.table(table(df$race,df$proflvl))


## @knitr proptable2
round(prop.table(table(df$race,df$proflvl),1),digits=3)


## @knitr aggregate1
# Reading Scores by Race
aggregate(readSS~race,FUN=mean,data=df)


## @knitr aggregate2
aggregate(cbind(readSS,mathSS)~race,data=df,mean)


## @knitr aggregate3
head(aggregate(cbind(readSS,mathSS)~race+grade,data=df,mean),8)


## @knitr crosstab
ag<-aggregate(readSS~race+grade,data=df,mean)
xtabs(readSS~., data=ag)


## @knitr crosstabpretty
ftable(xtabs(readSS~.,data=ag))


## @knitr aggregatetest
aggregate(cbind(readSS,mathSS)~disab+grade,data=df,mean)


## @knitr aggregate4
z<-aggregate(readSS~dist,FUN=mean,data=df)
z


## @knitr plyr1,tidy=FALSE
  library(plyr)
myag<-ddply(df, .(dist,grade),summarize,
            mean_read=mean(readSS,na.rm=T),
            mean_math=mean(mathSS,na.rm=T),
            sd_read=sd(readSS,na.rm=T),
            sd_math=sd(mathSS,na.rm=T),
            count_read=length(readSS),
            count_math=length(mathSS))


## @knitr plyr1.1,tidy=FALSE
head(myag)


## @knitr plyr3,tidy=FALSE
myag<-ddply(df, .(dist,grade),summarize,
            mean_read=mean(readSS,na.rm=T),
            mean_math=mean(mathSS,na.rm=T),
            sd_read=sd(readSS,na.rm=T),
            sd_math=sd(mathSS,na.rm=T),
            count_read=length(readSS),
            count_math=length(mathSS),
            count_black=length(race[race=='B']),
            per_black=length(race[race=='B'])/length(readSS))
summary(myag[,7:10])            


## @knitr check2,tidy=FALSE
myag2<-ddply(df, .(dist,grade,ell),summarize,
            mean_read=mean(readSS,na.rm=T),
            mean_math=mean(mathSS,na.rm=T),
            sd_read=sd(readSS,na.rm=T),
            sd_math=sd(mathSS,na.rm=T),
            count_read=length(readSS),
            count_math=length(mathSS),
            count_black=length(race[race=='B']),
            per_black=length(race[race=='B'])/length(readSS))
subset(myag2,ell==1&grade==4)        


## @knitr sortwrong
df.badsort<-order(df$readSS,df$mathSS)
head(df.badsort)


## @knitr sortright
df.sort<-df[ order(df$readSS,df$mathSS,df$attday),]
head(df[,c(3,23,29,30)])
head(df.sort[,c(3,23,29,30)])


## @knitr sortright2
head(df[with(df,order(-readSS,-attday)),c(3,23,29,30)])


## @knitr matrixsort
M<-matrix(c(1,2,2,2,3,6,4,5),4,2,byrow=FALSE,dimnames=list(NULL,c("a","b")))
M[order(M[,"a"],-M[,"b"]),] # can't use "with"


## @knitr sorttable
mytab<-table(df$grade,df$year)
mytab[order(mytab[,1]),]
mytab[order(mytab[,2]),]


## @knitr columnfilter
# Gives all rows that meet this requirement
df[df$readSS>800,] 
df$grade[df$mathSS>800] 
# Gives all values of grade that meet this requirement


## @knitr filterlayers
df$grade[df$black==1 & df$readSS>650]


## @knitr filtersort
myag$spread<-NA # create variable
myag$spread[myag$sd_read<75]<-"low"
myag$spread[myag$sd_read>75]<-"high"
myag$spread<-as.factor(myag$spread)
summary(myag$spread)


## @knitr recodeexamp,eval=FALSE
myag$spread<-NA # create variable
myag$spread[myag$sd_read<75]<-"low"
myag$spread[myag$sd_read>75]<-"high"
myag$spread<-as.factor(myag$spread)


## @knitr answercoding
myag$schoolperf<-"lo"
myag$schoolperf[myag$grade==3 & myag$mean_math>425]<-"hi"
myag$schoolperf[myag$grade==4 & myag$mean_math>450]<-"hi"
myag$schoolperf[myag$grade==5 & myag$mean_math>475]<-"hi"
myag$schoolperf[myag$grade==6 & myag$mean_math>500]<-"hi"
myag$schoolperf[myag$grade==7 & myag$mean_math>525]<-"hi"
myag$schoolperf[myag$grade==8 & myag$mean_math>575]<-"hi"
myag$schoolperf<-as.factor(myag$schoolperf)
summary(myag$schoolperf)
table(myag$dist,myag$schoolperf)


## @knitr replacedata
myag$mean_read[myag$dist==6 &myag$grade==3]<-NA
head(myag[,1:4],2)


## @knitr replacedata2
myag$mean_read[myag$dist==6 & myag$grade==3]<-myag$mean_read[myag$dist==6 & myag$grade==4]
head(myag[,1:4],2)


## @knitr munge
myag$mean_read[myag$grade==3]<-NA
head(myag[order(myag$grade),1:4])


## @knitr means
mean(myag$mean_math)
mean(myag$mean_read)


## @knitr meansna
mean(myag$mean_math,na.rm=T)
mean(myag$mean_read,na.rm=T)


## @knitr length
length(myag$dist[myag$mean_read<500])
head(myag$mean_read[myag$mean_read<500])


## @knitr addtomissing
badvar<-myag$mean_read+myag$sd_read
summary(badvar)


## @knitr moremissing
myag$sd_read[myag$count_read<100 & myag$mean_read<550]<-NA
length(myag$mean_read[myag$mean_read<550])
length(myag$mean_read[myag$mean_read<550 & !is.na(myag$mean_read)])


## @knitr mymerge1
names(myag)
names(df[,c(2,3,4,6)])


## @knitr simplemerge
simple_merge<-merge(df,myag)
names(simple_merge)


## @knitr createwidedata,echo=FALSE,results='hide'
widedf<-reshape(df,timevar="year",idvar="stuid",direction="wide")


## @knitr longpreview
head(df[,1:10],3)


## @knitr widepreview
head(widedf[,c(1,28:40)],3)


## @knitr reshapeanaly, eval=FALSE
widedf<-reshape(df,timevar="year",idvar="stuid",direction="wide")


## @knitr widetolong
longdf<-reshape(widedf,idvar='stuid',timevar='year',
varying=names(widedf[,2:91]),direction='long',sep=".")


## @knitr subset1
g4<-subset(df,grade==4)
dim(g4)


## @knitr subset2
g4_b<-df[df$grade==4,]


## @knitr testofequality
identical(g4,g4_b)


## @knitr session-info
print(sessionInfo(), locale=FALSE)


