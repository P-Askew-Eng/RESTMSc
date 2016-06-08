print("Buswell's Equation Evaluation")
c<-as.numeric(readline(prompt="Enter atoms of carbon: "))
h<-as.numeric(readline(prompt="Enter atoms of hydrogen: "))
o<-as.numeric(readline(prompt="Enter atoms of oxygen: "))
n<-as.numeric(readline(prompt="Enter atoms of nitrogen: "))
s<-as.numeric(readline(prompt="Enter atoms of sulphur: "))
fsmass<-1
fsmass<-as.numeric(readline(prompt="Enter mass of feedstock in kg: "))
#temp<-as.numeric(readline(prompt="Enter temperature in degrees Celsius: "))

#Formula
feedstock<-paste("C",c,"H",h,"O",o,"N",n,"S",s,sep="")
print(feedstock)
#Buswell coefficients
h2o<-(4*c-h-2*o+3*n+2*s)*0.25
ch4<-(4*c+h-2*o-3*n-2*s)*0.125
co2<-(4*c-h+2*o+3*n+2*s)*0.125
nh3<-n
h2s<-s
totmoles<-ch4+co2+nh3+h2s

equation<-paste(feedstock," + ",h2o,"H2O -> ",ch4,"CH4 + ",co2,"CO2 + ",nh3,"NH3 + ",h2s,"H2S",sep="")
print(equation)
#calculate molar mass of feedstock g/mol
fsmolarmass<-c*12.0107+h*1.0079+o*15.9994+n*14.0067+s*32.065
cmass<-c*12.0107
chmass<-ch4*16.0423
co2mass<-co2*44.0095
nh3mass<-nh3*15.0146
h2omass<-h2o*18.0152

#Gas Composition
print("Biogas Composition")
print(paste("Methane: ",round(ch4/totmoles*100,2),"%",sep=""))
print(paste("Carbon dioxide: ",round(co2/totmoles*100,2),"%",sep=""))
print(paste("Ammonia: ",round(nh3/totmoles*100,2),"%",sep=""))
print(paste("Hydrogen Sulphide: ",round(h2s/totmoles*100,2),"%",sep=""))
print("Biogas Composition without N and S")
biometh<-ch4/(ch4+co2)
print(paste("Methane: ",round(biometh*100,2),"%",sep=""))
print(paste("Carbon dioxide: ",round((1-biometh)*100,2),"%",sep=""))

#Gas Volume Calculations
#insert biodegrade efficiency here -assumed 60% for now
bioeff<-0.6
samplec<-cmass/fsmolarmass*fsmass*bioeff
print(paste("Mass of carbon in feedstock for digestion; ",round(samplec,2),"kg assuming a ",bioeff*100,"% conversion rate",sep=""))
methmass<-biometh*samplec*16.0423/12.0107
chmoles<-methmass*1000/16.0423
volch4<-chmoles*0.0224
co2mass<-(1-biometh)*samplec*44.0095/12.0107
co2moles<-co2mass*1000/44.0095
volco2<-co2moles*0.0224
print(paste(fsmass,"kg of feedstock produces",round(volch4,1),"cubic metres of biomethane and",round(volco2,1),"cubic metres of CO2"))
print(paste(round(volco2+volch4,1),"m3 of biogas at standard temperature and pressure",sep=""))
