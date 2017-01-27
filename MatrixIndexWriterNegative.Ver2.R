setwd("C:/Users/faisal/Downloads/Drug-Target")
rm(list=ls())


file_drug_target_matrix = "3_12859_2016_1377_MOESM3_ESM.txt"
drug_target_matrix = read.table(file_drug_target_matrix)

if(exists("drug_target_dataset")){
  rm(drug_target_dataset)
}

for(i in sample(5877, 5877)){
  for(j in sample(3348, 3348)){
    print(c(i,j))
    
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
write.csv(matrix_index, "matrix_index_negative.csv", row.names = FALSE, quote= FALSE)
