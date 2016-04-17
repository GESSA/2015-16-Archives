
## @knitr , eval=FALSE,echo=TRUE,tidy=FALSE
install_new<-function(mypkg){
  if (mypkg %in% installed.packages()) cat("Package already installed")
  else{cat("Package not found, so installing with dependencies...\n 
           Press CTRL C to abort.")
    Sys.sleep(5)
    install.packages(mypkg,repos="http://cran.wustl.edu/")
}
}

install_new('plyr')
install_new('lmtest')
install_new('ggplot2')
install_new('gridExtra')
install_new('eeptools')
install_new('stringr')
install_new('knitr')
install_new('quantreg')
install_new('xtable')
install_new('lme4')
install_new('caret')



## @knitr eval=FALSE,echo=TRUE,tidy=FALSE
install.packages(c('plyr','lmtest','ggplot2','gridExtra','stringr',
                   'knitr','quantreg','xtable','lme4','eeptools','caret'),
                 repos="http://cran.wustl.edu/")


## @knitr eval=FALSE,echo=TRUE
library(lmtest)
example(gqtest)


## @knitr eval=TRUE,echo=FALSE
library(lmtest)
example(gqtest)


## @knitr echo=TRUE,eval=FALSE
library(ggplot2)
y<-rt(200,df=5)
qplot(sample=y,stat="qq")


## @knitr ,echo=TRUE,fig.width=9,fig.height=6

library(ggplot2)
y<-rt(200,df=5)
qplot(sample=y,stat="qq")


## @knitr ,echo=TRUE,eval=FALSE
options(repos=c(RStudio='http://rstudio.org/_packages', getOption('repos')))
install.packages('shiny')


## @knitr echo=TRUE,eval=FALSE
library(shiny)
runExample("06_tabsets")


