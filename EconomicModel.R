# Economic Model for MSc AD project

#Main variables setting environment
CapitalCost<-100000 #Capital Cost of plant
opcostrate<-0.05 #operating cost per annum as proportion of capital
opcost<-opcostrate*CapitalCost
ADeff<-0.85 #efficiency wth which AD converts feedstock to biomethane
geneff<-0.35 #efficiency of electrical generator
boilereff<-0.95 #efficiency of boiler
years=20 #years of operation
#Subsidies and payments in GBP taken form various sources
fitrate<-.0353
rhirate<-.059
exportrate<-.0739
gasretail<-.065
elecretail<-.105
landfillgate<-100
transport<-15
efwgate<-42
digestate<-2

#set up matrices for table
FSCOD<-c(1.0,1.5,2.0,2.5,3.0,3.5)
FSMasspd<-c(100,150,200,250,300,350,400,450,500)
ecotable<-matrix(data=NA,nrow=length(FSCOD),ncol=length(FSMasspd))
colnames(ecotable)<-FSMasspd
rownames(ecotable)<-FSCOD
heatable<-matrix(data=NA,nrow=length(FSCOD),ncol=length(FSMasspd))
colnames(heatable)<-FSMasspd
rownames(heatable)<-FSCOD
elecpayback<-matrix(data=NA,nrow=length(FSCOD),ncol=length(FSMasspd))
colnames(elecpayback)<-FSMasspd
rownames(elecpayback)<-FSCOD
heatpayback<-matrix(data=NA,nrow=length(FSCOD),ncol=length(FSMasspd))
colnames(heatpayback)<-FSMasspd
rownames(heatpayback)<-FSCOD


# loops to create tables
for (i in 1:length(FSCOD)){
 for (j in 1:length(FSMasspd)){

   gasvol<-FSCOD[i]*FSMasspd[j]*ADeff*0.35
   kWhtotal<-gasvol*10
   kWhth<-kWhtotal*boilereff
   kWhe<-kWhtotal*geneff

   #Calculate Annual benefits
   heatpa<-kWhth*365
   rhipa<-heatpa*rhirate
   elecpa<-kWhe*365
   fitpa<-elecpa*fitrate
   exportpa<-elecpa*exportrate
   retailheat<-gasretail*heatpa
   retailelec<-elecretail*elecpa
   landsaving<-FSMasspd[j]*(transport+landfillgate)/1000*365
   efwsaving<-FSMasspd[j]*(transport+efwgate)/1000*365
   digsales<-FSMasspd[j]/1000*digestate*365


   #CREATE CASHFLOW
   income1<-fitpa+retailelec+efwsaving+digestate # annual income for electricity
   income2<-rhipa+retailheat+efwsaving+digestate #annual income for heat
   netannual=income1-opcost #net income after operating costs for electricity
   netannual2=income2-opcost #net income for operating costs for heat

   cf <- rep(netannual,each=years) #annual cashflow
   cf[1]<-cf[1]-CapitalCost        # adjust first year for capital cost
   cf2 <- rep(netannual2,each=years)
   cf2[1]<-cf2[1]-CapitalCost
#calculate IRR

   npv <- function(r, cf, t=seq(along=cf)) sum(cf/(1+r)^t) 
   irr <- function(cf) { uniroot(npv, c(0,1), cf=cf,extendInt = "yes")$root } #NB need extenInt to avoiderror but creates error in heattable
   ans<-irr(cf)
   if (ans<0) ans<-NA
   ans2<-irr(cf2)
   if (ans2<0) ans2<-NA
   ecotable[i,j]<-round(ans*100,1) #irr for electricity
   heatable[i,j]<-round(ans2*100,1) #irr for heat
   elecpayback[i,j]<-round(CapitalCost/netannual,1)# simple payback for electricity
   heatpayback[i,j]<-round(CapitalCost/netannual2,1) # simple payback for heat
  }
}
print("Simple Payback of AD in electricity generation (years)")
print(elecpayback)
print("IRR for use of AD in electricity generation %")
print(ecotable)
print("Simple Payback of AD in heat generation (years)")
print(heatpayback)
print("IRR for use of AD in heat generation %")
print(heatable)
