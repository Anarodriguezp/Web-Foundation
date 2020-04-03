
rm(list = ls())
getwd()
work_dir <- "~/Desktop/ANAR/World Wide Web Replication Set"

#Packages required for the analysis
# install.packages("jtools")
# install.packages("broom")
# install.packages("ggstance")
# install.packages("broom.mixed")
# install.packages("tidyr")
# install.packages("tidyverse")
# install.packages("gridExtra")
#install.packages("ggpubr")

library(lmtest)
library(sandwich)
library(texreg)
library(dplyr)
library(jtools)
library(tidyr)
library(dplyr)
library(ggplot2)
library(forcats)
library(ggpubr)

#loading data Rankings
RAN <- read.csv("~/Desktop/ANAR/World Wide Web Replication Set/Data/Final_Data_Set/Rankings.csv")

# Understanding Implementation Datasets Average Variable per year 2013 - 2016
subset2013 <- subset ( RAN, 
                subset = year == "2013")
summary(subset2013$implementationdatasets_average)

subset2014 <- subset ( RAN, 
                       subset = year == "2014")
summary(subset2014$implementationdatasets_average)

subset2015 <- subset ( RAN, 
                       subset = year == "2015")
summary(subset2015$implementationdatasets_average)

subset2016 <- subset ( RAN, 
                       subset = year == "2016")
summary(subset2016$implementationdatasets_average)

par(mfrow=c(2,2))

#Figure 1
Imple <- read.csv("~/Desktop/ANAR/World Wide Web Replication Set/Data/Data_for_Visualizations/Implementation.csv")

# Line graph variable Implementation Datasets Average 
Implementation_plot <- ggplot(Imple, aes(x=Year, y=Result, group=Stats, color=Stats)) +
geom_line() +
ggtitle("Figure 1 
    Data Openess: availability 
    and reusability") +
ylab("Average Implementation Score")
 
#Figure 2
# Using Scored dataset to build understand the behaviour of availability and 
# machine-readable in 15 datasets from 2013 to 2015

#Create data using scored ODB dataset 
datasets <- read.csv("~/Desktop/ANAR/World Wide Web Replication Set/Data/Data_for_Visualizations/Datasets.csv")

# Barplot 

datasets_plot <- ggplot(datasets, aes(x=Year, y=Average, fill=Category, color=Category)) + 
  geom_bar(stat = "identity", position = 'dodge', width=0.5)+
  ggtitle("Figure 2
      15 datasets per country: 
      availability and machine-readable") +
  ylab("Average datasets per country")

ggarrange (Implementation_plot, datasets_plot)

#Regression results

#loading data Rankings
RAN <- read.csv("~/Desktop/ANAR/World Wide Web Replication Set/Data/Final_Data_Set/Rankings.csv")

#Clean N/As from Rankings
RAN <- RAN[ !is.na(RAN$implementationdatasets_average), ]
RAN <- RAN[ !is.na(RAN$lngdp_wdi_pw), ]
RAN <- RAN[ !is.na(RAN$civil_society_participation_inde), ]
RAN <- RAN[ !is.na(RAN$public_sector_corruption_index), ]
RAN <- RAN[ !is.na(RAN$executive_corruption_index), ]
RAN <- RAN[ !is.na(RAN$civil_liberties_index), ]
RAN <- RAN[ !is.na(RAN$government_effectiveness__estima), ]
RAN <- RAN[ !is.na(RAN$fixed_broadband_internet_subscri), ]
RAN <- RAN[ !is.na(RAN$direct_popular_vote_index), ]


#Finding columns
which(colnames(RAN) =="implementationdatasets_average")
which(colnames(RAN) =="civil_society_participation_inde")
which(colnames(RAN) =="public_sector_corruption_index")
which(colnames(RAN) =="executive_corruption_index")
which(colnames(RAN) =="civil_liberties_index")
which(colnames(RAN) =="government_effectiveness__estima")
which(colnames(RAN) == "fixed_broadband_internet_subscri")
which(colnames(RAN) == "direct_popular_vote_index")
which(colnames(RAN) == "lngdp_wdi_pw")

#Standardizing 
RAN[, 17] = scale(RAN[, 17]) # For column 17
RAN[, 49] = scale(RAN[, 49]) # For column 49
RAN[, 51] = scale(RAN[, 51]) # For column 53
RAN[, 52] = scale(RAN[, 52]) # For column 60
RAN[, 53] = scale(RAN[, 53]) # For column 73
RAN[, 54] = scale(RAN[, 54]) # For column 74
RAN[, 48] = scale(RAN[, 48]) # For column 77
RAN[, 50] = scale(RAN[, 50]) # For column 78
RAN[, 47] = scale(RAN[, 47]) # For column 81

#Change names of the variables 
colnames(RAN) [17] <- "implementation_norm"
colnames(RAN) [49] <- "civil_participation" 
colnames(RAN) [51] <- "public_sec_corruption" 
colnames(RAN) [52] <- "executive_corruption" 
colnames(RAN) [53] <- "civil_liberties" 
colnames(RAN) [54] <- "government_effectiveness" 
colnames(RAN) [48] <- "internet_subscription"
colnames(RAN) [50] <- "direct_vote"
colnames(RAN) [47] <- "logGDP" 


cor(RAN[, c("implementation_norm","civil_participation",
            "public_sec_corruption", "executive_corruption", "civil_liberties", "government_effectiveness",
            "internet_subscription")])

# Main Linear Regression Model

model1 <- lm(implementation_norm ~ civil_participation + public_sec_corruption + executive_corruption +
                civil_liberties + government_effectiveness + internet_subscription + logGDP, data = RAN)
summary(model1)
screenreg(model1)

# Robustness Checks

model2 <- lm(implementation_norm ~ civil_participation + public_sec_corruption +
               + internet_subscription + logGDP, data = RAN)
summary(model2)
screenreg(model2)

model3 <- lm(implementation_norm ~ civil_participation + public_sec_corruption + executive_corruption + direct_vote +
               civil_liberties + government_effectiveness + internet_subscription + logGDP, data = RAN)
summary(model3)
screenreg(model3)

screenreg(list(model1,model2, model3))

plot_summs(model1,model3, scale = TRUE,
           model.names = c("Implementation", "Implementation + Direct Vote"))









