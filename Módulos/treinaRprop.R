#metodos:
#tenFold
#treinoTeste

treinaRprop<-function(treinoIn,treinoOut,testeIn,testeOut,epocas,inicializacoes,hidden,shortcut,metodo,numTenFold=NULL)
{
   setwd(paste("C:\\TreinaRedes\\",metodo,sep=""))
    
   #converte as listas para matrizes

   treinoIn<-as.matrix(treinoIn)
   treinoOut<-as.matrix(treinoOut)
   testeIn<-as.matrix(testeIn)
   testeOut<-as.matrix(testeOut)

   source("C:\\TreinaRedes\\Módulos\\geraPat.R",local=T)

   geraPat(treinoIn,treinoOut,"treino.pat")
   geraPat(testeIn,testeOut,"teste.pat")

   for (h in hidden)
   {
      for (ini in inicializacoes)
      {
         for (epc in epocas)
         {
            for (short in shortcut)
            { 
               chamaRprop(epc,ini,h,ncol(treinoIn),ncol(treinoOut),short,metodo,numTenFold)
            }
         }
      }
   }
}

chamaRprop <- function(epocas,inicializacao,hidden,nEntradas,nSaidas,shortcut,metodo,numTenFold)
{
   #treina a rede uma vez com determinada configuração
   #o arquivo de treino e deste devem ter estes nomes e dentro de path

   #gera o arquivo de treino a ser chamado pelo batchman
   
   cat("#Arquivo de treino do SNNS gerado automaticamente pelo R\n",file="treino.txt",append=F)
   cat("#Epocas: ",epocas,"\n",file="treino.txt",append=T)
   cat("#Hidden: ",hidden,"\n",file="treino.txt",append=T)
   cat("#Inicializacao: ",inicializacao,"\n\n\n",file="treino.txt",append=T)

redeAtual<-paste("C:\\TreinaRedes\\TOPOLOGIAS\\","rede_",nEntradas,"_",hidden,"_",nSaidas,"_",shortcut,".net",sep="")

   path=paste(getwd(),"\\",sep="")

   cat("loadNet(\"",redeAtual,"\")\n",file="treino.txt",append=T,sep="")
   cat("loadPattern(\"",path,"teste.pat","\")\n",file="treino.txt",append=T,sep="")
   cat("loadPattern(\"",path,"treino.pat","\")\n",file="treino.txt",append=T,sep="")
   cat("setShuffle(TRUE)\n",file="treino.txt",append=T,sep="")
   cat("setInitFunc(\"Randomize_Weights\",1.0, -1.0)\n",file="treino.txt",append=T,sep="")
   cat("setLearnFunc(\"Rprop\", 0.1, 50.0, 4.0)\n",file="treino.txt",append=T,sep="")
   cat("setSeed(",inicializacao,")\n",file="treino.txt",append=T,sep="")
   cat("initNet()\n\n",file="treino.txt",append=T,sep="")

   cat("for epocas=1 to ",epocas," do\n",file="treino.txt",append=T)
      cat("   trainNet()\n",file="treino.txt",append=T)
   cat("endfor\n",file="treino.txt",append=T)

   cat("setPattern(\"",path,"teste.pat","\")\n",file="treino.txt",append=T,sep="")
   cat("testNet()\n",file="treino.txt",append=T)

   if (metodo=="treinoTeste")
   {
      cat("saveResult(\"",path,"RESFILES\\\"+\"rede_h",hidden,"_i",inicializacao,"_epc",epocas,"_",shortcut,".res\",1,PAT, TRUE, TRUE, \"create\")\n",file="treino.txt",append=T,sep="")
   }
   
   if (metodo=="tenFold")
   {
      cat("saveResult(\"",path,"RESFILES\\\"+\"rede_h",hidden,"_i",inicializacao,"_epc",epocas,"_",shortcut,"_tenfold_",numTenFold,".res\",1,PAT, TRUE, TRUE, \"create\")\n",file="treino.txt",append=T,sep="")
   }

   #chama o batchman do SNNS

   system(paste("batchman -q -f ",path,"treino.txt",sep=""))
}