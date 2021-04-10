library(DBI)
library(RODBC)
library(odbc)

library(data.table)
library(stringr)
con<-dbConnect(odbc::odbc(),"Post")
######################
#Função para resolver a questão UTF-8
toUTF_8<-function(dataframe){
  #export your data.frame to a CSV temporary file and reimport with data.table::fread(), specifying Latin-1  as source encoding.
df <- dataframe
fwrite(df,"temp.csv")
dataframe <- fread("temp.csv",encoding = "Latin-1")
return(dataframe)
}
##caracterizacao_informal_turismo_ate_2015###########################
##Importando os banco de dados
ft_caracterizacao_turismo_informal<-dbGetQuery(con,"SELECT * FROM ft_caracterizacao_turismo_informal")

dm_genero<-dbGetQuery(con,"SELECT * FROM dm_genero")
dm_genero<-toUTF_8(dm_genero)

dm_faixa_etaria<-dbGetQuery(con,"SELECT * FROM dm_faixa_etaria")
dm_faixa_etaria<-toUTF_8(dm_faixa_etaria)

dm_faixa_remuneracao_informal<-dbGetQuery(con,"SELECT * FROM dm_faixa_remuneracao_informal")
dm_faixa_remuneracao_informal<-toUTF_8(dm_faixa_remuneracao_informal)

dm_grau_instrucao_informal<-dbGetQuery(con,"SELECT * FROM dm_grau_instrucao_informal")
dm_grau_instrucao_informal<-toUTF_8(dm_grau_instrucao_informal)

dm_horas_trabalhadas<-dbGetQuery(con,"SELECT * FROM dm_horas_trabalhadas")
dm_horas_trabalhadas<-toUTF_8(dm_horas_trabalhadas)

dm_contr_previdencia<-dbGetQuery(con,"SELECT * FROM dm_contr_previdencia")
dm_contr_previdencia<-toUTF_8(dm_contr_previdencia)

hierarquia_geografica<-dbGetQuery(con,"SELECT * FROM hierarquia_geografica")
hierarquia_geografica<-toUTF_8(hierarquia_geografica)

regiao_geografica<-dbGetQuery(con,"SELECT * FROM regiao_geografica")
regiao_geografica<-toUTF_8(regiao_geografica)
regiao_geografica$desc_regiao_geografica<-str_remove(regiao_geografica$desc_regiao_geografica,"Região ")

dominio_act<-dbGetQuery(con,"SELECT * FROM dominio_act")
dominio_act<-toUTF_8(dominio_act)
#Arrumando Mercado Informal com coeficiente
ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal,dm_genero,by.x="sk_genero",by.y="sk_genero")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'descricao'] <- 'Gênero'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal_mod,dm_faixa_etaria,by.x="sk_faixa_etaria",by.y="sk_faixa_etaria")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'descricao'] <- 'Idade'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal_mod,dm_faixa_remuneracao_informal,by.x="sk_faixa_remuneracao",by.y="sk_faixa_remuneracao")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'descricao'] <- 'Remuneração'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal_mod,dm_grau_instrucao_informal,by.x="sk_grau_instrucao",by.y="sk_grau_instrucao")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'descricao'] <- 'Instrução'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal_mod,dm_horas_trabalhadas,by.x="sk_horas_trabalhadas",by.y="sk_horas_trabalhadas")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'descricao'] <- 'Horas Trabalhadas/Semana'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal_mod,dm_contr_previdencia,by.x="sk_contr_previdencia",by.y="sk_contr_previdencia")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'descricao'] <- 'Contribuição à Previdência Social'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal_mod,regiao_geografica,by.x="sk_hierarquia_geografica",by.y="sk_regiao_geografica")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'desc_regiao_geografica'] <- 'Região'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1)]

ft_caracterizacao_turismo_informal_mod<-merge(ft_caracterizacao_turismo_informal_mod,dominio_act,by.x="sk_act",by.y="sk_act")
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'desc_act'] <- 'Atividade Característica do Turismo'
ft_caracterizacao_turismo_informal_mod<-ft_caracterizacao_turismo_informal_mod[,c(-1,-15)]

#Conferindo
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'sk_ano'] <- 'Ano'
colnames(ft_caracterizacao_turismo_informal_mod)[colnames(ft_caracterizacao_turismo_informal_mod) == 'nr_ocupados'] <- 'Número de ocupações'

a<-ft_caracterizacao_turismo_informal_mod
xtabs(`Número.de.ocupações`~`Gênero`+Ano, a) #o que vai somar ~linha+coluna

#Exportando
#write.csv(ft_caracterizacao_turismo_informal_mod,"E:/FP Gamer/Documents/Programação/R/Projetos no R/Shiny/Extrator-de-dados---Turismo---IPEA/DATASET/caracterizacao_informal_turismo_ate_2015.csv", row.names = T)
#a<-read.csv("E:/FP Gamer/Documents/Programação/R/Projetos no R/Shiny/Extrator-de-dados---Turismo---IPEA/DATASET/caracterizacao_informal_turismo_ate_2015.csv")


##caracterizacao_informal_turismo_pós_2015###########################
##Importando os banco de dados
ft_caracterizacao_turismo_informal_pndc<-dbGetQuery(con,"SELECT * FROM ft_caracterizacao_turismo_informal_pndc")

dm_genero<-dbGetQuery(con,"SELECT * FROM dm_genero")
dm_genero<-toUTF_8(dm_genero)

dm_faixa_etaria<-dbGetQuery(con,"SELECT * FROM dm_faixa_etaria")
dm_faixa_etaria<-toUTF_8(dm_faixa_etaria)

dm_faixa_remuneracao_informal<-dbGetQuery(con,"SELECT * FROM dm_faixa_remuneracao_informal")
dm_faixa_remuneracao_informal<-toUTF_8(dm_faixa_remuneracao_informal)

dm_grau_instrucao_informal<-dbGetQuery(con,"SELECT * FROM dm_grau_instrucao_informal")
dm_grau_instrucao_informal<-toUTF_8(dm_grau_instrucao_informal)

dm_horas_trabalhadas<-dbGetQuery(con,"SELECT * FROM dm_horas_trabalhadas")
dm_horas_trabalhadas<-toUTF_8(dm_horas_trabalhadas)

dm_contr_previdencia<-dbGetQuery(con,"SELECT * FROM dm_contr_previdencia")
dm_contr_previdencia<-toUTF_8(dm_contr_previdencia)

hierarquia_geografica<-dbGetQuery(con,"SELECT * FROM hierarquia_geografica")
hierarquia_geografica<-toUTF_8(hierarquia_geografica)

regiao_geografica<-dbGetQuery(con,"SELECT * FROM regiao_geografica")
regiao_geografica<-toUTF_8(regiao_geografica)
regiao_geografica$desc_regiao_geografica<-str_remove(regiao_geografica$desc_regiao_geografica,"Região ")

dominio_act<-dbGetQuery(con,"SELECT * FROM dominio_act")
dominio_act<-toUTF_8(dominio_act)

#Arrumando Mercado Informal com coeficiente pós 2015
ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc,dm_genero,by.x="sk_genero",by.y="sk_genero")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'descricao'] <- 'Gênero'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc_mod,dm_faixa_etaria,by.x="sk_faixa_etaria",by.y="sk_faixa_etaria")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'descricao'] <- 'Idade'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc_mod,dm_faixa_remuneracao_informal,by.x="sk_faixa_remuneracao",by.y="sk_faixa_remuneracao")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'descricao'] <- 'Remuneração'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc_mod,dm_grau_instrucao_informal,by.x="sk_grau_instrucao",by.y="sk_grau_instrucao")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'descricao'] <- 'Instrução'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc_mod,dm_horas_trabalhadas,by.x="sk_horas_trabalhadas",by.y="sk_horas_trabalhadas")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'descricao'] <- 'Horas Trabalhadas/Semana'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc_mod,dm_contr_previdencia,by.x="sk_contr_previdencia",by.y="sk_contr_previdencia")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'descricao'] <- 'Contribuição à Previdência Social'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1,-13)]

ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc_mod,hierarquia_geografica,by.x="sk_hierarquia_geografica",by.y="sk_hierarquia_geografica")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'desc_macro_regiao'] <- 'Região'
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'desc_unidade'] <- 'UF'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1)]


ft_caracterizacao_turismo_informal_pndc_mod<-merge(ft_caracterizacao_turismo_informal_pndc_mod,dominio_act,by.x="sk_act",by.y="sk_act")
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'desc_act'] <- 'Atividade Característica do Turismo'
ft_caracterizacao_turismo_informal_pndc_mod<-ft_caracterizacao_turismo_informal_pndc_mod[,c(-1,-17)]

#Conferindo
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'sk_ano'] <- 'Ano'
colnames(ft_caracterizacao_turismo_informal_pndc_mod)[colnames(ft_caracterizacao_turismo_informal_pndc_mod) == 'nr_ocupados'] <- 'Número de ocupações'

a<-ft_caracterizacao_turismo_informal_pndc_mod
xtabs(`Número.de.ocupações`~`Idade`+Ano, a) #o que vai somar ~linha+coluna


#Gênero
#Idade
#Remuneração
#Instrução
#Horas Trabalhadas/Semana
#Contribuição à Previdência Social
#Região
#Atividade Característica do Turismo

#Exportando
write.csv(ft_caracterizacao_turismo_informal_pndc_mod,"E:/FP Gamer/Documents/Programação/R/Projetos no R/Shiny/Extrator-de-dados---Turismo---IPEA/DATASET/caracterizacao_informal_turismo_apos_2015.csv", row.names = T)
a<-read.csv("E:/FP Gamer/Documents/Programação/R/Projetos no R/Shiny/Extrator-de-dados---Turismo---IPEA/DATASET/caracterizacao_informal_turismo_apos_2015.csv")
