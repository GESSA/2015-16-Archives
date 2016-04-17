
## @knitr setuph, include=FALSE
# set global chunk options
opts_knit$set(animation.fun=hook_r2swf)
opts_chunk$set(fig.path='figure/slides8-', cache.path='cache/slides8-',fig.width=12,fig.height=9,message=FALSE,error=FALSE,warning=FALSE,echo=TRUE,size='tiny',dev='png',out.width='700px',out.height='500px',cache=TRUE)
library(eeptools)
library(ggplot2)
load('data/smalldata.rda')


## @knitr writeaforloop
# Loop to calculate number of students per grade

nstudents<-rep(NA,6)
for (i in unique(df$grade)){
  nstudents[[i-2]]<-length(df$stuid[df$grade==i])
}
nstudents
summary(factor(df$grade))


## @knitr timingloops
A = matrix(as.numeric(1:100000))

system.time({
    Sum = 0
    for (i in seq_along(A)) {
        Sum = Sum + A[[i]]
    }
    Sum
})

system.time({
  sum(A)
  })
rm(A)


## @knitr reviewingfunction
print(mean) #bytecode, we can't see it
print(order)


## @knitr writefunction,eval=FALSE
defac<-function(x){ # assign function a name, and list its arguments
  x<-as.character(x) # what does function do?
  x                  # last line is output of function
}

a<-factor(letters)
summary(a)
summary(defac(a))
summary(as.character(a))


## @knitr declassfunction
extractN<-function(x){
  x<-suppressWarnings(as.numeric(x))
  #ignore warnings because we don't care
  x<-x[!is.na(x)]
  x
}
foo<-c(1,4,3,NA,5,60,NA)
extractN(foo)
A<-extractN(foo)


## @knitr lme4mod
library(lme4)
mymod_me<-lmer(readSS~factor(grade)+factor(race)+female+disab+ell+(1|dist)+(1|stuid),data=df)
print(mymod_me,correlation=FALSE)


## @knitr modelcomp,fig.show='asis',dev='png',out.width='700px',out.height='500px'
mymod<-lm(readSS~factor(grade)+factor(race)+female+disab+ell,data=df)

qplot(readSS,predict(mymod),data=df,alpha=I(.3),color=I('blue'))+geom_point(aes(x=df$readSS,y=fitted(mymod_me)),alpha=I(.4),color='dark green')+
  theme_dpi()+xlab('Observed')+ylab('Predicted')+
  geom_text(aes(x=370,y=700),label='Green is Results of the \n Mixed Model')


## @knitr caretscript,echo=TRUE,eval=TRUE
library(caret)
# Set aside test set
testset<-sample(unique(df$stuid),500)
df$case<-0
df$case[df$stuid %in% testset]<-1
# Draw a training set of data (random subset of students)
training<-subset(df,case==0)
testing<-subset(df,case==1)

training<-training[,c(3,6:16,21,22,28,29,30)] # subset vars
trainX<-training[,1:15]
refac<-function(x) as.factor(as.character(x))
trainX$stuid<-refac(trainX$stuid)
trainX$dist<-refac(trainX$dist)
trainX$year<-refac(trainX$year)

# Parameters
ctrl <- trainControl(method = "repeatedcv", number=7,repeats=3,
                     summaryFunction = defaultSummary)
# Search grid
grid<-expand.grid(.interaction.depth=seq(2,6,by=1),
                  .n.trees=seq(200,700,by=100),
                  .shrinkage=c(0.05,0.1))
# Boosted tree search
gbmTune<-train(x=trainX,
               y=training$mathSS,
               method="gbm",
               metric="RMSE",
               trControl=ctrl,
               tuneGrid=grid,
               verbose=FALSE)

#gbmPred<-predict(gbmTune,testing[,names(trainX)])



## @knitr gbmplot,out.width='700px',out.height='500px'
plot(gbmTune)


## @knitr parallelwindows,eval=TRUE,include=FALSE
xint <- c(-1,2)
yint <- c(-1,2)
func <- function(x,y) x^3-3*x + y^3-3*y
g <- expand.grid(x = seq(xint[1],xint[2],0.1), y = seq(yint[1],yint[2],0.1))
g$z <- func(g$x,g$y)

# Dumb for loop
integLoop <- function(func, xint, yint, n)
 {
 erg <- 0
 # interval sizes
 xincr <- ( xint[2]-xint[1] ) / n
 yincr <- ( yint[2]-yint[1] ) / n
 for(xi in seq(xint[1],xint[2], length.out=n)){
 for(yi in seq(yint[1],yint[2], length.out=n)){
 # Calculating one rectangular box
 box <- func(xi, yi) * xincr * yincr
 # Summarizing
 erg <- erg + box
  }
  }
 return(erg)
}

# Vectorized 

integVec <- function(func, xint, yint, n)
 {
 xincr <- ( xint[2]-xint[1] ) / n
 yincr <- ( yint[2]-yint[1] ) / n
 # using vectors instead of loops
 erg <- sum( func( seq(xint[1],xint[2], length.out=n),
 seq(yint[1],yint[2], length.out=n) ) ) * xincr * yincr * n
 return(erg)
 }

# Using Apply

 integApply <- function (func, xint, yint, n)
 {
 applyfunc <- function(xrange, xint, yint, n, func)
 {
 # calculates for every x interval the complete volume
 yrange <- seq(yint[1],yint[2], length.out=n)
 xincr <- ( xint[2]-xint[1] ) / n
 yincr <- ( yint[2]-yint[1] ) / n
 erg <- sum( sapply(xrange, function(x) sum( func(x,yrange) )) ) * xincr * yincr
 return(erg)
 }
 xrange <- seq(xint[1],xint[2],length.out=n)
 erg <- sapply(xrange, applyfunc, xint, yint, n, func)
 return( sum(erg) )
 }

integSnow <- function(cluster, func, xint, yint, n)
 {
 nslaves <- length(cluster)
 erg <- clusterApplyLB(cluster, 1:nslaves, slavefunc, nslaves, xint, yint, n, func)
 return( sum(unlist(erg)) )
}

# Parallel in Snow
integSnow <- function(cluster, func, xint, yint, n)
 {
 nslaves <- length(cluster)
 erg <- clusterApplyLB(cluster, 1:nslaves, slavefunc, nslaves, xint, yint, n, func)
 return( sum(unlist(erg)) )
 }


slavefunc<- function(id, nslaves, xint, yint, n, func){
 xrange <- seq(xint[1],xint[2],length.out=n)[seq(id,n,nslaves)]
 yrange <- seq(yint[1],yint[2], length.out=n)
 xincr <- ( xint[2]-xint[1] ) / n
 yincr <- ( yint[2]-yint[1] ) / n
 erg <- sapply(xrange, function(x)sum( func(x,yrange ) ))* xincr * yincr
 return( sum(erg) )
 }



## @knitr parallelperformancetest, echo=TRUE
n<-10000
rep<-5
#tLoop <- replicate(rep, system.time( integLoop(func, xint, yint, n) ))
#summary(tLoop[3,])
tVec <- replicate(rep, system.time( integVec(func, xint, yint, n) ))
summary(tVec[3,])
tApply <- replicate(rep, system.time( integApply(func, xint, yint, n) ))
summary(tApply[3,])

# 2 Core Cluster
library(snow)
c1<-makeCluster(c("localhost","localhost"),type="SOCK")
tSnow1 <- replicate(rep, system.time( integSnow(c1, func, xint, yint, n) ))
summary(tSnow1[3])
stopCluster(c1)



## @knitr anisetup,include=FALSE
x<-rnorm(10)
p<-ggplot()+geom_density(aes(x=x,color=length(x)))+geom_vline(aes(xintercept=mean(x)),color=I('red'),alpha=I(0.2))+scale_color_gradient(limits=c(10,30))
p<-p+theme_dpi()+xlim(c(-4,4))+ylim(c(0,.5))+coord_cartesian()


## @knitr animationtest,echo=FALSE,fig.show='animate',dev='png',out.width='700px',out.height='500px'
for (i in 10:30){
  x<-rnorm(i)
  print(
    ggplot()+geom_density(aes(x=x,color=length(x)))+scale_color_gradient(limits=c(10,30))+
    geom_vline(aes(xintercept=mean(x)),color=I('red'),alpha=I(0.3))+theme_dpi()
    )
}


## @knitr session-info
print(sessionInfo(), locale=FALSE)


