rm(list=ls())


file_drug_target_matrix = "matrix_index_negative.csv"
file_drug_feature_vector = "6_12859_2016_1377_MOESM6_ESM.txt"
file_target_feature_vector = "7_12859_2016_1377_MOESM7_ESM.txt"

drug_target_matrix = read.csv(file_drug_target_matrix, stringsAsFactors = FALSE)
drug_feature_vector = read.table(file_drug_feature_vector)
target_feature_vector = read.table(file_target_feature_vector)

dataset_index_start = 1
# drug_index_start = 1966353
# drug_index_start = 3932705
# drug_index_start = 5899057
# drug_index_start = 7865409
# drug_index_start = 9831761
# drug_index_start = 11798113
# drug_index_start = 13764465
# drug_index_start = 15730817
# drug_index_start = 17697169

dataset_index_end = 1966352
# dataset_index_end = 3932704
# dataset_index_end = 5899056
# dataset_index_end = 7865408
# dataset_index_end = 9831760
# dataset_index_end = 11798112
# dataset_index_end = 13764464
# dataset_index_end = 15730816
# dataset_index_end = 17697168
# dataset_index_end = 19663520

dataset_count = 1966352

file_index = 1
# file_index = 2
# file_index = 3
# file_index = 4
# file_index = 5
# file_index = 6
# file_index = 7
# file_index = 8
# file_index = 9
# file_index = 10

if(exists("drug_target_dataset")){
  rm(drug_target_dataset)
}

for(item_index in dataset_index_start:dataset_index_end) {
  i = drug_target_matrix[item_index, 1]
  j = drug_target_matrix[item_index, 2]
  
  class = "negative"
  drug_target_feature_vector = cbind(drug_feature_vector[i,], target_feature_vector[j,], class)
  
  if(!exists("drug_target_dataset")){
    assign("drug_target_dataset", drug_target_feature_vector)
  } else {
    drug_target_dataset = rbind(drug_target_dataset, drug_target_feature_vector)
  }
}

write.csv(drug_target_dataset, paste0("drug_target_dataset_negative.",file_index,".csv"), row.names = FALSE, quote= FALSE)