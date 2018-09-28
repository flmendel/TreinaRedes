tenFold<-function(dados_in,dados_out,epocas=c(1000,2000,5000),inicializacao=0:9,hidden=c(0,1,2,4,8,16),shortcut=c(T,F),erros=c(RMS=T,erroSaida=F,precTotal=F,espec=F,sens=F,acertos=T))
{
   setwd("C:\\TreinaRedes\\TenFold\\")
   source("C:\\TreinaRedes\\Módulos\\separaDados.r",local=T)

   dados<-separaDados(dados_in,dados_out,10)

   source("c:\\TreinaRedes\\Módulos\\treinaRprop.R",local=T)

   for (i in 1:10)
   {
      treinaRprop(dados[[i]]$treinoIn,dados[[i]]$treinoOut,dados[[i]]$testeIn,dados[[i]]$testeOut,epocas,inicializacao,hidden,shortcut,"tenFold",i)
   }

   #percorre todos as inicializacoes, epocas e hidden e gera a matriz
   source("C:\\TreinaRedes\\Módulos\\leResTenFold.R",local=T)  
   resultado<-leResTenFold(hidden,inicializacao,epocas,shortcut,ncol(as.matrix(dados_in)),ncol(as.matrix(dados_out)),erros)
   

   resultado
}