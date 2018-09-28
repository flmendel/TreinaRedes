#Módulo para normalizar/desnormalizar os dados
# criado por Fernando Luis Mendel

calculaDesvioMedia<-function(dados,path_media="media",path_desvio="desvio")
{
   media<-rep(0,ncol(dados))
   desvio<-rep(0,ncol(dados)) 

   for (i in 1:ncol(dados))
   {
      desvio[i] <- sd(dados[,i])
      media[i] <- mean(dados[,i])
   }

   write.table(media,file=paste(path_media,".txt",sep=""),row.names=F, col.names=F)
   write.table(desvio,file=paste(path_desvio,".txt",sep=""),row.names=F, col.names=F)
}

normaliza <- function(dados,path_media="media",path_desvio="desvio")
{
   #carrega medias e desvios
   media<-as.matrix( read.table(paste(path_media,".txt",sep="")) )
   desvio<-as.matrix( read.table(paste(path_desvio,".txt",sep="")) )

   normalizado<- matrix(0,nrow(dados),ncol(dados))

   for (i in 1:ncol(dados))
   {
      normalizado[,i] <- (dados[,i] - media[i])/desvio[i]
   }
   normalizado
}

desnormaliza<-function(dados,path_media="media",path_desvio="desvio")
{
   #carrega medias e desvios
   media<-as.matrix( read.table(paste(path_media,".txt",sep="")))
   desvio<-as.matrix( read.table(paste(path_desvio,".txt",sep="")) )

   desnormalizado <- matrix(0,nrow(dados),ncol(dados))

   for (i in 1:ncol(dados))
   {
      desnormalizado[,i] <- dados[,i]* desvio[i] + media[i]
   }

   desnormalizado
}