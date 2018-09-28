#Módulo criado por Fernando Luis Mendel
#recebe uma matriz de treino de entrada, treino saida, teste entrada e teste saida
#para rodar chame o método treinoTeste

treinoTeste<-function(treinoIn,treinoOut,testeIn,testeOut,epocas=c(1000,2000,5000),i=1:10,hidden=c(0,1,2,4,8,16),shortcut=c(T,F),erros=c(RMS=T,erroSaida=F,precTotal=F,espec=F,sens=F,acertos=T))
{
   setwd("C:\\TreinaRedes\\TreinoTeste\\")

   source("C:\\TreinaRedes\\Módulos\\treinaRprop.R",local=T)

   treinaRprop(treinoIn,treinoOut,testeIn,testeOut,epocas,i,hidden,shortcut,"treinoTeste")

   source("C:\\TreinaRedes\\Módulos\\leResTreinoTeste.R",local=T)

   resultado<-leResTreinoTeste(hidden,i,epocas,shortcut,ncol(as.matrix(testeIn)),ncol(as.matrix(testeOut)),erros)
   resultado
}
