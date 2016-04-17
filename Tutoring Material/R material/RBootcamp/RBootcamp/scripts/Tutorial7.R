
## @knitr setup, include=FALSE
# set global chunk options
opts_chunk$set(fig.path='figure/slides7-', cache.path='cache/slides7-',fig.width=8,fig.height=6,message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,dev='svg')
#source('ggplot2themes.R')
load('data/smalldata.rda')
library(eeptools)


## @knitr tradeoff,dev='svg',echo=FALSE,out.height='400px',out.width='700px'
library(ggplot2)
pub<-c(1,12,17,20)
time<-c(1,4,10,15)
a<-qplot(time,pub)+geom_smooth(se=FALSE)+ylab('Quality')+xlab('Time')
a+geom_text(aes(x=4.8,y=11.5,label='R Markdown'))+
  geom_text(aes(x=2.5,y=2.3,label='copy and paste'))+
  geom_text(aes(x=10,y=16.2,label='knitr to PDF'))+
  geom_text(aes(x=14,y=18.2,label='Sweave +bibtex'))+opts(
    title='Quality v. Time Tradeoff in Exporting Information')+theme_dpi()


## @knitr dummyscript, echo=TRUE,eval=FALSE
#' This is some text
#' 

# + myplot, dev='svg',out.width='500px',out.height='400px'

library(ggplot2)
data(diamonds)
qplot(carat,price,data=diamonds,alpha=I(.3),color=clarity)

#' Diamond size is clearly related to price, but not in a linear fashion.
#'


## @knitr spinr,eval=FALSE
o<-spin("C:/Path/To/myscript.R",knit=FALSE)
knit2html(o,envir=new.env())


## @knitr scriptr2,eval=FALSE,echo=TRUE
#' This is some text that I want to explain
#' For example, this plot is important, let's look below

# + myplot, dev='svg',out.width='500px',out.height='400px',warning=FALSE,message=FALSE

library(ggplot2)
load('PATH/TO/MY/DATA.rda')
qplot(readSS,mathSS,data=df,alpha=I(.2))+geom_smooth()

#' There is not a linear relationship, but it sure is close.
#' Let's do some regression
#' 

test<-lm(mathSS~readSS+factor(grade),data=df)
summary(test)

#' It's all statistically significant


## @knitr spinr23, eval=FALSE,echo=TRUE
o<-spin("C:/Path/To/myscript2.R",knit=FALSE)
knit2html(o,envir=new.env())
# We specify that new environment is used to carry out the analysis, not the current environment


## @knitr stitching
## title: My Super Report ##
## Author: Mr. Data ##

# A plot and some text
library(ggplot2)
library(xtable)
load('PATH/TO/MY/DATA')
qplot(readSS,mathSS,data=df,alpha=I(.2))+geom_smooth()

# Now a linear model
test<-lm(mathSS~readSS+factor(grade),data=df)
summary(test)

# Ok!



## @knitr sdfafeaw, eval=FALSE,echo=TRUE
# Markdown
stitch('PATH/TO/MY/SCRIPT',system.file("misc","knitr-template.Rmd",package="knitr"))
knit2html("Path/To/My/Markdown.md")

# Direct 2 Html
stitch('PATH/TO/MY/SCRIPT',system.file("misc","knitr-template.html",package="knitr"))

# Direct to PDF
# Requires LaTeX
stitch('PATH/TO/MY/SCRIPT')



## @knitr ,tidy=FALSE,eval=FALSE,echo=TRUE
# Start .Rmd file on next line
My Super Report on Student Testing
------------------------------------
Dr. Debateman
==============

In this report I plan to show you all the results of student testing in Myoming.

#```{r chunksetup, include=FALSE} (remove # in actual document)
load("PATH/TO/MY/DATA.rda")
source("myscript.R")
library(ggplot2)
#```

The most important thing to look at is this plot:
#```{r plot1,dev='png',fig.width=9,fig.height=6}
qplot(readSS,mathSS,data=df)
#```

And my model output can be included a few ways because it is so great.
#```{r mystatmodel,results='markup'}
mymod<-lm(readSS~mathSS+factor(grade),data=df)
summary(mymod)
#```

#```{r mystatmodel2,results='asis'}
mymod<-lm(readSS~mathSS+factor(grade),data=df)
print(xtable(summary(mymod)),type='html')
#```

And because I am awesome, I am done.


## @knitr eval=FALSE
knit("PATH/TO/myscript.Rmd",envir=new.env())
knit2html("Path/To/Myscript.md")


## @knitr eval=FALSE,echo=TRUE
opts_chunk$set(fig.path='figure/slides7-', cache.path='cache/slides7-',fig.width=8,fig.height=6,message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,dev='svg')


## @knitr singlegraphicoutput,echo=TRUE,eval=FALSE
#PDF
pdf(file="PATH/TO/MYPLOT.PDF",width=10,heigh=8)
print(qplot(readSS,mathSS,data=df,alpha=I(.2)))
dev.off()
# PNG
png(file="PATH/TO/MYPLOT.png",width=1200,heigh=900)
print(qplot(readSS,mathSS,data=df,alpha=I(.2)))
dev.off()


## @knitr writedataout,eval=FALSE
write.csv(df,file='PATH/TO/MY.csv')
write.dta(df,file='PATH/TO/MY.dta')
# save in the R file
save(df,file='PATH/TO/MY.rda',compress='xz')


## @knitr uglytable
table(df$female,df$schid)


## @knitr xtableexamp1,results='asis',echo=FALSE
require(xtable)
print(xtable(table(df$ell,df$schid)),type='html')
print(xtable(as.table(cor(df[,26:30],df[,26:30]))),type='html')


## @knitr xtablecode,eval=FALSE,echo=TRUE
require(xtable)
print(xtable(table(df$ell,df$schid)),type='html')


## @knitr session-info
print(sessionInfo(), locale=FALSE)


