library(dplyr)
library(stats)
library(MASS)
library(ODeGP)

# import burst parameters extracted from FiSH data.

bmal_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/bmal_nbinom.csv')
per2_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/per2_nbinom.csv')
tef_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/tef_nbinom.csv')
nr1d1_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/nr1d1_nbinom.csv')
clock_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/clock_nbinom.csv')
nifl_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/nifl_nbinom.csv')
rorc_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/rorc_nbinom.csv')
nr1d2_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/nr1d2_nbinom.csv')
npas_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/npas_nbinom.csv')
cry1_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/cry1_nbinom.csv')
per1_nbinom <- read.csv('D:/ShaonLab/fish_data/FISH_jul22/Final_datasheets/per1_nbinom.csv')

all_genes <- list('bmal' = bmal_nbinom,
                  'per2' = per2_nbinom,
                  'tef' = tef_nbinom,
                  'nr1d1' = nr1d1_nbinom,
                  'clock' = clock_nbinom,
                  'npas' = npas_nbinom,
                  'nifl' = nifl_nbinom,
                  'cry1' = cry1_nbinom,
                  'per1' = per1_nbinom,
                  'nr1d2' = nr1d2_nbinom,
                  'rorc' = rorc_nbinom)

SplineFit <- function(df){
  mean.ss <- smooth.spline(x = df[[2]], y = df[[3]])
  predictMean <- predict(mean.ss, c(8,12,20))
  size.ss <- smooth.spline(x = df[[2]], y = df[[5]])
  predictSize <- predict(size.ss, c(8,12,20))
  freq.ss <- smooth.spline(x = df[[2]], y = df[[6]])
  predictFreq <- predict(freq.ss, c(8,12,20))
  return(list('fitMean' = mean.ss, 'fitSize' = size.ss, 'fitFreq'= freq.ss, 
              'predicted mean' = predictMean, 
              'predicted size' = predictSize, 
              'predicted freq' = predictFreq))
}

SplineFit_allGenes <- lapply(all_genes, SplineFit)
# bmal_bfreq.ss <- smooth.spline(x = bmal_nbinom$time, y = bmal_nbinom$burst_freq)
plot(SplineFit_allGenes$bmal$fitMean$x, SplineFit_allGenes$bmal$fitMean$y, pch  = 16)
points(SplineFit_allGenes$bmal$`predicted mean`$x, SplineFit_allGenes$bmal$`predicted mean`$y, pch = 16, col = 'red')

plot(SplineFit_allGenes$bmal$fitFreq$x, SplineFit_allGenes$bmal$fitFreq$y, pch  = 16)
points(SplineFit_allGenes$bmal$`predicted freq`$x, SplineFit_allGenes$bmal$`predicted freq`$y, pch = 16, col = 'red')

plot(SplineFit_allGenes$bmal$fitSize$x, SplineFit_allGenes$bmal$fitSize$y, pch  = 16)
points(SplineFit_allGenes$bmal$`predicted size`$x, SplineFit_allGenes$bmal$`predicted size`$y, pch = 16, col = 'red')

