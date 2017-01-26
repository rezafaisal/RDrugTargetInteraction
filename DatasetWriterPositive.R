setwd("C:/Users/faisal/Downloads/Drug-Target")
rm(list=ls())


file_drug_target_matrix = "matrix.txt"
file_drug_feature_vector = "drug.txt"
file_target_feature_vector = "target.txt"

drug_target_matrix = read.table(file_drug_target_matrix)
drug_feature_vector = read.table(file_drug_feature_vector)
target_feature_vector = read.table(file_target_feature_vector)

if(exists("drug_target_dataset")){
  rm(drug_target_dataset)
}

instance_count = 1
file_count = 1

for(i in 1:nrow(drug_target_matrix)){
  for(j in 1:ncol(drug_target_matrix)){
    if(drug_target_matrix[i,j] == 1){
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
  }
}

file_count = file_count + 1
write.csv(drug_target_dataset, paste0("drug_target_dataset_positive.",file_count,".csv"), row.names = FALSE, quote= FALSE)
