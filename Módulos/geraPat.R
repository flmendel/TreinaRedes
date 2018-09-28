geraPat<-function(entrada,saida,nomePat)
{
   #Função que recebe uma matriz de entrada e uma de saida,
   #gera o arquivo de padrão do SNNS e salva ele no endereço contido em nomePat.   

   cat("SNNS pattern definition file V3.2\n",file=nomePat)
   cat("generated at ",date(),"\n",file=nomePat,append=T)
   cat("\n\n",file=nomePat,append=T)
   cat("No. of patterns : ",nrow(entrada),"\n",file=nomePat,append=T)
   cat("No. of input units : ",ncol(entrada),"\n",file=nomePat,append=T)
   cat("No. of output units : ",ncol(saida),"\n",file=nomePat,append=T)
   cat("\n",file=nomePat,append=T)

   for (i in 1:nrow(entrada))
   {
      cat("# Input pattern ",i,"\n",file=nomePat,append=T)
      cat(entrada[i,],"\n",file=nomePat,append=T)
      cat("# Output pattern ",i,"\n",file=nomePat,append=T)
      cat(saida[i,],"\n",file=nomePat,append=T)
   }
}