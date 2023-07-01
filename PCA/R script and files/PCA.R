#### PACKAGES E LIBRARIES ####

install.packages("BiocManager")
BiocManager::install("LEA")
BiocManager::install("pcaMethods")
install.packages("vcfR")


library(LEA)
library(pcaMethods)
library(vcfR)

##############################

##PCA 1 Leaf + Fruit


#Ler o ficheiro ".geno"
geno <- LEA::read.geno("C:/Users/jp_mo/OneDrive/Área de Trabalho/ipyrad/ipyrad-assembly (copy)/simdata_outfiles/simdata.geno")
#Transformar o ficheiro ".geno" num data frame
df_geno = as.data.frame(geno)

#Selecionar as colunas especificas de cada especie do data frame do geno
geno_kellogi = df_geno[, c(6,7,12,13,16,17,18,19,20,21,23,24,25)]
geno_agrvagr = df_geno[, c(48,49,50,51)]
geno_agrvoxy = df_geno[, c(1,10,11,14,46,47)]
geno_parvshr = df_geno[, c(29,33,34,35,36)]
geno_wislizeni = df_geno[, c(2,4,15,25,26,27,28,37,38,39,40,41,42,52)]
geno_hybrids = df_geno[, c(53,54,55)]

#Juntar todos os objetos criados num unico data frame
df_combined <- cbind(geno_kellogi, geno_agrvagr, geno_agrvoxy, geno_parvshr, geno_wislizeni, geno_hybrids)

#calcular o PCA
genoPCAmethods = pca(df_combined, scale = "vector", center = TRUE, nPcs = 2, method = "svd")

#Carregar o arquivo VCF
vcf_file <- ("C:/Users/jp_mo/OneDrive/Área de Trabalho/ipyrad/teste/simdata.vcf.gz")
#Ler o arquivo VCF
vcf <- read.vcfR(vcf_file)

#Criar uma objeto no qual esta todos os dados do GT
populations <- vcf@gt
#Criar um data frame do objeto "populations
df_pop = as.data.frame(populations)

#Selecionar as colunas especificas de cada especie do data frame do populations
class_kellogi = df_pop[, c(7,8,13,14,17,18,19,20,21,22,24,25,26)]
class_agrvagr = df_pop[, c(49,50,51,52)]
class_agrvoxy = df_pop[, c(2,11,12,15,47,48)]
class_parvshr = df_pop[, c(30,34,35,36,37)]
class_wislizeni = df_pop[, c(3,5,16,26,27,28,29,38,39,40,41,42,43,53)]
class_hybrids = df_pop[, c(54,55,56)]

# Criar um vetor com os nomes das classes
class_names <- c("class_kellogi", "class_agrvagr", "class_agrvoxy", "class_parvshr", "class_wislizeni", "class_hybrids")

# Criar um vetor com o numero de colunas em cada classe
num_columns <- sapply(mget(class_names), ncol)

# Criar o dataframe vazio com as colunas POP.NUMBER e POP.NAME
df_new <- data.frame(POP.NUMBER = rep(1:length(class_names), num_columns),
                     POP.NAME = rep(class_names, num_columns))

#Criacao do grafico
slplot(genoPCAmethods,
       scol=df_new[, "POP.NUMBER"],
       scoresLoadings=c(TRUE, FALSE),
       sl=NULL,
       spch="x")

legend("bottomright",
       legend=unique(df_new[, "POP.NAME"]),
       col=unique(df_new[, "POP.NUMBER"]),
       pch="x",
       cex = 0.8) 


## Fazer um print da legenda e depois colocar no relatorio

#Grafico opcional
slplot(genoPCAmethods,
       scoresLoadings=c(FALSE, TRUE))

##Se o teu "paper" tiver mais do que 1 grafico de PCA, continua...

## PCA2 - Leaf-Only


#Selecionar as colunas especificas de cada especie do data frame do geno
geno_parvula = as.data.frame(df_geno$V3)
geno_parvtam = df_geno[, c(30,31,32)]

#Juntar todos os objetos criados num unico data frame
df_combined2 <- cbind(geno_kellogi, geno_agrvagr, geno_agrvoxy, geno_parvshr, geno_wislizeni, geno_var, geno_parvula, geno_parvtam)

#calcular o PCA
genoPCAmethods2 = pca(df_combined2, scale = "vector", center = TRUE, nPcs = 2, method = "svd")

#Selecionar as colunas especificas de cada especie do data frame do populations
class_parvula = as.data.frame(df_pop$SRR5632503_cut)
class_parvtam = df_pop[, c(31,32,33)]

# Criar um vetor com os nomes das classes
nome_classes <- c("class_kellogi", "class_agrvagr", "class_agrvoxy", "class_parvshr", "class_wislizeni", "class_hybrids", "class_parvula", "class_parvtam")

# Criar um vetor com o numero de colunas em cada classe
num_colunas <- sapply(mget(nome_classes), ncol)

# Criar o dataframe vazio com as colunas POP.NUMBER e POP.NAME
novo_df <- data.frame(POP.NUMBER = rep(1:length(nome_classes), num_colunas),
                     POP.NAME = rep(nome_classes, num_colunas))

#Grafico para o PCA2
slplot(genoPCAmethods2,
       scol=novo_df[, "POP.NUMBER"],
       scoresLoadings=c(TRUE, FALSE),
       sl=NULL,
       spch="x")

legend("bottomright",
       legend=unique(novo_df[, "POP.NAME"]),
       col=unique(novo_df[, "POP.NUMBER"]),
       pch="x",
       cex = 0.8)

#Grafico opcional
slplot(genoPCAmethods2,
       scoresLoadings=c(FALSE, TRUE))

slplot(genoPCAmethods,
       scoresLoadings=c(FALSE, TRUE))

