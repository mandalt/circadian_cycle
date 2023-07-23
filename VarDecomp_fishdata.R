library(MASS)
library(dplyr)
library(tidyverse)

# load('D:/ShaonLab/fish_data/FISH_jul22/bmal_per2_tef_rawdata.RData')
# load('D:/ShaonLab/fish_data/FISH_jul22/nr1d1_clock_cry1_rawdata.RData')
# load('D:/ShaonLab/fish_data/FISH_jul22/nifl_rorc_nr1d2_rawdata.RData')
# load('D:/ShaonLab/fish_data/FISH_jul22/per1_ciart_npas_rawdata.RData')

load('D:/ShaonLab/fish_data/saberfishrawdataaug2022/all_genes_nbiom_fit.RData')

list.df <- list(hr6_count, hr10_count, hr14_count, hr18_count, hr22_count, 
            hr26_count, hr29_count, hr34_count, hr38_count, hr42_count, 
            hr46_count, hr50_count, hr54_count)

all.df <- list.df %>% reduce(full_join)

norm_area <- function(areaData){
  return((areaData - min(areaData))/(max(areaData)-min(areaData)))
}

all.df$avg_Area <- rowMeans(all.df[ ,c(2,8,13,18)])
all.df$norm_Area <- round(norm_area(all.df$avg_Area), 4)

# test of normality
test.norm <- shapiro.test(all.df$avg_Area)
# Y1 = area, Y2 = time##############################################################################
# gives E(Z/Y1) and V(Z/Y1)

# bmal_per2_tef_df <- bmal_per2_tef %>% reduce(full_join)
# nr1d1_clock_cry1_df <- nr1d1_clock_cry1 %>% reduce(full_join)
# nifl_rorc_nr1d2_df <- nifl_rorc_nr1d2 %>% reduce(full_join)
# per1_ciart_npas_df <- per1_ciart_npas %>% reduce(full_join)

# bmal_per2_tef_df['normArea'] <- round(norm_area(bmal_per2_tef_df['AreaShape_Area']),4)
# nr1d1_clock_cry1_df['normArea'] <- round(norm_area(nr1d1_clock_cry1_df['AreaShape_Area']),4)
# nifl_rorc_nr1d2_df['normArea'] <- round(norm_area(nifl_rorc_nr1d2_df['AreaShape_Area']),4)
# per1_ciart_npas_df['normArea'] <- round(norm_area(per1_ciart_npas_df['AreaShape_Area']),4)
# plot(bmal_per2_tef_df$normArea, bmal_per2_tef_df$Children_bmal_spots_Count, pch = 16)

condArea <- all.df %>%
  group_by(norm_Area) %>%
  summarise(meanBmal1_count = mean(bmal1), 
            varBmal1 = var(bmal1), 
            meanPer2_count = mean(per2),
            varPer2 = var(per2),
            meanTef_count = mean(tef),
            varTef = var(tef),
            meanNr1d1_count = mean(nr1d1), 
            varNr1d1 = var(nr1d1), 
            meanClock_count = mean(clock),
            varClock = var(clock),
            meanCry1_count = mean(cry1),
            varCry1 = var(cry1),
            meanNifl_count = mean(nifl), 
            varNifl = var(nifl), 
            meanRorc_count = mean(rorc),
            varRorc = var(rorc),
            meanNr1d2_count = mean(nr1d2),
            varNr1d2 = var(nr1d2),
            meanPer1_count = mean(per1), 
            varPer1 = var(per1), 
            meanNpas_count = mean(npas),
            varNpas = var(npas))
  

condArea[sapply(condArea, is.na)]<- 0

plot(condArea$norm_Area, condArea$meanBmal1_count)
# varBmalArea <- var(condArea$meanBmal_count) + mean(condArea$varBmal)


# gives E(Z/Y1,Y2)
condAT <- all.df %>%
  group_by(norm_Area,time) %>%
  summarise(meanBmal1_count = mean(bmal1), 
            varBmal1 = var(bmal1), 
            meanPer2_count = mean(per2),
            varPer2 = var(per2),
            meanTef_count = mean(tef),
            varTef = var(tef),
            meanNr1d1_count = mean(nr1d1), 
            varNr1d1 = var(nr1d1), 
            meanClock_count = mean(clock),
            varClock = var(clock),
            meanCry1_count = mean(cry1),
            varCry1 = var(cry1),
            meanNifl_count = mean(nifl), 
            varNifl = var(nifl), 
            meanRorc_count = mean(rorc),
            varRorc = var(rorc),
            meanNr1d2_count = mean(nr1d2),
            varNr1d2 = var(nr1d2),
            meanPer1_count = mean(per1), 
            varPer1 = var(per1), 
            meanNpas_count = mean(npas),
            varNpas = var(npas))

  
condTA <- all.df %>%
  group_by(time, norm_Area) %>%
  summarise(meanBmal1_count = mean(bmal1), 
            varBmal1 = var(bmal1), 
            meanPer2_count = mean(per2),
            varPer2 = var(per2),
            meanTef_count = mean(tef),
            varTef = var(tef),
            meanNr1d1_count = mean(nr1d1), 
            varNr1d1 = var(nr1d1), 
            meanClock_count = mean(clock),
            varClock = var(clock),
            meanCry1_count = mean(cry1),
            varCry1 = var(cry1),
            meanNifl_count = mean(nifl), 
            varNifl = var(nifl), 
            meanRorc_count = mean(rorc),
            varRorc = var(rorc),
            meanNr1d2_count = mean(nr1d2),
            varNr1d2 = var(nr1d2),
            meanPer1_count = mean(per1), 
            varPer1 = var(per1), 
            meanNpas_count = mean(npas),
            varNpas = var(npas))




condAT[sapply(condAT, is.na)]<- 0

condTA[sapply(condTA, is.na)] <- 0

# gives V(E(Z/Y1,Y2)/Y1)
condATarea <- condAT %>%
  group_by(norm_Area) %>%
  summarise(meanBmal1 = mean(meanBmal1_count), 
            varBmal1 = var(meanBmal1_count), 
            meanPer2 = mean(meanPer2_count), 
            varPer2 = var(meanPer2_count),
            meanTef = mean(meanTef_count),
            varTef = var(meanTef_count),
            meanNr1d1 = mean(meanNr1d1_count), 
            varNr1d1 = var(meanNr1d1_count), 
            meanClock = mean(meanClock_count), 
            varClock = var(meanClock_count),
            meanCry1 = mean(meanCry1_count),
            varCry1 = var(meanCry1_count),
            meanNifl = mean(meanNifl_count), 
            varNifl = var(meanNifl_count), 
            meanRorc = mean(meanRorc_count), 
            varRorc = var(meanRorc_count),
            meanNr1d2 = mean(meanNr1d2_count),
            varNr1d2 = var(meanNr1d2_count),
            meanPer1 = mean(meanPer1_count), 
            varPer1 = var(meanPer1_count), 
            meanNpas = mean(meanNpas_count), 
            varNpas = var(meanNpas_count))


condATarea[sapply(condATarea, is.na)] <- 0

var1combBmal1 <- mean(condAT$varBmal1) + mean(condATarea$varBmal1) + var(condArea$meanBmal1_count)
var1combBmal1
var(all.df$bmal1)

# Y1 = time, Y2 = area##############################################################################
# gives E(Z/Y1) and V(Z/Y1)
condTime <- all.df %>%
  group_by(time) %>%
  summarise(meanBmal1_count = mean(bmal1), 
            varBmal1 = var(bmal1), 
            meanPer2_count = mean(per2),
            varPer2 = var(per2),
            meanTef_count = mean(tef),
            varTef = var(tef),
            meanNr1d1_count = mean(nr1d1), 
            varNr1d1 = var(nr1d1), 
            meanClock_count = mean(clock),
            varClock = var(clock),
            meanCry1_count = mean(cry1),
            varCry1 = var(cry1),
            meanNifl_count = mean(nifl), 
            varNifl = var(nifl), 
            meanRorc_count = mean(rorc),
            varRorc = var(rorc),
            meanNr1d2_count = mean(nr1d2),
            varNr1d2 = var(nr1d2),
            meanPer1_count = mean(per1), 
            varPer1 = var(per1), 
            meanNpas_count = mean(npas),
            varNpas = var(npas))


condTime[sapply(condTime, is.na)]<- 0


varBmalTime <- var(condTime$meanBmal1_count) + mean(condTime$varBmal1)
varBmalOrgi <- var(all.df$bmal1)

# gives V(E(Z/Y1,Y2)/Y1)
condATtime <- condAT %>%
  group_by(time) %>%
  summarise(meanBmal1 = mean(meanBmal1_count), 
            varBmal1 = var(meanBmal1_count), 
            meanPer2 = mean(meanPer2_count), 
            varPer2 = var(meanPer2_count),
            meanTef = mean(meanTef_count),
            varTef = var(meanTef_count),
            meanNr1d1 = mean(meanNr1d1_count), 
            varNr1d1 = var(meanNr1d1_count), 
            meanClock = mean(meanClock_count), 
            varClock = var(meanClock_count),
            meanCry1 = mean(meanCry1_count),
            varCry1 = var(meanCry1_count),
            meanNifl = mean(meanNifl_count), 
            varNifl = var(meanNifl_count), 
            meanRorc = mean(meanRorc_count), 
            varRorc = var(meanRorc_count),
            meanNr1d2 = mean(meanNr1d2_count),
            varNr1d2 = var(meanNr1d2_count),
            meanPer1 = mean(meanPer1_count), 
            varPer1 = var(meanPer1_count), 
            meanNpas = mean(meanNpas_count), 
            varNpas = var(meanNpas_count))



condATtime[sapply(condATtime, is.na)] <- 0

var2combBmal <- mean(condAT$varBmal1) + mean(condATtime$varBmal1) + var(condTime$meanBmal1_count)
var2combBmal


# variance from sources other than area and time###################################################
varOther <- c(mean(condAT$varBmal1),mean(condAT$varPer2), 
              mean(condAT$varTef), mean(condAT$varNr1d1),
              mean(condAT$varClock), mean(condAT$varCry1),
              mean(condAT$varNifl), mean(condAT$varRorc),
              mean(condAT$varNr1d2), mean(condAT$varPer1), 
              mean(condAT$varNpas))


# average variance from area
varArea <- c(0.5*(mean(condATtime$varBmal1)+
                    var(condArea$meanBmal1_count)),
             0.5*(mean(condATtime$varPer2)+
                    var(condArea$meanPer2_count)),
             0.5*(mean(condATtime$varTef) + 
                    var(condArea$meanTef_count)),
             0.5*(mean(condATtime$varNr1d1)+
                    var(condArea$meanNr1d1_count)),
             0.5*(mean(condATtime$varClock)+
                    var(condArea$meanClock_count)),
             0.5*(mean(condATtime$varCry1) + 
                    var(condArea$meanCry1_count)),
             0.5*(mean(condATtime$varNifl)+
                     var(condArea$meanNifl_count)),
              0.5*(mean(condATtime$varRorc)+
                     var(condArea$meanRorc_count)),
              0.5*(mean(condATtime$varNr1d2) + 
                     var(condArea$meanNr1d2_count)),
             0.5*(mean(condATtime$varPer1)+
                    var(condArea$meanPer1_count)),
             0.5*(mean(condATtime$varNpas)+
                    var(condArea$meanNpas_count)))




# average variance from time

varTime <- c(0.5*(mean(condATarea$varBmal1)+
                                  var(condTime$meanBmal1_count)),
                           0.5*(mean(condATarea$varPer2)+
                                  var(condTime$meanPer2_count)),
                           0.5*(mean(condATarea$varTef) + 
                                  var(condTime$meanTef_count)),
                           0.5*(mean(condATarea$varNr1d1)+
                                  var(condTime$meanNr1d1_count)),
                           0.5*(mean(condATarea$varClock)+
                                  var(condTime$meanClock_count)),
                           0.5*(mean(condATarea$varCry1) + 
                                  var(condTime$meanCry1_count)),
                           0.5*(mean(condATarea$varNifl)+
                                  var(condTime$meanNifl_count)),
                           0.5*(mean(condATarea$varRorc)+
                                  var(condTime$meanRorc_count)),
                           0.5*(mean(condATarea$varNr1d2) + 
                                  var(condTime$meanNr1d2_count)),
                           0.5*(mean(condATarea$varPer1)+
                                  var(condTime$meanPer1_count)),
                           0.5*(mean(condATarea$varNpas)+
                                  var(condTime$meanNpas_count)))



varOrgi <- diag(var(all.df[,c(5,4,1,16,15,12,11,10,7,20,17)]))

varOrgi
varTotal <- varArea + varTime + varOther

varTotal


varFinal <- as.data.frame(list(other_sources = varOther/varTotal,
                               Var_time = varTime/varTotal,
                               var_area = varArea/varTotal,
                               Total_var = varTotal,
                               original_var = varOrgi,
                               error = (varTotal-varOrgi)/varOrgi))
rownames(varFinal) <- c('bmal1','per2','tef','nr1d1','clock','cry1',
                       'nifl','rorc','nr1d2','per1','npas')
print(varFinal)
write.csv(x = varFinal, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/varDecomposition_allGenes.csv')

all.var <- c(varArea, varTime, varOther)
var.tags <- c(rep('area',11), rep('time', 11), rep('other',11))
gene <- rep(c('bmal1','per2','tef','nr1d1','clock','cry1','nifl','rorc','nr1d2','per1','npas'),3)
var.df <- data.frame(gene, all.var, var.tags)

p<- ggplot(var.df, aes(fill=var.tags, y=all.var, x=gene)) + geom_bar(position="stack", stat="identity")
p + labs(fill = 'source') + ylab('variance') + theme(legend.title = element_text(size = 14),axis.title.x = element_text(size = 14), axis.title.y = element_text(size = 14))

save.image('D:/ShaonLab/fish_data/saberfishrawdataaug2022/varDecomposition.RData')
