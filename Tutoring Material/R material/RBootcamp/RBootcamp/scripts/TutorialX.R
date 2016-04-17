
## @knitr loading, include=FALSE
library(ggplot2)
library(eeptools)
opts_knit$get(animation.fun = hook_scianimator)
opts_chunk$set(fig.path='figure/slidesX-', cache.path='cache/slidesX-',fig.width=12,fig.height=9,message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,size='tiny',dev='png',out.width='650px',out.height='370px')


## @knitr barplot,echo=FALSE
qplot(factor(cyl),data=mtcars)+
  labs(x='cylinder',title='Car models by Cylinder Count')+theme_dpi()


## @knitr diamondplot,echo=FALSE
data(diamonds)
qplot(factor(cut),data=diamonds)+labs(x='Cut',title='Diamonds by Cut Quality')+theme_dpi()


## @knitr diamondplot2,echo=FALSE
qplot(factor(color),data=diamonds)+
  labs(x='Color',title='Diamonds by Color and Clarity')+
  facet_wrap(~clarity,nrow=2)+theme_dpi()


## @knitr diamondplot3,echo=FALSE
qplot(carat,price,data=diamonds,color=color)+geom_smooth(aes(group=1))+theme_dpi()


## @knitr centraltend,echo=FALSE
qplot(hwy,data=mpg,geom='density')+geom_vline(xintercept=median(mpg$hwy),color=I("blue"),size=I(1.1))+
  geom_vline(xintercept=mean(mpg$hwy),color=I("gold"),size=I(1.1))+
  geom_vline(xintercept=26,color=I("orange"),size=I(1.1))+
  geom_text(aes(x=median(mpg$hwy)+1.5,y=0.08,label="Median"),size=I(4.5))+
  geom_text(aes(x=mean(mpg$hwy)-1.5,y=0.06,label="Mean"),size=I(4.5))+
  geom_text(aes(x=26+1.5,y=0.05,label="Mode"),size=I(4.5))+theme_dpi()


## @knitr mpgtable,results='asis'
library(xtable)
print(xtable(table(mpg$hwy)),type="html")


## @knitr bellcurve
qplot(rnorm(3000),geom='density',adjust=2)+theme_dpi()


## @knitr uniform
qplot(runif(100000,min=-5,max=5),geom='bar')+theme_dpi()


## @knitr poisson
qplot(rpois(3000,lambda=3),geom='density',adjust=2)+theme_dpi()


## @knitr binom
qplot(rbinom(3000,1,.5),geom='bar')+theme_dpi()



## @knitr weibull
qplot(rweibull(3000,shape=18,scale=1),geom='density')+theme_dpi()



## @knitr sophcorr,echo=FALSE
mydat<-data.frame(x=runif(600),y=rnorm(600),z=sample(c("A","B","C"),600,replace=TRUE))
mydat$y[mydat$z=="C"]<-mydat$y[mydat$z=="C"]+2
mydat$y[mydat$z=="B"]<-mydat$x[mydat$z=="B"] * 
  runif(length(mydat$x[mydat$z=="B"]),1,3)+rnorm(length(mydat$x[mydat$z=="B"])) 

qplot(x,y,data=mydat)+facet_wrap(~z)+theme_dpi()+geom_smooth(se=FALSE,method='lm')


## @knitr classicweight,echo=TRUE
wt<-c(190.5,189,195.5,187,191,190.4,186,183,193,188)
t.test(wt,mu=187,alternative="two.sided")


## @knitr weightrepeat,echo=FALSE
t.test(wt,mu=187,alternative="two.sided")


## @knitr session-info
print(sessionInfo(), locale=FALSE)


