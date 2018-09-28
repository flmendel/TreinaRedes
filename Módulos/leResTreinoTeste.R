leResTreinoTeste<-function(hidden,inicializacao,epocas,shortcut,nDadosIn,nDadosOut,erros)
{
   setwd("C:\\TreinaRedes\\TreinoTeste\\RESFILES\\")
   tabela<-NULL
   colunasConfusao<-NULL

   source("C:\\TreinaRedes\\Módulos\\juntaRes.R",local=T)
   source("C:\\TreinaRedes\\Módulos\\erros.R",local=T)
   source("C:\\TreinaRedes\\Módulos\\geraConfusao.R",local=T)

   for (h in hidden)
   {
      for (ini in inicializacao)
      {
         for (epc in epocas)
         {
             for (short in shortcut)
             {
                dados<-juntaRes(h,ini,epc,short,nDadosIn,nDadosOut)
                conf<-geraConfusao(dados$pattern,dados$saida)
                colunasConfusao<-ncol(conf)
                saidas<-t(as.matrix(c(h,ini,epc,short)))

                if (erros[1])
                {
                   saidas<-cbind(saidas,RMS(dados$saida,dados$pattern))
                }
   
                if (erros[2])
                {
                   saidas<-cbind(saidas,precisaoTotal(conf))
                }
   
                if (erros[3])               
                {
                   saidas<-cbind(saidas,t(as.matrix(erroSaidas(dados$saida,dados$pattern))))
                }
   
                if (erros[4])
                {
                   saidas<-cbind(saidas,especificidade(conf))
                } 
   
                if (erros[5])
                   {
                   saidas<-cbind(saidas,sensitividade(conf))
                }
                if (erros[6])
                {
                   saidas<-cbind(saidas,acertos(conf))
                } 
            
                tabela<-rbind(tabela,saidas)
            }
         }
      }
   }
   colnames(tabela)<-1:ncol(tabela)
   colnames(tabela)[1:4]<-c("hidden","inicializacao","epocas","shortcut")
   posAtual<-5

   if (erros[1])
   {
      colnames(tabela)[posAtual]<-"RMS"
      posAtual<-posAtual+1
   }

   if (erros[2])
   {
      colnames(tabela)[posAtual]<-"Precisão Total"
      posAtual<-posAtual+1
   }

   if (erros[3])
   {
      txtSaida<-paste("saida",1:colunasConfusao,sep="")
      colnames(tabela)[posAtual:(posAtual+(colunasConfusao-1))]<-txtSaida
      posAtual<-posAtual+colunasConfusao
   }
   if (erros[4])
   {
      txtSaida<-paste("espec",1:colunasConfusao,sep="")
      colnames(tabela)[posAtual:(posAtual+(colunasConfusao-1))]<-txtSaida
      posAtual<-posAtual+colunasConfusao
   }
   if (erros[5]) 
   {
      txtSaida<-paste("sens",1:colunasConfusao,sep="")
      colnames(tabela)[posAtual:(posAtual+(colunasConfusao-1))]<-txtSaida
      posAtual<-posAtual+colunasConfusao
   }
   if (erros[6])
   {
      colnames(tabela)[posAtual]<-"Acertos"
   }

   tabela
}