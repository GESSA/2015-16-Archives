
## @knitr , eval=FALSE,echo=TRUE,tidy=FALSE
install_new<-function(mypkg){
  if (mypkg %in% installed.packages()) cat("Package already installed")
  else{cat("Package not found, so installing with dependencies... /n
           Press CTRL C to abort.")
    Sys.sleep(5)
    install.packages(mypkg,repos="http://cran.wustl.edu/")
}
}

install_new('plyr')
install_new('lmtest')
install_new('ggplot2')
install_new('gridExtra')
install_new('stringr')
install_new('knitr')
install_new('quantreg')
install_new('zoo')
install_new('xtable')
install_new('lme4')
install_new('caret')



