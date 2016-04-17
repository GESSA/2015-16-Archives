
## @knitr setuph, include=FALSE
# set global chunk options
opts_chunk$set(fig.path='figure/slides6-', cache.path='cache/slides6-',fig.width=12,fig.height=9,message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,size='tiny',dev='png',out.width='600px',out.height='350px')
library(eeptools)


## @knitr setup, message=FALSE,warning=FALSE,echo=FALSE,comment=FALSE
load('data/smalldata.rda')
dropbox_source<-function(myurl){
  require(stringr)
  s<-str_extract(myurl,"[/][a-z][/]\\d+[/][a-z]*.*")
  new_url<-paste("http://dl.dropbox.com",s,sep="")
  source(new_url)
}


## @knitr basehist
hist(df$readSS)


## @knitr basescatter,out.width='300px',out.height='200px'
plot(df$readSS,df$mathSS)


## @knitr scatterbaseline,out.width='300px',out.height='200px'
plot(df$readSS,df$mathSS)
lines(lowess(df$readSS~df$mathSS),col='red')


## @knitr plot1,out.height='325px'
library(ggplot2)
qplot(readSS,mathSS,data=df)


## @knitr ggplot2plottypes,echo=FALSE,out.width='850px',out.height='520px'
p1<-qplot(factor(grade),readSS,data=df,geom='boxplot')+theme_dpi(base_size=12)
p2<-qplot(readSS,data=df,geom='density')+theme_dpi(base_size=12)
p3<-qplot(readSS,data=df)+theme_dpi(base_size=12)
p4<-qplot(grade,readSS,data=df,geom='line',group=1,stat='quantile')+theme_dpi(base_size=12)
p5<-qplot(mathSS,readSS,data=df)+theme_dpi(base_size=12)
library(plyr)
df2<-ddply(df,.(schid),summarize,mean_math=mean(mathSS,na.rm=T))
p6<-qplot(factor(schid),mean_math,data=df2,geom='bar',stat='identity')+theme_dpi(base_size=12)
print(grid.arrange(p1,p2,p3,p4,p5,p6,nrow=2))


## @knitr ggplot2plottypesadv,echo=FALSE,out.width='850px',out.height='520px'
p1<-qplot(factor(grade),readSS,data=df,geom='boxplot')+theme_dpi(base_size=12)+ stat_summary(fun.data = "mean_cl_boot", colour = "red",size=(1.2))
p2<-qplot(readSS,data=df,geom='density',fill=race)+theme_dpi(base_size=12)+opts(legend.position='bottom')
p3<-qplot(readSS,data=df,fill=factor(female),position='stack')+theme_dpi(base_size=12)+opts(legend.position='bottom')
p4<-qplot(grade,readSS,data=df,geom='line',group=1,stat='quantile')+theme_dpi(base_size=12)+geom_jitter(alpha=(.2))
p5<-qplot(mathSS,readSS,data=df,alpha=I(.25))+theme_dpi(base_size=12)+stat_density2d(aes(color=factor(df$disab)),size=I(1.03))+opts(legend.position='bottom')
df2<-ddply(df,.(schid),summarize,mean_math=mean(mathSS,na.rm=T),sd_math=sd(mathSS,na.rm=T))
p6<-ggplot(df2,aes(x=factor(schid),y=mean_math,ymin=mean_math-2*sd_math,ymax=mean_math+2*sd_math))+geom_pointrange()+geom_errorbar(size=I(1.03),width=.25,color='grey40')+theme_dpi(base_size=12)
print(grid.arrange(p1,p2,p3,p4,p5,p6,nrow=2))


## @knitr smallscatter,out.width='300px',out.height='240px'
qplot(readSS,mathSS,data=df,alpha=I(.3))+theme_dpi()


## @knitr geomquiz,out.width='350px',out.height='260px'
qplot(mathSS,readSS,data=df)+theme_dpi()
qplot(mathSS,data=df)+theme_dpi()
qplot(factor(grade),mathSS,data=df,geom='line',group=stuid,alpha=I(.2))+theme_dpi()


## @knitr extended,out.height='240px'
ggplot(df,aes(x=readSS,y=mathSS))+geom_point()
# Identical to: qplot(readSS,mathSS,data=df)


## @knitr plot2,out.width='400px',out.height='300px'
data(mpg)
qplot(displ,cty,data=mpg)+theme_dpi()
qplot(displ,cty,data=mpg,size=cyl)+theme_dpi()
qplot(displ,cty,data=mpg,shape=drv,size=I(3))+theme_dpi()
qplot(displ,cty,data=mpg,color=class)+theme_dpi()


## @knitr racesizemapping
qplot(mathSS,readSS,data=df[1:100,],size=race,alpha=I(.8))+theme_dpi()


## @knitr proflvlcolor
df$proflvl2<-factor(df$proflvl,levels=c('advanced','basic','proficient','below basic'))
df$proflvl2<-ordered(df$proflvl2)
qplot(mathSS,readSS,data=df[1:100,],color=proflvl2,size=I(3))+scale_color_brewer(type='seq')+theme_dpi()


## @knitr badcontinuousmapping
qplot(factor(grade),readSS,data=df[1:100,],color=mathSS,geom='jitter',size=I(3.2))+theme_dpi()


## @knitr baddiscretemap
qplot(factor(grade),readSS,data=df[1:100,],color=dist,geom='jitter',size=I(3.2))+theme_dpi()


## @knitr scaleexample,echo=FALSE
p1<-qplot(factor(grade),mathSS,data=df,geom='jitter',alpha=I(.3))+theme_dpi(base_size=12)
p2<-qplot(factor(grade),mathSS,data=df,geom='jitter',alpha=I(.3))+scale_y_sqrt()+theme_dpi(base_size=12)
p3<-qplot(factor(grade),log2(mathSS),data=df,geom='jitter',alpha=I(.3))+theme_dpi(base_size=12)
p4<-qplot(grade,log2(mathSS),data=df,geom='jitter',alpha=I(.3))+
  scale_x_continuous(breaks=c(3,6,8),labels=c('young','middle','old'))+theme_dpi(base_size=12)
p5<-qplot(factor(grade),mathSS,data=df,geom='jitter',alpha=I(.3))+
  scale_y_reverse()+theme_dpi(base_size=12)
p6<-qplot(factor(grade),mathSS,data=df,geom='jitter',alpha=I(.3))+
  scale_y_continuous(breaks=c(250,400,600,700),
                     labels=c('minimal','basic','proficient','advanced'))+theme_dpi(base_size=12)
grid.arrange(p1,p2,p3,p4,p5,p6,nrow=2)


## @knitr smallfacets
qplot(readSS,mathSS,data=df)+facet_wrap(~grade)+theme_dpi(base_size=12)+
  geom_smooth(method='lm',se=FALSE,size=I(1.2))


## @knitr smallfacets2
qplot(readSS,mathSS,data=df)+facet_grid(ell~grade)+theme_dpi(base_size=12)+
  geom_smooth(method='lm',se=FALSE,size=I(1.2))


## @knitr strucplot
library(vcd)
df$proflvl<-factor(df$proflvl,levels=c("advanced","proficient","basic","below basic"))
a<-structable(proflvl~race,data=df)
mosaic(a,shade=TRUE)


## @knitr strucplot2
library(vcd)
df$proflvl<-factor(df$proflvl,levels=c("advanced","proficient","basic","below basic"))
a<-structable(female~race,data=df)
mosaic(a,shade=TRUE)


## @knitr ggplot2colors,echo=FALSE
library(gridExtra)
X <- c(1)
Y <- c(1)

DF <- as.data.frame(cbind(X,Y))
c.1 <-  ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))  + coord_flip()   +  theme(legend.position="none") + labs(x="", y="", title="One Colour") + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))

X <- c(1:2)
Y <- rep(1, length(X))
DF <- as.data.frame(cbind(X,Y))
c.2 <- ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))   + coord_flip()   +  theme(legend.position="none")   + labs(x="", y="", title="Two Colours")           + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))

X <- c(1:3)
Y <- rep(1, length(X))
DF <- as.data.frame(cbind(X,Y))
c.3 <- ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))  + coord_flip()   +  theme(legend.position="none")    + labs(x="", y="", title="Three Colours")     + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))

X <- c(1:4)
Y <- rep(1, length(X))
DF <- as.data.frame(cbind(X,Y))
c.4 <- ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))   + coord_flip()   +  theme(legend.position="none")+ labs(x="", y="", title="Four Colours")   + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))

X <- c(1:5)
Y <- rep(1, length(X))
DF <- as.data.frame(cbind(X,Y))
c.5 <- ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))   + coord_flip()   +  theme(legend.position="none")   + labs(x="", y="", title="Five Colours")    + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))

X <- c(1:6)
Y <- rep(1, length(X))
DF <- as.data.frame(cbind(X,Y))
c.6 <- ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))   + coord_flip()   +  theme(legend.position="none")  + labs(x="", y="", title="Six Colours")  + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))

X <- c(1:7)
Y <- rep(1, length(X))
DF <- as.data.frame(cbind(X,Y))
c.7 <- ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))   + coord_flip()   +  theme(legend.position="none")   + labs(x="", y="", title="Seven Colours")  + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))


X <- c(1:8)
Y <- rep(1, length(X))
DF <- as.data.frame(cbind(X,Y))
c.8 <- ggplot(data = DF) + geom_bar(aes(x = X, y = Y, fill = factor(X)))   + coord_flip()   +  theme(legend.position="none")  + labs(x="", y="", title="Eight Colours")   + scale_y_continuous(breaks=NULL, expand=c(0,0)) + scale_x_continuous(breaks=NULL, expand=c(0,0))

MfrowGG <- grid.arrange(c.1, c.2, c.3, c.4, c.5,
                         c.6, c.7, c.8, ncol=2)



## @knitr colorwheel,out.width='300px',out.height='240px',echo=FALSE
colwheel<-"https://dl.dropbox.com/u/1811289/colorwheel.R"
dropbox_source(colwheel)
col.wheel("magenta",nearby=2)
col.wheel("orange",nearby=2)
col.wheel("brown",nearby=2)


## @knitr premier,echo=FALSE,out.width='800px',out.height='520px'
library(grid)
p1<-qplot(readSS,..density..,data=df,fill=race,
      position='fill',geom='density')+scale_fill_brewer(
        type='qual',palette=2)

p2<-qplot(readSS,..fill..,data=df,fill=race,
      position='fill',geom='density')+scale_fill_brewer(
        type='qual',palette=2)+ylim(c(0,1))+theme_bw()+
          opts(legend.position='none',
               axis.text.x=theme_blank(),
               axis.text.y=theme_blank(),
               axis.ticks=theme_blank(),
               panel.margin=unit(0,"lines"))+ylab('')+
                 xlab('')

vp<-viewport(x=unit(.65,"npc"),y=unit(.73,"npc"),
             width=unit(.2,"npc"),height=unit(.2,"npc"))
print(p1)
print(p2,vp=vp)



## @knitr premiernoeval,eval=FALSE,tidy=FALSE
library(grid)
p1<-qplot(readSS,..density..,data=df,fill=race,
      position='fill',geom='density')+scale_fill_brewer(
        type='qual',palette=2)

p2<-qplot(readSS,..fill..,data=df,fill=race,
      position='fill',geom='density')+scale_fill_brewer(
        type='qual',palette=2)+ylim(c(0,1))+theme_bw()+
          opts(legend.position='none',
               axis.text.x=theme_blank(),
               axis.text.y=theme_blank(),
               axis.ticks=theme_blank(),
               panel.margin=unit(0,"lines"))+ylab('')+
                 xlab('')

vp<-viewport(x=unit(.65,"npc"),y=unit(.73,"npc"),
             width=unit(.2,"npc"),height=unit(.2,"npc"))
print(p1)
print(p2,vp=vp)



## @knitr session-info
print(sessionInfo(), locale=FALSE)


