geraConfusao<-function(saidaPat,saidaRede)
{
   confusao<-matrix(0,ncol(saidaPat),ncol(saidaPat))

   for(i in 1:nrow(saidaPat))
   {
      for (j in 1:ncol(saidaPat))
      {
         if(saidaPat[i,j]<=0.5)
         {
            saidaPat[i,j]<-0
         }
         if(saidaPat[i,j]>0.5)
         {
            saidaPat[i,j]<-1
         }         
         if(saidaRede[i,j]<=0.5)
         {
            saidaRede[i,j]<-0
         }
         if(saidaRede[i,j]>0.5)
         {
            saidaRede[i,j]<-1
         }
      }
      confusao[which.max(saidaPat[i,]),which.max(saidaRede[i,])]<-confusao[which.max(saidaPat[i,]),which.max(saidaRede[i,])]+1


   }

   confusao
}
