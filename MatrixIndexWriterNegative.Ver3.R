setwd("C:/Users/faisal/Downloads/Drug-Target")
rm(list=ls())


file_drug_target_matrix = "3_12859_2016_1377_MOESM3_ESM.txt"
drug_target_matrix = read.table(file_drug_target_matrix)
drug_index_start = 1
drug_index_end = 550
drug_count = 550
file_index = 1

if(exists("drug_target_dataset")){
  rm(drug_target_dataset)
}

for(i in sample(c(drug_index_start:drug_index_end), drug_count)){
  for(j in sample(3348, 3348)){
    if(drug_target_matrix[i,j] == 0){
      if(!exists("matrix_index")){
        assign("matrix_index", c(i,j))
      } else {
        matrix_index = rbind(matrix_index, c(i,j))
      }
    }
  }
}

matrix_index = matrix_index[sample(nrow(matrix_index), nrow(matrix_index)),]
write.csv(matrix_index, paste0("matrix_index_negative.",file_index,".csv"), row.names = FALSE, quote= FALSE)
