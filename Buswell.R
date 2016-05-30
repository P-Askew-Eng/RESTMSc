print("Buswell's Equation Evaluation")
c<-as.numeric(readline(prompt="Enter atoms of carbon: "))
h<-as.numeric(readline(prompt="Enter atoms of hydrogen: "))
o<-as.numeric(readline(prompt="Enter atoms of oxygen: "))
n<-as.numeric(readline(prompt="Enter atoms of nitrogen: "))
s<-as.numeric(readline(prompt="Enter atoms of sulphur: "))
feedstock<-paste("C",c,"H",h,"O",o,"N",n,"S",s,sep="")
#calculate molar mass of feedstock g/mol
fsmolarmass<-c*12.0107+h*1.0079+o*15.9994+n*14.0067+s*32.065

  
h2o<-(4*c-h-2*o+3*n+2*s)*0.25
h20mass<-h2o*18.0152
ch4<-(4*c+h-2*o-3*n-2*s)*0.125
chmass<-ch4*16.0423
co2<-(4*c-h+2*o+3*n+2*s)*0.125
co2mass<-co2*44.0095
nh3=n
h2s=s