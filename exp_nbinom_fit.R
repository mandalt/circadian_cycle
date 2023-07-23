library(MASS)
library(dplyr)
library(tidyverse)


# read the files.

hr6_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 6hrs"))
hr10_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 10hrs"))
hr14_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 14hrs"))
hr18_count <- read.csv(choose.files(default = "", 
                                    caption = "select file for 18hrs"))
hr22_count <- read.csv(choose.files(default = "", 
                                    caption = "select file for 22hrs"))
hr26_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 26hrs"))
hr29_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 29hrs"))
hr34_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 34hrs"))
hr38_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 38hrs"))
hr42_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 42hrs"))
hr46_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 46hrs"))
hr50_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 50hrs"))
hr54_count <- read.csv(choose.files(default = "", 
                                   caption = "select file for 54hrs"))

# load the test data
# hr8_count <- read.csv(choose.files(default = "", 
#                                    caption = "select file 8hrs_cell"))
# hr12_count <- read.csv(choose.files(default = "", 
#                                    caption = "select file 12hrs_cell"))
# hr20_count <- read.csv(choose.files(default = "", 
#                                    caption = "select file 20hrs_cell"))


bmal <- list(hrs6 = hr6_count$bmal1,
             hrs10 = hr10_count$bmal1,
             hrs14 = hr14_count$bmal1,
             hrs18 = hr18_count$bmal1,
             hrs22 = hr22_count$bmal1,
             hrs26 = hr26_count$bmal1,
             hrs29 = hr29_count$bmal1,
             hrs34 = hr34_count$bmal1,
             hrs38 = hr38_count$bmal1,
             hrs42 = hr42_count$bmal1,
             hrs46 = hr46_count$bmal1,
             hrs50 = hr50_count$bmal1,
             hrs54 = hr54_count$bmal1)

# bmal_test <- list(hrs8 = hr8_count$Children_bmal_spots_Count,
#                   hrs12 = hr12_count$Children_bmal_spots_Count,
#                   hrs20 = hr20_count$Children_bmal_spots_Count)

per2 <- list(hrs6 = hr6_count$per2,
            hrs10 = hr10_count$per2,
            hrs14 = hr14_count$per2,
            hrs18 = hr18_count$per2,
            hrs22 = hr22_count$per2,
            hrs26 = hr26_count$per2,
            hrs29 = hr29_count$per2,
            hrs34 = hr34_count$per2,
            hrs38 = hr38_count$per2,
            hrs42 = hr42_count$per2,
            hrs46 = hr46_count$per2,
            hrs50 = hr50_count$per2,
            hrs54 = hr54_count$per2)

# per2_test <- list(hrs8 = hr8_count$Children_per2_spots_Count,
#                   hrs12 = hr12_count$Children_per2_spots_Count,
#                   hrs20 = hr20_count$Children_per2_spots_Count)

tef <- list(hrs6 = hr6_count$tef,
             hrs10 = hr10_count$tef,
             hrs14 = hr14_count$tef,
             hrs18 = hr18_count$tef,
             hrs22 = hr22_count$tef,
             hrs26 = hr26_count$tef,
             hrs29 = hr29_count$tef,
            hrs34 = hr34_count$tef,
            hrs38 = hr38_count$tef,
            hrs42 = hr42_count$tef,
            hrs46 = hr46_count$tef,
            hrs50 = hr50_count$tef,
            hrs54 = hr54_count$tef)

# tef_test <- list(hrs8 = hr8_count$Children_tef_spots_Count,
#                  hrs12 = hr12_count$Children_tef_spots_Count,
#                  hrs20 = hr20_count$Children_tef_spots_Count)

nr1d1 <- list(hrs6 = hr6_count$nr1d1,
              hrs10 = hr10_count$nr1d1,
              hrs14 = hr14_count$nr1d1,
              hrs18 = hr18_count$nr1d1,
              hrs22 = hr22_count$nr1d1,
              hrs26 = hr26_count$nr1d1,
              hrs29 = hr29_count$nr1d1,
              hrs34 = hr34_count$nr1d1,
              hrs38 = hr38_count$nr1d1,
              hrs42 = hr42_count$nr1d1,
              hrs46 = hr46_count$nr1d1,
              hrs50 = hr50_count$nr1d1,
              hrs54 = hr54_count$nr1d1)
# 
# nr1d1_test <- list(hrs8 = hr8_count$Children_nr1d1_spots_Count,
#                  hrs12 = hr12_count$Children_nr1d1_spots_Count,
#                  hrs20 = hr20_count$Children_nr1d1_spots_Count)

clock <- list(hrs6 = hr6_count$clock,
              hrs10 = hr10_count$clock,
              hrs14 = hr14_count$clock,
              hrs18 = hr18_count$clock,
              hrs22 = hr22_count$clock,
              hrs26 = hr26_count$clock,
              hrs29 = hr29_count$clock,
              hrs34 = hr34_count$clock,
              hrs38 = hr38_count$clock,
              hrs42 = hr42_count$clock,
              hrs46 = hr46_count$clock,
              hrs50 = hr50_count$clock,
              hrs54 = hr54_count$clock)

# clock_test <- list(hrs8 = hr8_count$Children_clock_spots_Count,
#                  hrs12 = hr12_count$Children_clock_spots_Count,
#                  hrs20 = hr20_count$Children_clock_spots_Count)

cry1 <- list(hrs6 = hr6_count$cry1,
             hrs10 = hr10_count$cry1,
             hrs14 = hr14_count$cry1,
             hrs18 = hr18_count$cry1,
             hrs22 = hr22_count$cry1,
             hrs26 = hr26_count$cry1,
             hrs29 = hr29_count$cry1,
             hrs34 = hr34_count$cry1,
             hrs38 = hr38_count$cry1,
             hrs42 = hr42_count$cry1,
             hrs46 = hr46_count$cry1,
             hrs50 = hr50_count$cry1,
             hrs54 = hr54_count$cry1)

# cry1_test <- list(hrs8 = hr8_count$Children_cry1_spots_Count,
#                  hrs12 = hr12_count$Children_cry1_spots_Count,
#                  hrs20 = hr20_count$Children_cry1_spots_Count)

nifl <- list(hrs6 = hr6_count$nifl,
             hrs10 = hr10_count$nifl,
             hrs14 = hr14_count$nifl,
             hrs18 = hr18_count$nifl,
             hrs22 = hr22_count$nifl,
             hrs26 = hr26_count$nifl,
             hrs29 = hr29_count$nifl,
             hrs34 = hr34_count$nifl,
             hrs38 = hr38_count$nifl,
             hrs42 = hr42_count$nifl,
             hrs46 = hr46_count$nifl,
             hrs50 = hr50_count$nifl,
             hrs54 = hr54_count$nifl)

# nifl_test <- list(hrs8 = hr8_count$Children_nifl_spots_Count,
#                   hrs12 = hr12_count$Children_nifl_spots_Count,
#                   hrs20 = hr20_count$Children_nifl_spots_Count)


rorc <- list(hrs6 = hr6_count$rorc,
             hrs10 = hr10_count$rorc,
             hrs14 = hr14_count$rorc,
             hrs18 = hr18_count$rorc,
             hrs22 = hr22_count$rorc,
             hrs26 = hr26_count$rorc,
             hrs29 = hr29_count$rorc,
             hrs34 = hr34_count$rorc,
             hrs38 = hr38_count$rorc,
             hrs42 = hr42_count$rorc,
             hrs46 = hr46_count$rorc,
             hrs50 = hr50_count$rorc,
             hrs54 = hr54_count$rorc)

# rorc_test <- list(hrs8 = hr8_count$Children_rorc_spots_Count,
#                   hrs12 = hr12_count$Children_rorc_spots_Count,
#                   hrs20 = hr20_count$Children_rorc_spots_Count)

nr1d2 <- list(hrs6 = hr6_count$nr1d2,
             hrs10 = hr10_count$nr1d2,
             hrs14 = hr14_count$nr1d2,
             hrs18 = hr18_count$nr1d2,
             hrs22 = hr22_count$nr1d2,
             hrs26 = hr26_count$nr1d2,
             hrs29 = hr29_count$nr1d2,
             hrs34 = hr34_count$nr1d2,
             hrs38 = hr38_count$nr1d2,
             hrs42 = hr42_count$nr1d2,
             hrs46 = hr46_count$nr1d2,
             hrs50 = hr50_count$nr1d2,
             hrs54 = hr54_count$nr1d2)

# nr1d2_test <- list(hrs8 = hr8_count$Children_nr1d2_spots_Count,
#                   hrs12 = hr12_count$Children_nr1d2_spots_Count,
#                   hrs20 = hr20_count$Children_nr1d2_spots_Count)

per1 <- list(hrs6 = hr6_count$per1,
     hrs10 = hr10_count$per1,
     hrs14 = hr14_count$per1,
     hrs18 = hr18_count$per1,
     hrs22 = hr22_count$per1,
     hrs26 = hr26_count$per1,
     hrs29 = hr29_count$per1,
     hrs34 = hr34_count$per1,
     hrs38 = hr38_count$per1,
     hrs42 = hr42_count$per1,
     hrs46 = hr46_count$per1,
     hrs50 = hr50_count$per1,
     hrs54 = hr54_count$per1)

# per1_test <- list(hrs8 = hr8_count$Children_per1_spots_Count,
#                    hrs12 = hr12_count$Children_per1_spots_Count,
#                    hrs20 = hr20_count$Children_per1_spots_Count)

npas <- list(hrs6 = hr6_count$npas,
             hrs10 = hr10_count$npas,
             hrs14 = hr14_count$npas,
             hrs18 = hr18_count$npas,
             hrs22 = hr22_count$npas,
             hrs26 = hr26_count$npas,
             hrs29 = hr29_count$npas,
             hrs34 = hr34_count$npas,
             hrs38 = hr38_count$npas,
             hrs42 = hr42_count$npas,
             hrs46 = hr46_count$npas,
             hrs50 = hr50_count$npas,
             hrs54 = hr54_count$npas)

# npas_test <- list(hrs8 = hr8_count$Children_npas_spots_Count,
#                    hrs12 = hr12_count$Children_npas_spots_Count,
#                    hrs20 = hr20_count$Children_npas_spots_Count)


timepoints <- c(seq(6,27,4),29, seq(34,54,4))
test_time <- c(8,12,20)

fit_binom <- function(geneData, time = timepoints){
  nbinom.data <- matrix(, nrow = length(geneData), ncol = 8)
  for (i in 1:length(geneData)){
    hist(geneData[[i]], breaks=20, probability = T, xlab = 'count/cell', ylab = 'density', main = paste('Nbinom at',timepoints[i],'hrs'))
    ff <- fitdistr(geneData[[i]], "Negative Binomial", lower = c(0.1,0))
    size_param <- ff$estimate[1]
    mu_param <- as.numeric(ff$estimate[2])
    cv <- as.numeric(sqrt(1/ff$estimate[2] + 1/ff$estimate[1]))
    lines(seq(0,150,1), y = dnbinom(seq(0,150,1), size =  ff$estimate[1],mu = ff$estimate[2]), col = 'red')
    nbinom.data[i,2:8] <- c(mu_param, as.numeric(ff$sd[2]), size_param, as.numeric(ff$sd[1]), cv, as.numeric(mu_param/size_param), as.numeric(size_param))
    nbinom.data[,1] <- timepoints
    colnames(nbinom.data) <- c('time','mean', 'mean.std_error', 'size', 'size.std_error', 'CV','burst_size','burst_freq')
  }
  return(nbinom.data)
}

bmal1.nbinom <- fit_binom(bmal)
per2.nbinom <- fit_binom(per2)
tef.nbinom <- fit_binom(tef)

nr1d1.nbinom <- fit_binom(nr1d1)
clock.nbinom <- fit_binom(clock)
cry1.nbinom <- fit_binom(cry1)

nifl.nbinom <- fit_binom(nifl)
rorc.nbinom <- fit_binom(rorc)
nr1d2.nbinom <- fit_binom(nr1d2)

per1.nbinom <- fit_binom(per1)
npas.nbinom <- fit_binom(npas)

# write.csv(bmal1.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/bmal1_nbiom.csv')
# write.csv(per2.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/per2_nbiom.csv')
# write.csv(tef.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/tef_nbiom.csv')
# write.csv(nr1d1.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/nr1d1_nbiom.csv')
# write.csv(clock.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/clock_nbiom.csv')
# write.csv(cry1.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/cry1_nbiom.csv')
# write.csv(nifl.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/nifl_nbiom.csv')
# write.csv(rorc.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/rorc_nbiom.csv')
# write.csv(nr1d2.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/nr1d2_nbiom.csv')
# write.csv(per1.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/per1_nbiom.csv')
# write.csv(npas.nbinom, file = 'D:/ShaonLab/fish_data/saberfishrawdataaug2022/npas_nbiom.csv')

hr6_count$time <- rep(6, length(hr6_count[[1]]))
hr10_count$time <- rep(10, length(hr10_count[[1]]))
hr14_count$time <- rep(14, length(hr14_count[[1]]))
hr18_count$time <- rep(18, length(hr18_count[[1]]))
hr22_count$time <- rep(22, length(hr22_count[[1]]))
hr26_count$time <- rep(26, length(hr26_count[[1]]))
hr29_count$time <- rep(29, length(hr29_count[[1]]))
hr34_count$time <- rep(34, length(hr34_count[[1]]))
hr38_count$time <- rep(38, length(hr38_count[[1]]))
hr42_count$time <- rep(42, length(hr42_count[[1]]))
hr46_count$time <- rep(46, length(hr46_count[[1]]))
hr50_count$time <- rep(50, length(hr50_count[[1]]))
hr54_count$time <- rep(54, length(hr54_count[[1]]))

save.image('D:/ShaonLab/fish_data/saberfishrawdataaug2022/all_genes_nbiom_fit.RData')
