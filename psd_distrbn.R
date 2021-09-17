df<-read.csv("multiSer_bmalp2.csv", header = TRUE)
#columns<- colnames(df)
y<-rep(NA, 100)

for (i in 1:100){
  data<-df[[i]]
  psd=spectrum(data, log="no")
  max_int<-max(psd$spec)
  x<-which(psd$spec==max_int)
  y[i]<-psd$freq[x]
  }

