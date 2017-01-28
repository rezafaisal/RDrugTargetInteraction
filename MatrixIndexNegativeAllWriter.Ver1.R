rm(list = ls())

if(exists("matrix_index")) {
  rm(matrix_index)
}

for(i in 1:11){
  file_name = paste0("matrix_index_negative.",i,".csv")
  part_matrix_index = read.csv(file_name)
  
  if(!exists("matrix_index")){
    assign("matrix_index", part_matrix_index)
  } else {
    matrix_index = rbind(matrix_index, part_matrix_index)
  }
}

matrix_index_negative = matrix_index[sample(nrow(matrix_index), nrow(matrix_index)),]
write.csv(matrix_index_negative, "matrix_index_negative.csv", row.names = FALSE, quote= FALSE)