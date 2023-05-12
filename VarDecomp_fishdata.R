library(MASS)
library(dplyr)
library(tidyverse)

load('D:/ShaonLab/fish_data/FISH_jul22/bmal_per2_tef_rawdata.RData')
load('D:/ShaonLab/fish_data/FISH_jul22/nr1d1_clock_cry1_rawdata.RData')
load('D:/ShaonLab/fish_data/FISH_jul22/nifl_rorc_nr1d2_rawdata.RData')
load('D:/ShaonLab/fish_data/FISH_jul22/per1_ciart_npas_rawdata.RData')

norm_area <- function(areaData){
  return((areaData - min(areaData))/(max(areaData)-min(areaData)))
}

# Y1 = area, Y2 = time##############################################################################
# gives E(Z/Y1) and V(Z/Y1)

bmal_per2_tef_df <- bmal_per2_tef %>% reduce(full_join)
nr1d1_clock_cry1_df <- nr1d1_clock_cry1 %>% reduce(full_join)
nifl_rorc_nr1d2_df <- nifl_rorc_nr1d2 %>% reduce(full_join)
per1_ciart_npas_df <- per1_ciart_npas %>% reduce(full_join)

bmal_per2_tef_df['normArea'] <- round(norm_area(bmal_per2_tef_df['AreaShape_Area']),4)
nr1d1_clock_cry1_df['normArea'] <- round(norm_area(nr1d1_clock_cry1_df['AreaShape_Area']),4)
nifl_rorc_nr1d2_df['normArea'] <- round(norm_area(nifl_rorc_nr1d2_df['AreaShape_Area']),4)
per1_ciart_npas_df['normArea'] <- round(norm_area(per1_ciart_npas_df['AreaShape_Area']),4)
# plot(bmal_per2_tef_df$normArea, bmal_per2_tef_df$Children_bmal_spots_Count, pch = 16)

condArea_bmal_per2_tef <- bmal_per2_tef_df %>%
  group_by(normArea) %>%
  summarise(meanBmal_count = mean(Children_bmal_spots_Count), 
            varBmal = var(Children_bmal_spots_Count), 
            meanPer2_count = mean(Children_per2_spots_Count),
            varPer2 = var(Children_per2_spots_Count),
            meanTef_count = mean(Children_tef_spots_Count),
            varTef = var(Children_tef_spots_Count))

condArea_nr1d1_clock_cry1 <- nr1d1_clock_cry1_df %>%
  group_by(normArea) %>%
  summarise(meanNr1d1_count = mean(Children_nr1d1_spots_Count), 
            varBmal = var(Children_nr1d1_spots_Count), 
            meanClock_count = mean(Children_clock_spots_Count),
            varClock = var(Children_clock_spots_Count),
            meanCry1_count = mean(Children_cry1_spots_Count),
            varCry1 = var(Children_cry1_spots_Count))

condArea_nifl_rorc_nr1d2 <- nifl_rorc_nr1d2_df %>%
  group_by(normArea) %>%
  summarise(meanNifl_count = mean(Children_nifl_spots_Count), 
            varNifl = var(Children_nifl_spots_Count), 
            meanRorc_count = mean(Children_rorc_spots_Count),
            varRorc = var(Children_rorc_spots_Count),
            meanNr1d2_count = mean(Children_nr1d2_spots_Count),
            varNr1d2 = var(Children_nr1d2_spots_Count))


condArea_per1_ciart_npas <- per1_ciart_npas_df %>%
  group_by(normArea) %>%
  summarise(meanPer1_count = mean(Children_per1_spots_Count), 
            varPer1 = var(Children_per1_spots_Count), 
            meanNpas_count = mean(Children_npas_spots_Count),
            varNpas = var(Children_npas_spots_Count))

condArea_bmal_per2_tef[sapply(condArea_bmal_per2_tef, is.na)]<- 0
condArea_nr1d1_clock_cry1[sapply(condArea_nr1d1_clock_cry1, is.na)]<- 0
condArea_nifl_rorc_nr1d2[sapply(condArea_nifl_rorc_nr1d2, is.na)]<- 0
condArea_per1_ciart_npas[sapply(condArea_per1_ciart_npas, is.na)]<- 0
plot(condArea_per1_ciart_npas$normArea, 
     condArea_per1_ciart_npas$meanPer1_count)
# varBmalArea <- var(condArea$meanBmal_count) + mean(condArea$varBmal)
# print(c(var(condArea$meanTef_count),mean(condArea$varTef)))
# var(bmal_per2_tef_df$Children_bmal_spots_Count)

# gives E(Z/Y1,Y2)
condAT_bmal_per2_tef <- bmal_per2_tef_df %>%
  group_by(normArea,time) %>%
  summarise(meanBmal_count = mean(Children_bmal_spots_Count), 
            varBmal = var(Children_bmal_spots_Count), 
            meanPer2_count = mean(Children_per2_spots_Count), 
            varPer2 = var(Children_per2_spots_Count),
            meanTef_count = mean(Children_tef_spots_Count),
            varTef = var(Children_tef_spots_Count))
# condTA <- bmal_per2_tef_df %>%
#   group_by(time, normArea) %>%
#   summarise(meanBmal_count = mean(Children_bmal_spots_Count), 
#             varBmal = var(Children_bmal_spots_Count), 
#             meanPer2_count = mean(Children_per2_spots_Count), 
#             varPer = var(Children_per2_spots_Count),
#             meanTef_count = mean(Children_tef_spots_Count),
#             varTef = var(Children_tef_spots_Count))
condAT_nr1d1_clock_cry1 <- nr1d1_clock_cry1_df %>%
  group_by(normArea,time) %>%
  summarise(meanNr1d1_count = mean(Children_nr1d1_spots_Count), 
            varNr1d1 = var(Children_nr1d1_spots_Count), 
            meanClock_count = mean(Children_clock_spots_Count),
            varClock = var(Children_clock_spots_Count),
            meanCry1_count = mean(Children_cry1_spots_Count),
            varCry1 = var(Children_cry1_spots_Count))

condAT_nifl_rorc_nr1d2 <- nifl_rorc_nr1d2_df %>%
  group_by(normArea,time) %>%
  summarise(meanNifl_count = mean(Children_nifl_spots_Count), 
            varNifl = var(Children_nifl_spots_Count), 
            meanRorc_count = mean(Children_rorc_spots_Count),
            varRorc = var(Children_rorc_spots_Count),
            meanNr1d2_count = mean(Children_nr1d2_spots_Count),
            varNr1d2 = var(Children_nr1d2_spots_Count))


condAT_per1_ciart_npas <- per1_ciart_npas_df %>%
  group_by(normArea,time) %>%
  summarise(meanPer1_count = mean(Children_per1_spots_Count), 
            varPer1 = var(Children_per1_spots_Count), 
            meanNpas_count = mean(Children_npas_spots_Count),
            varNpas = var(Children_npas_spots_Count))

condAT_bmal_per2_tef[sapply(condAT_bmal_per2_tef, is.na)]<- 0
condAT_nr1d1_clock_cry1[sapply(condAT_nr1d1_clock_cry1, is.na)]<- 0
condAT_nifl_rorc_nr1d2[sapply(condAT_nifl_rorc_nr1d2, is.na)]<- 0
condAT_per1_ciart_npas[sapply(condAT_per1_ciart_npas, is.na)]<- 0
# condTA[sapply(condTA, is.na)] <- 0

# gives V(E(Z/Y1,Y2)/Y1)
condATarea_bmal_per2_tef <- condAT_bmal_per2_tef %>%
  group_by(normArea) %>%
  summarise(meanBmal = mean(meanBmal_count), 
            varBmal = var(meanBmal_count), 
            meanPer2 = mean(meanPer2_count), 
            varPer2 = var(meanPer2_count),
            meanTef = mean(meanTef_count),
            varTef = var(meanTef_count))

condATarea_nr1d1_clock_cry1 <- condAT_nr1d1_clock_cry1 %>%
  group_by(normArea) %>%
  summarise(meanNr1d1 = mean(meanNr1d1_count), 
            varNr1d1 = var(meanNr1d1_count), 
            meanClock = mean(meanClock_count), 
            varClock = var(meanClock_count),
            meanCry1 = mean(meanCry1_count),
            varCry1 = var(meanCry1_count))

condATarea_nifl_rorc_nr1d2 <- condAT_nifl_rorc_nr1d2 %>%
  group_by(normArea) %>%
  summarise(meanNifl = mean(meanNifl_count), 
            varNifl = var(meanNifl_count), 
            meanRorc = mean(meanRorc_count), 
            varRorc = var(meanRorc_count),
            meanNr1d2 = mean(meanNr1d2_count),
            varNr1d2 = var(meanNr1d2_count))

condATarea_per1_ciart_npas <- condAT_per1_ciart_npas %>%
  group_by(normArea) %>%
  summarise(meanPer1 = mean(meanPer1_count), 
            varPer1 = var(meanPer1_count), 
            meanNpas = mean(meanNpas_count), 
            varNpas = var(meanNpas_count))

condATarea_bmal_per2_tef[sapply(condATarea_bmal_per2_tef, is.na)] <- 0
condATarea_nr1d1_clock_cry1[sapply(condATarea_nr1d1_clock_cry1, is.na)] <- 0
condATarea_nifl_rorc_nr1d2[sapply(condATarea_nifl_rorc_nr1d2, is.na)] <- 0
condATarea_per1_ciart_npas[sapply(condATarea_per1_ciart_npas, is.na)] <- 0

# var1combBmal <- mean(condAT$varBmal) + 
#   mean(condATarea$varBmal) + var(condArea$meanBmal_count)
# var1combBmal
# var(finaldf$bmal_count)

# Y1 = time, Y2 = area##############################################################################
# gives E(Z/Y1) and V(Z/Y1)
condTime_bmal_per2_tef <- bmal_per2_tef_df %>%
  group_by(time) %>%
  summarise(meanBmal_count = mean(Children_bmal_spots_Count), 
            varBmal = var(Children_bmal_spots_Count), 
            meanPer2_count = mean(Children_per2_spots_Count),
            varPer2 = var(Children_per2_spots_Count),
            meanTef_count = mean(Children_tef_spots_Count),
            varTef = var(Children_tef_spots_Count))

condTime_nr1d1_clock_cry1 <- nr1d1_clock_cry1_df %>%
  group_by(time) %>%
  summarise(meanNr1d1_count = mean(Children_nr1d1_spots_Count), 
            varBmal = var(Children_nr1d1_spots_Count), 
            meanClock_count = mean(Children_clock_spots_Count),
            varClock = var(Children_clock_spots_Count),
            meanCry1_count = mean(Children_cry1_spots_Count),
            varCry1 = var(Children_cry1_spots_Count))

condTime_nifl_rorc_nr1d2 <- nifl_rorc_nr1d2_df %>%
  group_by(time) %>%
  summarise(meanNifl_count = mean(Children_nifl_spots_Count), 
            varNifl = var(Children_nifl_spots_Count), 
            meanRorc_count = mean(Children_rorc_spots_Count),
            varRorc = var(Children_rorc_spots_Count),
            meanNr1d2_count = mean(Children_nr1d2_spots_Count),
            varNr1d2 = var(Children_nr1d2_spots_Count))


condTime_per1_ciart_npas <- per1_ciart_npas_df %>%
  group_by(time) %>%
  summarise(meanPer1_count = mean(Children_per1_spots_Count), 
            varPer1 = var(Children_per1_spots_Count), 
            meanNpas_count = mean(Children_npas_spots_Count),
            varNpas = var(Children_npas_spots_Count))

condTime_bmal_per2_tef[sapply(condTime_bmal_per2_tef, is.na)]<- 0
condTime_nr1d1_clock_cry1[sapply(condTime_nr1d1_clock_cry1, is.na)]<- 0
condTime_nifl_rorc_nr1d2[sapply(condTime_nifl_rorc_nr1d2, is.na)]<- 0
condTime_per1_ciart_npas[sapply(condTime_per1_ciart_npas, is.na)]<- 0
# mean(condTime$meanTef_count)
# mean(bmal_per2_tef_df$Children_tef_spots_Count)
# varBmalTime <- var(condTime$meanBmal_count) + mean(condTime$varBmal)
# varBmalOrgi <- var(bmal_per2_tef_df$Children_bmal_spots_Count)

# gives V(E(Z/Y1,Y2)/Y1)
condATtime_bmal_per2_tef <- condAT_bmal_per2_tef %>%
  group_by(time) %>%
  summarise(meanBmal = mean(meanBmal_count), 
            varBmal = var(meanBmal_count), 
            meanPer2 = mean(meanPer2_count), 
            varPer2 = var(meanPer2_count),
            meanTef = mean(meanTef_count),
            varTef = var(meanTef_count))

condATtime_nr1d1_clock_cry1 <- condAT_nr1d1_clock_cry1 %>%
  group_by(time) %>%
  summarise(meanNr1d1 = mean(meanNr1d1_count), 
            varNr1d1 = var(meanNr1d1_count), 
            meanClock = mean(meanClock_count), 
            varClock = var(meanClock_count),
            meanCry1 = mean(meanCry1_count),
            varCry1 = var(meanCry1_count))

condATtime_nifl_rorc_nr1d2 <- condAT_nifl_rorc_nr1d2 %>%
  group_by(time) %>%
  summarise(meanNifl = mean(meanNifl_count), 
            varNifl = var(meanNifl_count), 
            meanRorc = mean(meanRorc_count), 
            varRorc = var(meanRorc_count),
            meanNr1d2 = mean(meanNr1d2_count),
            varNr1d2 = var(meanNr1d2_count))

condATtime_per1_ciart_npas <- condAT_per1_ciart_npas %>%
  group_by(time) %>%
  summarise(meanPer1 = mean(meanPer1_count), 
            varPer1 = var(meanPer1_count), 
            meanNpas = mean(meanNpas_count), 
            varNpas = var(meanNpas_count))

condATtime_bmal_per2_tef[sapply(condATtime_bmal_per2_tef, is.na)] <- 0
condATtime_nr1d1_clock_cry1[sapply(condATtime_nr1d1_clock_cry1, is.na)] <- 0
condATtime_nifl_rorc_nr1d2[sapply(condATtime_nifl_rorc_nr1d2, is.na)] <- 0
condATtime_per1_ciart_npas[sapply(condATtime_per1_ciart_npas, is.na)] <- 0

# var2combBmal <- mean(condAT$varBmal) + 
#   mean(condATtime$varBmal) + var(condTime$meanBmal_count)
# var2combBmal
# var(finaldf$bmal_count)

# variance from sources other than area and time###################################################
varOther_bmal_per2_tef <- c(mean(condAT_bmal_per2_tef$varBmal),
                            mean(condAT_bmal_per2_tef$varPer2), 
                            mean(condAT_bmal_per2_tef$varTef))
varOther_nr1d1_clock_cry1 <- c(mean(condAT_nr1d1_clock_cry1$varNr1d1),
                               mean(condAT_nr1d1_clock_cry1$varClock),
                               mean(condAT_nr1d1_clock_cry1$varCry1))
varOther_nifl_rorc_nr1d2 <- c(mean(condAT_nifl_rorc_nr1d2$varNifl),
                              mean(condAT_nifl_rorc_nr1d2$varRorc), 
                              mean(condAT_nifl_rorc_nr1d2$varNr1d2))
varOther_per1_ciart_npas <- c(mean(condAT_per1_ciart_npas$varPer1),
                              mean(condAT_per1_ciart_npas$varNpas))

# average variance from area
varArea_bmal_per2_tef <- c(0.5*(mean(condATtime_bmal_per2_tef$varBmal)+
                    var(condArea_bmal_per2_tef$meanBmal_count)),
             0.5*(mean(condATtime_bmal_per2_tef$varPer2)+
                    var(condArea_bmal_per2_tef$meanPer2_count)),
             0.5*(mean(condATtime_bmal_per2_tef$varTef) + 
                    var(condArea_bmal_per2_tef$meanTef_count)))

varArea_nr1d1_clock_cry1 <- c(0.5*(mean(condATtime_nr1d1_clock_cry1$varNr1d1)+
                     var(condArea_nr1d1_clock_cry1$meanNr1d1_count)),
              0.5*(mean(condATtime_nr1d1_clock_cry1$varClock)+
                     var(condArea_nr1d1_clock_cry1$meanClock_count)),
              0.5*(mean(condATtime_nr1d1_clock_cry1$varCry1) + 
                     var(condArea_nr1d1_clock_cry1$meanCry1_count)))

varArea_nifl_rorc_nr1d2 <- c(0.5*(mean(condATtime_nifl_rorc_nr1d2$varNifl)+
                     var(condArea_nifl_rorc_nr1d2$meanNifl_count)),
              0.5*(mean(condATtime_nifl_rorc_nr1d2$varRorc)+
                     var(condArea_nifl_rorc_nr1d2$meanRorc_count)),
              0.5*(mean(condATtime_nifl_rorc_nr1d2$varNr1d2) + 
                     var(condArea_nifl_rorc_nr1d2$meanNr1d2_count)))

varArea_per1_ciart_npas <- c(0.5*(mean(condATtime_per1_ciart_npas$varPer1)+
                     var(condArea_per1_ciart_npas$meanPer1_count)),
              0.5*(mean(condATtime_per1_ciart_npas$varNpas)+
                     var(condArea_per1_ciart_npas$meanNpas_count)))

# average variance from time
# varTime <- c(0.5*(mean(condATarea$varBmal)+
#                     var(condTime$meanBmal_count)),
#              0.5*(mean(condATarea$varPer2)+
#                     var(condTime$meanPer2_count)),
#              0.5*(mean(condATarea$varTef) +
#                     var(condTime$meanTef_count)))

varTime_bmal_per2_tef <- c(0.5*(mean(condATarea_bmal_per2_tef$varBmal)+
                                  var(condTime_bmal_per2_tef$meanBmal_count)),
                           0.5*(mean(condATarea_bmal_per2_tef$varPer2)+
                                  var(condTime_bmal_per2_tef$meanPer2_count)),
                           0.5*(mean(condATarea_bmal_per2_tef$varTef) + 
                                  var(condTime_bmal_per2_tef$meanTef_count)))

varTime_nr1d1_clock_cry1 <- c(0.5*(mean(condATarea_nr1d1_clock_cry1$varNr1d1)+
                                     var(condTime_nr1d1_clock_cry1$meanNr1d1_count)),
                              0.5*(mean(condATarea_nr1d1_clock_cry1$varClock)+
                                     var(condTime_nr1d1_clock_cry1$meanClock_count)),
                              0.5*(mean(condATarea_nr1d1_clock_cry1$varCry1) + 
                                     var(condTime_nr1d1_clock_cry1$meanCry1_count)))

varTime_nifl_rorc_nr1d2 <- c(0.5*(mean(condATarea_nifl_rorc_nr1d2$varNifl)+
                                     var(condTime_nifl_rorc_nr1d2$meanNifl_count)),
                              0.5*(mean(condATarea_nifl_rorc_nr1d2$varRorc)+
                                     var(condTime_nifl_rorc_nr1d2$meanRorc_count)),
                              0.5*(mean(condATarea_nifl_rorc_nr1d2$varNr1d2) + 
                                     var(condTime_nifl_rorc_nr1d2$meanNr1d2_count)))

varTime_per1_ciart_npas <- c(0.5*(mean(condATarea_per1_ciart_npas$varPer1)+
                                    var(condTime_per1_ciart_npas$meanPer1_count)),
                             0.5*(mean(condATarea_per1_ciart_npas$varNpas)+
                                    var(condTime_per1_ciart_npas$meanNpas_count)))


varOrgi <- c(var(bmal_per2_tef_df$Children_bmal_spots_Count),
              var(bmal_per2_tef_df$Children_per2_spots_Count),
              var(bmal_per2_tef_df$Children_tef_spots_Count),
             var(nr1d1_clock_cry1_df$Children_nr1d1_spots_Count),
             var(nr1d1_clock_cry1_df$Children_clock_spots_Count),
             var(nr1d1_clock_cry1_df$Children_cry1_spots_Count),
             var(nifl_rorc_nr1d2_df$Children_nifl_spots_Count),
             var(nifl_rorc_nr1d2_df$Children_rorc_spots_Count),
             var(nifl_rorc_nr1d2_df$Children_nr1d2_spots_Count),
             var(per1_ciart_npas_df$Children_per1_spots_Count),
             var(per1_ciart_npas_df$Children_npas_spots_Count))

varOrgi
varTotal <- c((varArea_bmal_per2_tef + varTime_bmal_per2_tef + varOther_bmal_per2_tef), 
              (varArea_nr1d1_clock_cry1 + varTime_nr1d1_clock_cry1 + varOther_nr1d1_clock_cry1),
              (varArea_nifl_rorc_nr1d2 + varTime_nifl_rorc_nr1d2 + varOther_nifl_rorc_nr1d2),
              (varArea_per1_ciart_npas + varTime_per1_ciart_npas + varOther_per1_ciart_npas))

varTotal
varArea <- c(varArea_bmal_per2_tef, varArea_nr1d1_clock_cry1, 
              varArea_nifl_rorc_nr1d2, varArea_per1_ciart_npas)

varOther <- c(varOther_bmal_per2_tef, varOther_nr1d1_clock_cry1,
              varOther_nifl_rorc_nr1d2, varOther_per1_ciart_npas)

varTime <- c(varTime_bmal_per2_tef, varTime_nr1d1_clock_cry1, 
             varTime_nifl_rorc_nr1d2, varTime_per1_ciart_npas)

varFinal <- as.data.frame(list(other_sources = varOther/varTotal,
                               Var_time = varTime/varTotal,
                               var_area = varArea/varTotal,
                               Total_var = varTotal,
                               original_var = varOrgi,
                               error = (varTotal-varOrgi)/varOrgi))
rownames(varFinal) <- c('bmal1','per2','tef','nr1d1','clock','cry1',
                       'nifl','rorc','nr1d2','per1','npas')
print(varFinal)
save.image('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/varDecomposition_fishData.RData')
write.csv(x = varFinal, file = 'D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/varDecomposition_allGenes.csv')
