
## @knitr eval=FALSE,echo=TRUE
# You can find and install packages within R
install.packages('foo') # Name must be in quotes
install.packages(c('foo','foo1','foo2'))
# Packages get updated FREQUENTLY
update.packages() # Gonna update them all


## @knitr missing
a<-c(1,2,3)  # a is a vector with three elements
# Ask R for element 4
print(a[4])


## @knitr nulldata
a<-c(a,NULL) # Append NULL onto a
print(a)
# Notice no change
a<-c(a,NA)
print(a)


## @knitr nan, warning=TRUE
b<-1
b<-sqrt(-b)
print(b)
pi/0


## @knitr readdata, eval=FALSE
# Set working directory to the tutorial directory
# In RStudio can do this in "Tools" tab
setwd('~/GitHub/r_tutorial_ed')
#Load some data
df<-read.csv('data/smalldata.csv')
# Note if we don't assign data to 'df'
# R just prints contents of table


## @knitr checkresults,echo=FALSE
# Let's see what object types 
# R assigned to our dataset
str(df[27:32])


## @knitr dim
  dim(df)


## @knitr summary
  summary(df[,1:5])


## @knitr names
  names(df)


## @knitr attributes
  names(attributes(df))
  class(df)


## @knitr rodbc, eval=FALSE
library(RODBC) # interface driver for R
channel<-odbcConnect("Mydatabase.location",uid="useR",pwd="secret") 
# establish connection
# we can do multiple connections in the same R session
#
# WARNING: credentials stored in plain text unless you do some magic
#
table_list<-sqltables(channel,schema="My_DB")
#
# Get a list of tables in the connection
#
colnames(sqlFetch(channel,'My_DB.TABLE_NAME',max=1)) 
#
# get the column names of a table
#
datapull<-sqlQuery(channel,"SELECT DATA1, DATA2, DATA3 FROM My_DB.TABLE_NAME") 
#
# execute some SQLquery, can paste any SQLquery as a string into this space
#


## @knitr munging
random<-sample(unique(df$stuid),100)
random2<-sample(unique(df$stuid),120)
messdf<-df
messdf$readSS[messdf$stuid %in% random]<-NA
messdf$mathSS[messdf$stuid %in% random2]<-NA


## @knitr summarym
summary(messdf[,c('stuid','readSS','mathSS')])
nrow(messdf[!complete.cases(messdf),]) # number of rows with missing data


## @knitr naomit
cleandf<-na.omit(messdf)
nrow(cleandf)


## @knitr datafirstcut
dim(messdf)
str(messdf[,18:26])


## @knitr datafirstcut2
names(messdf)


## @knitr checkunique
length(unique(messdf$stuid))
length(unique(messdf$schid))
length(unique(messdf$dist))


## @knitr checkcoding
unique(messdf$grade)
unique(messdf$econ)
unique(messdf$race)
unique(messdf$disab)


## @knitr session-info
print(sessionInfo(), locale=FALSE)


