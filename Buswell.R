6print("Buswell's Equation Evaluation")
c<-as.numeric(readline(prompt="Enter atoms of carbon: "))
h<-as.numeric(readline(prompt="Enter atoms of hydrogen: "))
o<-as.numeric(readline(prompt="Enter atoms of oxygen: "))
n<-as.numeric(readline(prompt="Enter atoms of nitrogen: "))
s<-as.numeric(readline(prompt="Enter atoms of sulphur: "))
fsmass<-1
fsmass<-as.numeric(readline(prompt="Enter mass of feedstock in kg: "))
temp<-as.numeric(readline(prompt="Enter temperature in degrees Celsius: "))

#Formula
feedstock<-paste("C",c,"H",h,"O",o,"N",n,"S",s,sep="")
print(feedstock)
#Buswell coefficients
h2o<-(4*c-h-2*o+3*n+2*s)*0.25
ch4<-(4*c+h-2*o-3*n-2*s)*0.125
co2<-(4*c-h+2*o+3*n+2*s)*0.125
nh3=n
h2s=s

equation<-paste(feedstock," + ",h2o,"H2O -> ",ch4,"CH4 + ",co2,"CO2 + ",nh3,"NH3 + ",h2s,"H2S",sep="")
print(equation)
#calculate molar mass of feedstock g/mol
fsmolarmass<-c*12.0107+h*1.0079+o*15.9994+n*14.0067+s*32.065
chmass<-ch4*16.0423
co2mass<-co2*44.0095
h2omass<-h2o*18.0152

#calculate moles of feedstock
fsmoles<-fsmass/(fsmolarmass/1000)
print(fsmoles)
chmoles<-fsmoles*ch4/(chmass/1000)
co2moles<-fsmoles*co2/(co2mass/1000)
volch4<-chmoles*8.3145*(273.15+temp)/101325
volco2<-co2moles*8.3145*(273.15+temp)/101325
print(paste(fsmass,"kg of feedstock produces",volch4,"cubic metres of biomethane and",volco2,"cubic metres of CO2"))

#Ideal gas equation PV=nRT
moles<-1
Volstp<-moles*8.3145*273.15/101325 #volume of gas at STP in m^3