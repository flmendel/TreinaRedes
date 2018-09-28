separaDados<-function(entrada,saida,nPedacos)
{
   #Separa aleatoriamente 10% dos dados para o conjunto de teste
   #e 90% para treino
   #se o nPedacos=1 entao os dados estarao contidos no conjunto de teste

   if( class(entrada)=="numeric" || class(entrada)=="integer" ){
	entrada <- matrix( entrada, ncol=1)
   }
   if( class(saida)=="numeric" || class(saida)=="integer" ){
	saida <- matrix( saida, ncol=1)
   }
   if (nrow(entrada)!=nrow(saida))
   {
      print("Erro: Número de Padrões de Entrada e Saida Diferentes")
   }

   a<-1:(nrow(entrada) - (nrow(entrada)%%(nrow(entrada)%/%nPedacos)))
   a<-sample(a)
   a<-matrix(a,nPedacos,byrow=T)

   treino_in=NULL
   treino_out=NULL
   teste_in=NULL
   teste_out=NULL

   lista<-NULL

   for (i in 1:nPedacos)
   {
      teste_in<-entrada[a[i,],]
      teste_out<-saida[a[i,],]
 
      treino_in<-entrada[a[-i,],]
      treino_out<-saida[a[-i,],] 
       
      #verifica se gera tabelas com só um padrao
      #e se for, converte pra matriz e gera a transposta
      #(gambiarra por causa de bug do R)

      if ((length(a[i,])==1))
      {
         teste_in<-t(as.matrix(teste_in))
         teste_out<-t(as.matrix(teste_out))
      }

      if ((length(a[-i,])==1))
      {
         treino_in<-t(as.matrix(treino_in))
         treino_out<-t(as.matrix(treino_out))
      }

      lista[[i]]<-list(teste_in,teste_out,treino_in,treino_out)
      names(lista[[i]])<-c("testeIn","testeOut","treinoIn","treinoOut")
   }

   lista
}