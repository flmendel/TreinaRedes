RMS<-function(saidaRede,saidaPattern)
{
   sqrt(mean((saidaRede-saidaPattern)*(saidaRede-saidaPattern)))
}

erroSaidas<-function(saidaRede,saidaPattern)
{
   saida<-rep(0,ncol(saidaRede))

   for (i in 1:ncol(saidaRede))
   {
      saida[i] <- sqrt(mean((saidaRede[,i]-saidaPattern[,i])^2)) / sd(saidaPattern[,i])
   } 
   saida
} 

precisaoTotal<-function(confusao)
{
   acerto<-0

   for (i in 1:ncol(confusao))
   {
      for (j in 1:nrow(confusao))
      {
         if (i==j)
         {
            acerto<-acerto+confusao[i,j]
         }
      }
   }
   acerto/sum(confusao)
}

sensitividade<-function(confusao)
{
   sensitividade<-NULL

   for (i in 1:nrow(confusao))
   {
      vp<-confusao[i,i]
      fp<-confusao[-i,i]
      vn<-confusao[-i,-i]
      fn<-confusao[i,-i]

      sensitividade<-cbind(sensitividade,vp/(vp+sum(fn)))
   }
   sensitividade
       
}

especificidade<-function(confusao)
{
   #esp = Verdadeiros negativos / (Verdadeiros negativos + Falsos positivos)
   especificidade<-NULL

   for (i in 1:nrow(confusao))
   {
      vp<-confusao[i,i]
      fp<-confusao[-i,i]
      vn<-confusao[-i,-i]
      fn<-confusao[i,-i]

      especificidade<-cbind(especificidade,sum(vn)/(sum(vn)+sum(fp)))
   }
   especificidade
}
acertos<-function(confusao)
{
   #calcula o numero de acertos a partir da diagonal principal
   soma<-0
   for (i in 1:nrow(confusao))
   {
      soma<-soma+confusao[i,i]
   }
   soma
}