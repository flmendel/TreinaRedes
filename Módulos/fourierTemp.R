#Módulo criado por Fernando Mendel
#Converte de fourier-->temperatura
#cada gaussiana deve estar em uma linha, totalizando 8 colunas e n linhas

fourierTemp<-function(dados)
{

   res<-matrix(0,nrow(dados),8)

   res[,1]<-complex(real=dados[,1])
   res[,2]<-complex(real=dados[,2],imaginary=-dados[,6])
   res[,3]<-complex(real=dados[,3],imaginary=-dados[,7])
   res[,4]<-complex(real=dados[,4],imaginary=-dados[,8])
   res[,5]<-complex(real=dados[,5])
   res[,6]<-Conj(res[,4])
   res[,7]<-Conj(res[,3])
   res[,8]<-Conj(res[,2])

   temp=NULL
   for (i in 1:nrow(res))
   {
      temp<-rbind(temp, fft(res[i,]/8,inverse=TRUE) )
   }
   temp
}