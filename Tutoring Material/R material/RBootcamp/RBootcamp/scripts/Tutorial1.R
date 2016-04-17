
## @knitr setup, include=FALSE
# set global chunk options
opts_chunk$set(fig.path='figure/slides-', cache.path='cache/slides-', cache=TRUE,
               comment=NA)
# upload images automatically
#opts_knit$set(upload.fun = imgur_upload)


## @knitr echo=TRUE,error=TRUE
foo<-c(1,"b",5,7,0)
bar<-c(1,2,3,4,5)
foo+bar


## @knitr dataframeintro,echo=TRUE,results='hide'
data(mtcars)
mtcars


## @knitr dataframeintro2,echo=FALSE,results='markup'
mtcars[1:8,]


## @knitr computing,echo=TRUE,results='markup'
2+2 # add numbers
2*pi #multiply by a constant
7+runif(1,min=0,max=1) #add a random variable
4^4 # powers
sqrt(4^4) # functions


## @knitr arithmetic
2+2
2/2
2*2
2^2
2==2
23 %/% 2 
23 %% 2


## @knitr 
foo<-3
foo


## @knitr 
1:10
# it increments by one
a<-100:120
a


## @knitr poundsigns,eval=FALSE,echo=TRUE,tidy=FALSE
# Something I want to keep from R
# Like my secret from the R engine
# Maybe intended for a human and not the computer
# Like: Look at this cool plot!

myplot(readSS,mathSS,data=df)


## @knitr 
x<-5 #store a variable with <-
x    #print the variable
z<-3 
ls() #list all variables
ls.str() #list and describe variables
rm(x)    # delete a variable
ls()


## @knitr 
a<-3
A<-4
print(c(a,A))


## @knitr 
A<-c(3,4)
print(A)


## @knitr language
a<-runif(100) # Generate 100 random numbers
b<-runif(100) # 100 more
c<-NULL       # Setup for loop (declare variables)
for(i in 1:100){  # Loop just like in Java or C
c[i]<-a[i]*b[i]
}
d<-a*b
identical(c,d) # Test equality


## @knitr eval=TRUE,echo=FALSE
load("data/smalldata.rda")


## @knitr 
summary(df[,28:31]) #summary look at df object
summary(df$readSS) #summary of a single column


## @knitr graphics1,message=FALSE,dev='svg',fig.cap='Student Test Scores', fig.width=7.8, fig.height=4.5,tidy=FALSE,warning=FALSE
library(ggplot2) # Load graphics Package
library(eeptools)
qplot(readSS,mathSS,data=df,geom='point',alpha=I(0.3))+theme_dpi()+
  opts(title='Test Score Relationship')+
  geom_smooth()


## @knitr 
length(unique(df$school))
length(unique(df$stuid))
uniqstu<-length(unique(df$stuid))
uniqstu


## @knitr vectorcomp
big<-c(9,12,15,25)
small<-c(9,3,4,2)
# Give us a nice vector of logical values
big>small
big=small
# Oops--don't do this, reassigns big to small
print(big)
print(small)


## @knitr brackets
big<-c(9,12,15,25)
big[big==small]
# Returns values where the logical vector is true
big[big>small]
big[big<small] # Returns an empty set


## @knitr specialoperand
big<-c(9,12,15,25)
small<-c(9,12,15,25,9,1,3)
big[small %in% big]


## @knitr operand2
big[big %in% small]


## @knitr vectorlogic
foo<-c('a',NA,4,9,8.7)
!is.na(foo) # Returns TRUE for non-NA
class(foo)
a<-foo[!is.na(foo)]
a
class(a)


## @knitr vectorlogic2
zap<-c(1,4,8,2,9,11)
zap[zap>2 | zap<8]
zap[zap>2 & zap<8]


## @knitr 
is.numeric(A)
class(A)
print(A)


## @knitr 
b<-c('one','two','three')
print(b)
is.numeric(b)


## @knitr 
c<-c(TRUE,TRUE,TRUE,FALSE,FALSE,TRUE)
is.numeric(c)
is.character(c)
is.logical(c) # Results in a logical value


## @knitr class
class(A)
class(b)
class(c)


## @knitr fac
myfac<-factor(c("basic","proficient","advanced","minimal"))
class(myfac)
myfac # What order are the factors in?


## @knitr orderedfac
myfac_o<-ordered(myfac,levels=c("minimal","basic","proficient","advanced"))
myfac_o
summary(myfac_o)


## @knitr fac2
class(myfac_o)
unclass(myfac_o)
defac<-unclass(myfac_o)
defac


## @knitr fac2.1,eval=FALSE,echo=TRUE
# From the eeptools package
defac<-function(x){
  x<-as.character(x)
  x
}


## @knitr fac3
defac(myfac_o)
defac<-defac(myfac_o)
defac


## @knitr numericfac
myfac_o
as.numeric(myfac_o)


## @knitr numericfacwrong
myfac
as.numeric(myfac)


## @knitr dates
mydate<-as.Date("7/20/2012",format="%m/%d/%Y")
# Input is a character string and a parser
class(mydate) # this is date
weekdays(mydate) # what day of the week is it?
mydate+30 # Operate on dates


## @knitr moredates1
# We can parse other formats of dates
mydate2<-as.Date("8-5-1988",format="%d-%m-%Y") 
mydate2

mydate-mydate2
# Can add and subtract two date objects


## @knitr moredates
as.numeric(mydate) # days since 1-1-1970
as.Date(56,origin="2013-4-29") # we can set our own origin


## @knitr linmod
b<-rnorm(5000)
c<-runif(5000)
a<-b+c
mymod<-lm(a~b)
class(mymod)


## @knitr vectors
print(1)
# The 1 in braces means this element is a vector of length 1
print("This tutorial is awesome")
# This is a vector of length 1 consisting of a single "string of characters"


## @knitr vectors2
print(LETTERS) 
# This vector has 26 character elements
print(LETTERS[6])
# The sixth element of this vector has length 1
length(LETTERS[6])
# The length of that element is a number with length 1


## @knitr matrix
mymat<-matrix(1:36,nrow=6,ncol=6)
rownames(mymat)<-LETTERS[1:6]
colnames(mymat)<-LETTERS[7:12]
class(mymat)


## @knitr matrix2
rownames(mymat)
colnames(mymat)
mymat


## @knitr matrix3
dim(mymat) # We have 6 rows and 6 columns
myvec<-c(5,3,5,6,1,2)
length(myvec) # What happens when you do dim(myvec)?
newmat<-cbind(mymat,myvec)
newmat


## @knitr matrix4
foo.mat<-matrix(c(rnorm(100),runif(100),runif(100),rpois(100,2)),ncol=4)
head(foo.mat)
cor(foo.mat)


## @knitr matrixdance
mycorr<-cor(foo.mat)
class(mycorr)
mycorr2<-as.data.frame(mycorr)
class(mycorr2)
mycorr2


## @knitr array
myarray<-array(1:42,dim=c(7,3,2),dimnames=list(c("tiny","small",
                    "medium","medium-ish","large","big","huge"),
                     c("slow","moderate","fast"),c("boring","fun")))
class(myarray)
dim(myarray)


## @knitr array2
dimnames(myarray)
myarray


## @knitr lists
mylist<-list(vec=myvec,mat=mymat,arr=myarray,date=mydate)
class(mylist)
length(mylist)
names(mylist)


## @knitr listprint
str(mylist)


## @knitr lists2
mylist$vec
mylist[[2]][1,3]


## @knitr attr
attributes(mylist)
attributes(myarray)[1:2][2]


## @knitr dataframetypes,echo=TRUE,results='markup'
str(df[ ,25:32])


## @knitr session-info
print(sessionInfo(), locale=FALSE)


