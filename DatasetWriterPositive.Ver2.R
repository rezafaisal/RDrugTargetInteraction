setwd("C:/Users/faisal/Downloads/Drug-Target")
rm(list=ls())


file_drug_target_matrix = "matrix_index_positive.csv"
file_drug_feature_vector = "6_12859_2016_1377_MOESM6_ESM.txt"
file_target_feature_vector = "7_12859_2016_1377_MOESM7_ESM.txt"

drug_target_matrix = read.csv(file_drug_target_matrix, stringsAsFactors = FALSE)
drug_feature_vector = read.table(file_drug_feature_vector)
target_feature_vector = read.table(file_target_feature_vector)

if(exists("drug_target_dataset")){
  rm(drug_target_dataset)
}

instance_count = 1
file_count = 1

for(item_index in 1:nrow(drug_target_matrix)){
  i = drug_target_matrix[item_index, 1]
  j = drug_target_matrix[item_index, 2]
  
  class = "positive"
  drug_target_feature_vector = cbind(drug_feature_vector[i,], target_feature_vector[j,], class)
  
  if(instance_count > 1268){
    write.csv(drug_target_dataset, paste0("drug_target_dataset_positive.",file_count,".csv"), row.names = FALSE, quote= FALSE)
    
    if(exists("drug_target_dataset")){
      rm(drug_target_dataset)
    }
    
    instance_count = 1
    file_count = file_count + 1
  }
  
  
  if(!exists("drug_target_dataset")){
    assign("drug_target_dataset", drug_target_feature_vector)
  } else {
    drug_target_dataset = rbind(drug_target_dataset, drug_target_feature_vector)
  }
  
  instance_count = instance_count + 1
}

file_count = file_count + 1
write.csv(drug_target_dataset, paste0("drug_target_dataset_positive.",file_count,".csv"), row.names = FALSE, quote= FALSE)
