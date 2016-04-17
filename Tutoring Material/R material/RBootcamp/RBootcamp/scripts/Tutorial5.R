
## @knitr setup, include=FALSE
# set global chunk options
opts_chunk$set(fig.path='figure/slides5-', cache.path='cache/slides5-',fig.width=8,fig.height=6,message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,size='tiny',dev='png')
library(eeptools)


## @knitr readschdata
load('data/midwest_schools.rda')
head(midsch[,1:12])


## @knitr datastruc
table(midsch$test_year,midsch$grade)
length(unique(midsch$district_id))
length(unique(midsch$school_id))


## @knitr datastruc2
table(midsch$subject,midsch$grade)


## @knitr diag1
library(ggplot2)
qplot(ss1,ss2,data=midsch,alpha=I(.07))+theme_dpi()+geom_smooth()+
  geom_smooth(method='lm',se=FALSE,color='purple')


## @knitr carsdata
data(mtcars) # load the data from R
head(mtcars)


## @knitr normtest
shapiro.test(mtcars$mpg)
shapiro.test(mtcars$hp)


## @knitr onewayttest
mean(mtcars$mpg)
t.test(mtcars$mpg,mu=18,alternative="greater")
t.test(mtcars$mpg,mu=22,alternative="less")


## @knitr twowaytest
t.test(mpg~am,data=mtcars)


## @knitr aspirindata
aspirin <- matrix(c(189,104,10845,10933),ncol=2,dimnames=list(c("Placebo","Aspirin"),
                                                              c("MI","No MI")))
aspirin


## @knitr chi-squaretest
chisq.test(aspirin,correct=FALSE)
fisher.test(aspirin)


## @knitr uniq
nrow(unique(midsch[,c(3,4,14)]))


## @knitr drawsubset
midsch_sub<-subset(midsch,midsch$grade==5 &
                   midsch$test_year==2011 &
                   midsch$subject=='math')


## @knitr basicreg
ss_mod<-lm(ss2~ss1,data=midsch_sub)
summary(ss_mod)


## @knitr exploremod
objects(ss_mod)


## @knitr diagn
qplot(n2,ss2-ss1,data=midsch,alpha=I(.1))+theme_dpi()+geom_smooth()


## @knitr basicregn
ssN1_mod<-lm(ss2~ss1+n1,data=midsch_sub)
summary(ssN1_mod)
ssN2_mod<-lm(ss2~ss1+n2,data=midsch_sub)
summary(ssN2_mod)


## @knitr ftest
anova(ss_mod,ssN1_mod,ssN2_mod)
AIC(ssN2_mod)
AIC(ssN1_mod)


## @knitr regdiagreset
library(lmtest)
resettest(ss_mod,power=2:4)


## @knitr raintest
raintest(ss2~ss1,fraction=0.5,order.by=~ss1,data=midsch_sub)


## @knitr harvtest
harvtest(ss2~ss1,order.by=~ss1,data=midsch_sub)


## @knitr polyregression
ss_poly<-lm(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4),data=midsch_sub)
summary(ss_poly)


## @knitr polyanova
anova(ss_mod,ss_poly)


## @knitr testpolys
resettest(ss_poly,power=2:4)
raintest(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4),fraction=0.5,order.by=~ss1,data=midsch_sub)
harvtest(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4),order.by=~ss1,data=midsch_sub)


## @knitr polyn
ss_polyn<-lm(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4)+n2,data=midsch_sub)
anova(ss_mod,ssN2_mod,ss_poly,ss_polyn)


## @knitr testpolyns
resettest(ss_polyn,power=2:4)
raintest(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4)+n2,fraction=0.5,order.by=~ss1,data=midsch_sub)
harvtest(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4)+n2,order.by=~ss1,data=midsch_sub)


## @knitr quantileregression
library(quantreg)
ss_quant<-rq(ss2~ss1,tau=c(seq(.1,.9,.1)),data=midsch_sub)
plot(summary(ss_quant,se='boot',method='wild'))


## @knitr quantileregression2
ss_quant2<-rq(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4)+n2,tau=c(seq(.1,.9,.1)),data=midsch_sub)
plot(summary(ss_quant2,se='boot',method='wild'))


## @knitr betterquantileplot
ss_quant3<-rq(ss2~ss1,tau=-1,data=midsch_sub)
qplot(ss_quant3$sol[1,],ss_quant3$sol[5,],geom='line',main='Continuous Quantiles')+
  theme_dpi()+xlab('Quantile')+ylab(expression(beta))+geom_hline(yintercept=coef(summary(ss_mod))[2,1])+
  geom_hline(yintercept=coef(summary(ss_mod))[2,1]+(2*coef(summary(ss_mod))[2,2]),linetype=3)+
  geom_hline(yintercept=coef(summary(ss_mod))[2,1]-(2*coef(summary(ss_mod))[2,2]),linetype=3)


## @knitr betterquantileplot2
ss_quant4<-rq(ss2~ss1+I(ss1^2)+I(ss1^3)+I(ss1^4)+n2,tau=-1,data=midsch_sub)
qplot(ss_quant4$sol[1,],ss_quant4$sol[5,],geom='line',main='Continuous Quantiles')+
  theme_dpi()+xlab('Quantile')+ylab(expression(beta))+geom_hline(yintercept=coef(summary(ss_mod))[2,1])+
  geom_hline(yintercept=coef(summary(ss_mod))[2,1]+(2*coef(summary(ss_mod))[2,2]),linetype=3)+
  geom_hline(yintercept=coef(summary(ss_mod))[2,1]-(2*coef(summary(ss_mod))[2,2]),linetype=3)


## @knitr mods
library(plyr)
midsch$id<-interaction(midsch$test_year,midsch$grade,midsch$subject)
mods<-dlply(midsch,.(id),lm,formula=ss2 ~ ss1)
objects(mods)[1:10]


## @knitr resettest
mytest<-llply(mods,function(x) resettest(x,power=2:4))
mytest[[1]]
mytest[[2]]


## @knitr residplot1
a1<-qplot(id,residmean,
      data=ddply(midsch,.(id),summarize,residmean=mean(residuals)),
      geom='bar',main='Provided Residuals')+
        theme_dpi()+opts(axis.text.x=theme_blank(),axis.ticks=theme_blank())+
        ylab('Mean of Residuals')+
        xlab('Model')+geom_text(aes(x=12,y=0.3),label='SD of Residuals = 9')

a2<-qplot(id,V1,data=ldply(mods,function(x) mean(x$residuals)),
          geom='bar',main='Replication Models')+
        theme_dpi()+opts(axis.text.x=theme_blank(),axis.ticks=theme_blank())+
        ylab('Mean of Residuals')+
        xlab('Model')+geom_text(aes(x=7,y=0.3),
        label=paste("SD =",round(mean(ldply(mods,function(x) sd(x$residuals))$V1),2)))
grid.arrange(a1,a2,main="Comparing Replication and Provided Residual Means by Model")


## @knitr residplot
qplot(residuals,data=midsch,geom='density')+
  stat_function(fun = dnorm, aes(colour = 'Normal'))+
  geom_histogram(aes(y = ..density..), alpha = I(0.4)) +
  geom_line(aes(y = ..density.., colour = 'Empirical'), stat = 'density') +
  scale_colour_manual(name = 'Density', values = c('red', 'blue')) + 
  opts(legend.position = c(0.85, 0.85))+theme_dpi()


## @knitr perfectmodel
b<-2*rnorm(5000)
c<-b+runif(5000)
dem<-lm(c~b)

a1<-qplot(midsch$ss1,abs(midsch$residuals),
  main='Residual Plot of Replication Data',geom='point',alpha=I(0.1))+
  geom_smooth(method='lm',se=TRUE)+xlab('SS1')+ylab('Residuals')+
  geom_smooth(se=FALSE)+
    ylim(c(0,50))+theme_dpi()

a2<-qplot(b,abs(lm(c~b)$residuals),main='Well Specified OLS',alpha=I(.3))+theme_dpi()+geom_smooth()

grid.arrange(a1,a2,ncol=2)


## @knitr bpgqtest
bptest(ss_mod)
gqtest(ss_mod)


## @knitr fortifymethod
damodel<-fortify(ss_mod)
summary(damodel)           


## @knitr simulatedgoodmodel
a<-rnorm(500)
b<-runif(500)
c<-a+b
goodsim<-lm(c~a)
goodsim_a<-fortify(goodsim)
qplot(c,.hat,data=goodsim_a)+theme_dpi()+geom_smooth(se=FALSE)


## @knitr nonsim
qplot(ss2,.hat,data=damodel)+theme_dpi()+geom_smooth(se=FALSE)


## @knitr comparisonplot,out.width='800px',out.height='570px'
a<-qplot(c,.hat,data=goodsim_a)+theme_dpi()+geom_smooth(se=FALSE)
b<-qplot(ss2,.hat,data=damodel)+theme_dpi()+geom_smooth(se=FALSE)
grid.arrange(a,b,ncol=2)


## @knitr diagnosticplot
qplot(ss2,.hat,data=damodel)+theme_dpi()+geom_smooth(se=FALSE)+geom_hline(yintercept=3*mean(damodel$.hat),color=I("red"),size=I(1.1))


## @knitr influentialobs
infobs<-which(apply(influence.measures(ss_mod)$is.inf,1,any))
ssdata<-cbind(fortify(ss_mod),midsch_sub)
ssdata$id3<-paste(ssdata$district_id,ssdata$school_id,sep='.')
noinf<-lm(ss2~ss1,data=midsch_sub[-infobs,])
noinff<-fortify(noinf)


## @knitr infobsplot

qplot(ss1,ss2,data=ssdata,alpha=I(.5))+
   geom_line(aes(ss1,.fitted,group=1),data=ssdata,size=I(1.02))+
   geom_line(aes(x=ss1,y=.fitted,group=1),data=noinff,linetype=6,size=1.1,
             color='blue')+
   theme_dpi()+xlab('SS1')+ylab('Y')



## @knitr megamodel2
my_megamod<-lm(ss2~ss1+grade+test_year+subject,data=midsch)
summary(my_megamod)


## @knitr megamodel3
my_megamod2<-lm(ss2~ss1+as.factor(grade)+
  as.factor(test_year)+subject,data=midsch)
summary(my_megamod2)


## @knitr anovamega
anova(my_megamod,my_megamod2)


## @knitr modelinteraction
megamodeli<-lm(ss2~ss1+as.factor(grade)+subject*factor(test_year),data=midsch)
summary(megamodeli)


## @knitr modelinteraction2
megamodelii<-lm(ss2~ss1+as.factor(grade)+subject:factor(test_year),data=midsch)
summary(megamodelii)


## @knitr meagnova
anova(my_megamod,my_megamod2,megamodelii,megamodeli)


## @knitr breakrep
badidea<-lm(ss2~ss1+as.factor(grade)+
  as.factor(test_year)+subject+factor(district_id),data=midsch)
summary(badidea)


## @knitr sandwiching
library(sandwich)
vcovHC(ss_mod,type="HC4")


## @knitr glsfunction,eval=FALSE
gls.correct <-
function(lm){
  require(sandwich)
  rob<-t(sapply(c('const','HC0','HC1','HC2','HC3','HC4','HC5'),function (x)
    sqrt(diag(vcovHC(lm,type=x)))))
  a<-c(NA,(rob[2,1]-rob[1,1])/rob[1,1],(rob[3,1]-rob[1,1])/rob[1,1],
       (rob[4,1]-rob[1,1])/rob[1,1],(rob[5,1]-rob[1,1])/rob[1,1],
       (rob[6,1]-rob[1,1])/rob[1,1],(rob[7,1]-rob[1,1])/rob[1,1])
  rob<-cbind(rob,round(a*100,2))
  a<-c(NA,(rob[2,2]-rob[1,2])/rob[1,2],(rob[3,2]-rob[1,2])/rob[1,2],
       (rob[4,2]-rob[1,2])/rob[1,2],(rob[5,2]-rob[1,2])/rob[1,2],
       (rob[6,2]-rob[1,2])/rob[1,2],(rob[7,2]-rob[1,2])/rob[1,2])
  rob<-cbind(rob,round(a*100,2))
  rob<-as.data.frame(rob)
  names(rob)<-c('alpha','beta','alpha.pchange','beta.pchange')
  rob$id2<-rownames(rob)
  rob
}


## @knitr glscorrect
gls.correct(ss_mod)


## @knitr substantiveeffect,echo=FALSE
a<-coef(ssN1_mod)
xdat<-seq(min(midsch_sub$ss1),max(midsch_sub$ss1),length.out=20)
ydat<-xdat*a[2]+a[1]+(median(midsch_sub$n1)*a[3])
ydatsmall<-xdat*a[2]+a[1]+(min(midsch_sub$n1)*a[3])
ydatbig<-xdat*a[2]+a[1]+(max(midsch_sub$n1)*a[3])

myx<-rep(xdat,3)
myy<-c(ydat,ydatsmall,ydatbig)
mymod<-rep(c("mean","low","high"),each=length(xdat))

newdat<-data.frame(x=myx,y=myy,type=mymod)

ggplot(newdat,aes(x=x,y=y,color=mymod))+geom_line(aes(linetype=mymod),size=I(.8))+coord_cartesian()+theme_dpi()


## @knitr codeforlineplots,eval=FALSE
a<-coef(ssN1_mod)
xdat<-seq(min(midsch_sub$ss1),max(midsch_sub$ss1),length.out=20)
ydat<-xdat*a[2]+a[1]+(median(midsch_sub$n1)*a[3])
ydatsmall<-xdat*a[2]+a[1]+(min(midsch_sub$n1)*a[3])
ydatbig<-xdat*a[2]+a[1]+(max(midsch_sub$n1)*a[3])

myx<-rep(xdat,3)
myy<-c(ydat,ydatsmall,ydatbig)
mymod<-rep(c("mean","low","high"),each=length(xdat))

newdat<-data.frame(x=myx,y=myy,type=mymod)

ggplot(newdat,aes(x=x,y=y,color=mymod))+geom_line(aes(linetype=mymod),size=I(.8))+coord_cartesian()+theme_dpi()


## @knitr coefplots,fig.width=12,fig.height=6,out.width='600px',out.height='300px'
b<-sqrt(diag(vcov(ssN1_mod)))
mycoef<-data.frame(var=names(b),y=a,se=b)

ggplot(mycoef[2:3,],aes(x=var,y=y,ymin=y-2*se,ymax=y+2*se))+geom_pointrange()+theme_dpi()+geom_hline(yintercept=0,size=I(1.1),color=I('red'))



## @knitr session-info
print(sessionInfo(), locale=FALSE)


