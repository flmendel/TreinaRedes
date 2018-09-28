#Módulo criado por Fernando Mendel
#Treina uma rede e salva e .net e o .res

treinaRede <- function(treinoIn,treinoOut,testeIn,testeOut,epocas,i,hidden,shortcut,nomeArq="",path="C:\\TreinaRedes\\")
{
   #treina a rede uma vez com determinada configuração

   #converte para matrizes
   testeIn<-as.matrix(testeIn)
   testeOut<-as.matrix(testeOut)
   treinoIn<-as.matrix(treinoIn)
   treinoOut<-as.matrix(treinoOut)

   source("C:\\TreinaRedes\\Módulos\\geraPat.R",local=T)

   #gera os pat
   geraPat(treinoIn,treinoOut,paste(path,"treino.pat",sep=""))
   geraPat(testeIn,testeOut,paste(path,"teste.pat",sep=""))

   #gera o arquivo de treino a ser chamado pelo batchman
   
   cat("#Arquivo de treino do SNNS gerado automaticamente pelo R\n",file=paste(path,"treino.txt",sep=""),append=F)
   cat("#Epocas: ",epocas,"\n",file=paste(path,"treino.txt",sep=""),append=T)
   cat("#Hidden: ",hidden,"\n",file=paste(path,"treino.txt",sep=""),append=T)
   cat("#Inicializacao: ",i,"\n\n\n",file=paste(path,"treino.txt",sep=""),append=T)

redeAtual<-paste("C:\\TreinaRedes\\TOPOLOGIAS\\","rede_",ncol(as.matrix(treinoIn)),"_",hidden,"_",ncol(as.matrix(treinoOut)),"_",shortcut,".net",sep="")

   cat("loadNet(\"",redeAtual,"\")\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("loadPattern(\"",path,"teste.pat","\")\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("loadPattern(\"",path,"treino.pat","\")\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("setShuffle(TRUE)\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("setInitFunc(\"Randomize_Weights\",1.0, -1.0)\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("setLearnFunc(\"Rprop\", 0.1, 50.0, 4.0)\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("setSeed(",i,")\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("initNet()\n\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")

   cat("for epocas=1 to ",epocas," do\n",file=paste(path,"treino.txt",sep=""),append=T)
      cat("   trainNet()\n",file=paste(path,"treino.txt",sep=""),append=T)
   cat("endfor\n",file=paste(path,"treino.txt",sep=""),append=T)

   cat("setPattern(\"",path,"teste.pat","\")\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   cat("testNet()\n",file=paste(path,"treino.txt",sep=""),append=T)

   if (nomeArq!="")
   {
      cat("saveNet(\"",path,nomeArq,".net\")\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
      cat("saveResult(\"",path,nomeArq,".res\",1,PAT, TRUE, TRUE, \"create\")\n",file=paste(path,"treino.txt",sep=""),append=T,sep="")
   }

   #chama o batchman do SNNS

   system(paste("batchman -q -f ",path,"treino.txt",sep=""))
}