install.packages("BiocManager")
BiocManager::install("LEA")
BiocManager::install("pcaMethods")
install.packages("vcfR")



library(LEA)
library(pcaMethods)
library(vcfR)



geno <- LEA::read.geno("C:/Users/jp_mo/OneDrive/Área de Trabalho/ipyrad/ipyrad-assembly (copy)/simdata_outfiles/simdata.geno")
df_geno = as.data.frame(geno) #Perguntar os valores do ficheiro .geno

v1_classes = factor(df_geno$V1)
genoPCAmethods = pca(df_geno, scale = "vector", center = TRUE, nPcs = 2, method = "svd")
#Devo trocar os nomes das colunas pelos seus respetivos nomes?

#pca_results <- pcaMethods::pca(geno)



vcf_file <- ("C:/Users/jp_mo/OneDrive/Área de Trabalho/ipyrad/teste/simdata.vcf.gz")
vcf <- read.vcfR(vcf_file)
populations <- vcf@gt
df_pop = as.data.frame(populations)
pop_classes = factor(df_pop$SRR5632374_cut) #Devo criar uma "variavel" que tenha todos os 
                                            # valores que quero?

slplot(genoPCAmethods,
       scol=pop_classes,
       scoresLoadings=c(TRUE, FALSE),
       spch=1)

legend("bottomright", legend = c("Cv1", "Cv2", "Cv3"), pch = 1,
       col = c("black", "red", "green")) 

slplot(genoPCAmethods,
       scoresLoadings=c(FALSE, TRUE))

