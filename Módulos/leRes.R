leRes<-function(nomeRes,nEntrada, nSaida)
{
   res<-readLines(nomeRes)
   res<-res[grep("^[0-9-]",res)]
   res<-strsplit(res,"[ ]+")

   dados<-NULL
   entrada<-NULL
   pat<-NULL
   saida<-NULL

   for (i in 1:length(res))
   {
      dados<-c(dados,as.numeric(res[[i]]))
   }

   while(length(dados)>0)
   {
      entrada<-rbind(entrada,dados[1:nEntrada])      
      dados<-dados[-(1:nEntrada)]
      pat<-rbind(pat,dados[1:nSaida])      
      dados<-dados[-(1:nSaida)]
      saida<-rbind(saida,dados[1:nSaida])
      dados<-dados[-(1:nSaida)]
   }

   saida<-list(entrada,saida,pat)
   names(saida)<-c("entrada","saida","pattern")
   saida
}