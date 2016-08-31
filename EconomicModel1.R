# Economic Model for MSc AD project
# asks for input of COD and kg per day and calaculates irr.

#Main variables setting environment
CapitalCost<-100000 #Capital Cost of plant
opcostrate<-0.05 #operating cost per annum as proportion of capital
opcost<-opcostrate*CapitalCost
ADeff<-0.6 #efficiency wth which AD converts feedstock to biomethane
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

#input
FSCOD<-as.numeric(readline(prompt="Enter COD of feedstock in g/g : " ))
FSMasspd<-as.numeric(readline(prompt="Enter amount of feedstock per day in kg : " ))

   gasvol<-FSCOD*FSMasspd*ADeff*0.35
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
   landsaving<-FSMasspd*(transport+landfillgate)/1000*365
   efwsaving<-FSMasspd*(transport+efwgate)/1000*365
   digsales<-FSMasspd/1000*digestate*365


   #CREATE CASHFLOW
   income1<-fitpa+retailelec+efwsaving # annual income for electricity
   income2<-rhipa+retailheat+efwsaving #annual income for heat
   netannual=income1-opcost #net income after operating costs for electricity
   netannual2=income2-opcost #net income for operating costs for heat

   cf <- rep(netannual,each=years) #annual cashflow
   cf[1]<-cf[1]-CapitalCost        # adjust first year for capital cost
   cf2 <- rep(netannual2,each=years)
   cf2[1]<-cf2[1]-CapitalCost
#calculate IRR

   npv <- function(r, cf, t=seq(along=cf)) sum(cf/(1+r)^t) 
   irr <- function(cf) { uniroot(npv, c(0,1), cf=cf,extendInt = "yes")$root } #NB need extenInt to avoid error 
   ans<-irr(cf)
   ans2<-irr(cf2)
print(paste("For ",FSMasspd,"kg of feedstock with a COD of ",FSCOD,"g/g an IRR of ",round(ans*100,2),"% can be expected for the generation of electricity"))
print(paste("For ",FSMasspd,"kg of feedstock with a COD of ",FSCOD,"g/g an IRR of ",round(ans2*100,2),"% can be expected for the generation of heat"))
