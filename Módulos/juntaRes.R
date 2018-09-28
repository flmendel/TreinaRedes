juntaRes<-function(hidden,inicializacao,epocas,shortcut,nDadosIn,nDadosOut,sufixo="",variacao_sufixo=NULL)
{
   #le os arquivos res e gera uma matriz com todos os dados
   #entrada // pat // saida
   #o sufixo é ex: *tenfold_
   #variacao do sufixo é *tenfold1 *tenfold2

   source("c:\\TreinaRedes\\Módulos\\leRes.R",local=T)

   entrada<-NULL
   saida<-NULL
   pattern<-NULL

   if (sufixo=="")
   {
      nomeRes<-paste("rede_h",hidden,"_i",inicializacao,"_epc",epocas,"_",shortcut,".res",sep="")
      dados<-leRes(nomeRes,nDadosIn,nDadosOut)
      entrada<-rbind(entrada,dados$entrada)
      saida<-rbind(saida,dados$saida)
      pattern<-rbind(pattern,dados$pattern)
   }
   else
   {
      for (i in variacao_sufixo)
      {
         nomeRes<-paste("rede_h",hidden,"_i",inicializacao,"_epc",epocas,"_",shortcut,"_",sufixo,"_",i,".res",sep="")

         dados<-leRes(nomeRes,nDadosIn,nDadosOut)
         entrada<-rbind(entrada,dados$entrada)
         saida<-rbind(saida,dados$saida)
         pattern<-rbind(pattern,dados$pattern)
      }
  }

  saida<-list(entrada,saida,pattern)
  names(saida)<-c("entrada","saida","pattern")
  saida   
}