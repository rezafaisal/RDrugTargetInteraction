setwd("C:/Users/faisal/Downloads/Drug-Target")
rm(list=ls())

library(foreach)
library(doParallel)

cl<-makeCluster(3)
registerDoParallel(cl)

file_drug_target_matrix = "3_12859_2016_1377_MOESM3_ESM.txt"
file_drug_feature_vector = "6_12859_2016_1377_MOESM6_ESM.txt"
file_target_feature_vector = "7_12859_2016_1377_MOESM7_ESM.txt"

drug_target_matrix = read.table(file_drug_target_matrix)
drug_feature_vector = read.table(file_drug_feature_vector)
target_feature_vector = read.table(file_target_feature_vector)

if(exists("matrix_index")){
  rm(matrix_index)
}

instance_count = 1
file_count = 1

foreach(i=1:nrow(drug_target_matrix)) %dopar% {
  for(j in 1:ncol(drug_target_matrix)){
    if(drug_target_matrix[i,j] == 0){
      if(!exists("matrix_index")){
        assign("matrix_index", c(i,j))
      } else {
        matrix_index = rbind(matrix_index, c(i,j))
      }
    }
  }
}

write.csv(matrix_index, "matrix_index.csv", row.names = FALSE, quote= FALSE)

stopCluster(cl)
