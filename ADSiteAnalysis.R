#This R Script takes the data on AD sites from the National Non Food Crop Centre and
#analyses it for proporation of food waste sites.  NOte: The data is saved as csv due
#to problems with the xlsx package requiring rJava which is not working.


#Set environment for analysis with directories and libraries
setwd("C:/Users/Paul/OneDrive/MSc project/Git_Files/RESTMSc")
library(dplyr)
library(ggplot2)
library(openxlsx)

#Read in data and remove blank lines at top and bottom
ADurl<-"http://www.biogas-info.co.uk/wp-content/uploads/2015/06/AD-portal-map_site-list_external_April-_2016.xlsx"
if (!file.exists("./data/ADSiteList.xlsx")){
  download.file(ADurl,destfile="./data/ADSiteList.xlsx",mode="wb")
}
ADSites<-read.xlsx("./data/ADSiteList.xlsx",startRow=5,colNames=TRUE)
ADSites<-ADSites[!(ADSites$Region==""),]
ADSites<-ADSites[!(ADSites$Region=="Subtotals"),]
colnames(ADSites)[6]<-"Capacity_kWe"
colnames(ADSites)[12]<-"Demand_tonnes_pa"
ADSites<-ADSites[complete.cases(ADSites[,c(1,2,3,4)]),]#remove blank rows at end
ADSites$Capacity_kWe<-as.numeric(as.character((paste(ADSites$Capacity_kWe))))


#Extract information from data set
#Subset Waste and Farm fed sites
farmsites<-ADSites[ADSites$Type=='Farm-fed',]
wastesites<-ADSites[ADSites$Type=='Waste-fed',]
foodwastesites<-ADSites[grepl(("ood waste"),ADSites$Feedstock),]

#Simple sums and pie chart
sum(foodwastesites$Capacity_kWe,na.rm=T)
sum(farmsites$Capacity_kWe,na.rm=T)
sum(wastesites$Capacity_kWe,na.rm=T)
sitetypes<-c(sum(wastesites$Capacity_kWe,na.rm=T),sum(farmsites$Capacity_kWe,na.rm=T))
pielabels<-paste(round(sitetypes/1000,1), "MWe")
pie(sitetypes,labels=pielabels, main = "Types of AD Sites by Capacity (MWe)",col=rainbow(2))
legend("topright",c("Waste Sites", "Farm Sites"),fill=rainbow(2))

plot.window(xlim=c(0,100000),ylim=c(0,3000),log="x",asp=NA)
plot(x=ADSites$Demand_tonnes_pa,y=ADSites$Capacity_kWe,type="p",
     xlab="Annual feedstock demand (tonnes per annum)",
     ylab="AD output kWe", main="Comparison of feedstock demand and electricity output")

plot.window(xlim=c(0,10000),ylim=c(0,500),log="",asp=NA)
plot(x=ADSites$Demand_tonnes_pa,y=ADSites$Capacity_kWe,type="p",
     xlab="Annual feedstock demand (tonnes per annum)",
     ylab="AD output kWe", main="Comparison of feedstock demand and electricity output")

#data<-data.frame(ADSites)
#a<-ggplot(data,aes(x=Demand_tonnes_pa,y=Capacity_kWe))+geom_jitter(aes(color="red"),na.rm=T)
