
## @knitr setup, include=FALSE
# set global chunk options
opts_chunk$set(fig.path='figure/slides4-', cache.path='cache/slides4-',fig.width=8,fig.height=6,
               message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,cache=TRUE,autodep=TRUE,comment=NA)


## @knitr dataread
load('data/Student_Attributes.rda')
head(stuatt[,1:4],7)


## @knitr dropvar9
stuatt$first_9th_year_reported<-NULL


## @knitr uniquegender
length(unique(stuatt$sid))
length(unique(stuatt$sid,stuatt$male))


## @knitr uniquenesstest
testuniqueness<-function(id,group){
  length(unique(id))==length(unique(id,group))
} # Need better varname and some optimization to the speed of this code
testuniqueness(stuatt$sid,stuatt$male)
testuniqueness(stuatt$sid,stuatt$race_ethnicity)
testuniqueness(stuatt$sid,stuatt$birth_date)


## @knitr seethegenderprob
stuatt[17:21,1:3]


## @knitr collapsegender
library(plyr)
sturow<-ddply(stuatt,.(sid),summarize,nvals_gender=length(unique(male)))
table(sturow$nvals_gender)


## @knitr statmode
# A function to find the most frequent value
library(eeptools)
sturow<-ddply(stuatt,.(sid),summarize,nvals_gender=length(unique(male)),gender_mode=statamode(male),gender_recent=tail(male,1))
head(sturow[7:10,])


## @knitr reconcilegender
tempdf<-merge(stuatt,sturow) # R finds the linking variable already
head(tempdf[17:21,c(1,2,3,10,11)])
print(subset(tempdf[,c(1,2,3,10,11)],sid==12506))


## @knitr reconcilegender2
print(subset(tempdf[,c(1,2,3,10,11,12)],sid==12506))


## @knitr solutiongender
tempdf$male<-tempdf$gender_mode
tempdf$male[tempdf$male=="."]<-tempdf$gender_recent[tempdf$male=="."]
# we have to put the filter on both sides of the assignment operator
testuniqueness(tempdf$id,tempdf$male)


## @knitr cleanup
rm(sturow)
stuatt<-tempdf
stuatt$nvals_gender<-NULL
stuatt$gender_mode<-NULL
stuatt$gender_recent<-NULL
# or just run stuatt<-tempdf[,1:9]
rm(tempdf)


## @knitr raceerror
summary(stuatt$race_ethnicity)


## @knitr recodeerrror,eval=FALSE
length(stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)])
stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)]<-"AI"
summary(stuatt$race_ethnicity)


## @knitr recodenaCORRECT
length(stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)])
stuatt$race_ethnicity<-as.character(stuatt$race_ethnicity)
stuatt$race_ethnicity[is.na(stuatt$race_ethnicity)]<-"AI"
stuatt$race_ethnicity<-factor(stuatt$race_ethnicity)
summary(stuatt$race_ethnicity)


## @knitr student3
stuatt[7:9,c("sid","school_year","race_ethnicity")]


## @knitr createnvalswithinyearI
nvals<-ddply(stuatt,.(sid,school_year),summarize,
             nvals_race=length(unique(race_ethnicity)),
             tmphispanic=length(which(race_ethnicity=="H")))
tempdf<-merge(stuatt,nvals)
# Clean up
rm(nvals)
# Recode race_ethnicity
tempdf$race2<-tempdf$race_ethnicity
tempdf$race2[tempdf$nvals_race>1 & tempdf$tmphispanic==1]<-"H"
tempdf$race2[tempdf$nvals_race>1 & tempdf$tmphispanic!=1]<-"M/O"
tempdf$race_ethnicity<-tempdf$race2

# Clean up by removing old variables
tempdf$race2<-NULL
tempdf$nvals_race<-NULL
tempdf$tmphispanic<-NULL
# Resort our result
tempdf<-tempdf[order(tempdf$sid,tempdf$school_year),]


## @knitr racewithinyearcompare,echo=FALSE
subset(tempdf[,c("sid","school_year","race_ethnicity")],sid==3 &school_year<2007 | sid==8552 &school_year<2007 | sid==11382 &school_year<2007)

subset(stuatt[,c("sid","school_year","race_ethnicity")],sid==3 &school_year<2007 | sid==8552 &school_year<2007 | sid==11382 &school_year<2007)


## @knitr collapsecleaneddata
stuatt<-tempdf
rm(tempdf)


## @knitr createnvalswithinyear,eval=FALSE
# Stupid hack workaround of ddply bug when running too many of these sequentially
ddply_race <- function(x, y,z){
    NewColName <- "race_ethnicity"
    z <- ddply(x, .(y,z), .fun = function(xx,col){
                             c(nvals_race = length(unique(xx[,col])))}, 
               NewColName)
    z$sid<-z$y
    z$school_year<-z$z
    z$y<-NULL
    z$z<-NULL
    return(z)
}

nvals<-ddply_race(stuatt,stuatt$sid,stuatt$school_year)
tempdf<-merge(stuatt,nvals)
tempdf$temp_ishispanic<-NA
tempdf$temp_ishispanic[tempdf$race_ethnicity=="H"& tempdf$nvals_race>1]<-1




## @knitr raceunique
head(stuatt[,c("sid","school_year","race_ethnicity")])


## @knitr racevarcleaning
tempdf<-ddply(stuatt,.(sid),summarize,var_temp=statamode(race_ethnicity),
              nvals=length(unique(race_ethnicity)),most_recent_year=max(school_year),
              most_recent_var=tail(race_ethnicity,1))

tempdf$race2[tempdf$var_temp!="."]<-tempdf$var_temp[tempdf$var_temp!="."]
tempdf$race2[tempdf$var_temp=="."]<-paste(tempdf$most_recent_var[tempdf$var_temp=="."])

tempdf<-merge(stuatt,tempdf)
head(tempdf[,c(1,2,4,14)],7)


## @knitr scripting, eval=FALSE
task1<-function(df,id,year,var){
  require(plyr)
  mdf<-eval(parse(text=paste('ddply(',df,',.(',id,'),summarize,
                             var_temp=statamode(',var,'),
             nvals=length(unique(',var,')),most_recent_year=max(',year,'),
             most_recent_var=tail(',var,',1))',sep="")))
  mdf$var2[mdf$var_temp!="."]<-mdf$var_temp[mdf$var_temp!="."]
  mdf$var2[mdf$var_temp=="."]<-
    as.character(mdf$most_recent_var[mdf$var_temp=="."])
  ndf<-eval(parse(text=paste('merge(',df,',mdf)',sep="")))
  rm(mdf)
  return(ndf)
}
# Note data must be sorted
tempdf<-task1(stuatt,stuatt$sid,stuatt$school_year,stuatt$race_ethnicity)


## @knitr session-info
print(sessionInfo(), locale=FALSE)


