# Economic Model for MSc AD project

#
CapitalCost<-100000 #Capital Cost of plant
opcostrate<-0.05 #operating cost per annum as proportion of capital
opcost<-opcostrate*CapitalCost
ADeff<-0.6 #efficiency wth which AD converts feedstock to biomethane
geneff<-0.35 #efficiency of electrical generator
boilereff<-0.95 #efficiency of bolier
#Subsidies and payments in GBP
fitrate<-.065
rhirate<-.095
exportrate<-.045
gasretail<-.075
elecretail<-.105
landfillgate<-100
transport<-15
efwgate<-42
digestate<-2


i<-as.numeric(readline(prompt="Enter COD of feestock in g/g: "))
j<-as.numeric(readline(prompt="Enter amount of feedstock per day in kg "))
FSCOD<-c(1.0,1.5,2.0,2.5,3.0)
FSMasspd<-c(150,200,250,300,350,400,450,500)

#for (i in FSCOD){
#  for (j in FSMasspd){
gasvol<-i*j*ADeff*0.35

kWtotal<-gasvol*10
kWth<-kWtotal*boilereff
kWe<-kWtotal*geneff



#Calculate Annual benefits
heatpa<-kWth*365
rhipa<-heatpa*rhirate
elecpa<-kWe*365
fitpa<-elecpa*fitrate
exportpa<-elecpa*exportrate
retailheat<-gasretail*heatpa
retailelec<-elecretail*elecpa
landsaving<-j*(transport+landfillgate)/1000*365
efwsaving<-j*(transport+efwgate)/1000*365
digsales<-j/1000*digestate*365

#CREATE CASHFLOW
income1<-fitpa+retailelec+efwsaving
netannual=income1-opcost
years=20
cf <- rep(netannual,each=years)
cf[1]<-cf[1]-CapitalCost

#calculate IRR

npv <- function(r, cf, t=seq(along=cf)) sum(cf/(1+r)^t) 
irr <- function(cf) { uniroot(npv, c(0,1), cf=cf)$root } 
ans<-irr(cf)
#ecotable[i,j]<-ans*100
#  }
#  }