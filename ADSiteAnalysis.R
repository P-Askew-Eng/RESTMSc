#This R Script takes the data on AD sites from the National Non Food Crop Centre and
#analyses it for proporation of food waste sites.  NOte: The data is saved as csv due
#to problems with the xlsx package requiring rJava which is not working.


#Set environment for analysis with directories and libraries
setwd("C:/Users/Paul/OneDrive/MSc project/Git_Files/RESTMSc")
library(dplyr)
library(ggplot2)
library(openxlsx)

#Read in data and remove blan linesat top and bottom
ADurl<-"http://www.biogas-info.co.uk/wp-content/uploads/2015/06/AD-portal-map_site-list_external_October_2015.xlsx"
if (!file.exists("./data/ADSiteList.xlsx")){
  download.file(ADurl,destfile="./data/ADSiteList.xlsx",mode="wb")
}
ADSites<-read.xlsx("./data/ADSiteList.xlsx",startRow=5,colNames=TRUE)
ADSites<-ADSites[!(ADSites$Region==""),]
ADSites<-ADSites[!(ADSites$Region=="Subtotals"),]
colnames(ADSites)[6]<-"Capacity_kWe"
colnames(ADSites)[13]<-"Demand_tonnes_pa"
ADSites[]
ADSites$Capacity_kWe<-as.numeric(as.character((paste(ADSites$Capacity_kWe))))


#Extract information from data set
#Subset Waste and Farm fed sites
farmsites<-ADSites[ADSites$Type=='Farm-fed',]
wastesites<-ADSites[ADSites$Type=='Waste-fed',]



sum(farmsites$Capacity_kWe)

