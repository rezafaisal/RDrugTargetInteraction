library(kernlab)

rm(list = ls())

test_number = 1
positive_index = c("1","2","3","4","5","6","7","8","9","10")
negative_index = c("1.1","1.2","1.3","2.1","2.2","2.3","3.1","3.2","3.3","4.1","4.2","4.3","5.1","5.2","5.3","6.1","6.2","6.3",
                  "7.1","7.2","7.3","8.1","8.2","8.3","9.1","9.2","9.3","10.1","10.2","10.3")

#positive data
positive_count = 1
if(exists("positive_data")){
  rm(positive_data)
}

for(i in 1:positive_count){
  positive_file = paste0("drug_target_dataset_positive.",positive_index[i],".csv")
  positive_temp = read.csv(positive_file)[,1:1483]
  
  if(!exists("positive_data")){
    assign("positive_data", positive_temp)
  } else {
    positive_data = rbind(positive_data, positive_temp)
  }
}

#negative data
negative_count = 1
if(exists("negative_data")){
  rm(negative_data)
}

for(i in 1:negative_count){
  negative_file = paste0("drug_target_dataset_negative.",negative_index[i],".csv")
  negative_temp = read.csv(negative_file)
  
  if(!exists("negative_data")){
    assign("negative_data", negative_temp)
  } else {
    negative_data = rbind(negative_data, negative_temp)
  }
}

#data preparation
positive_negative_data = rbind(positive_data, negative_data)
positive_negative_unique = unique(positive_negative_data)

#classification
svm_count = 5
cross_count = 5
if(exists("classification_result")){
  rm(classification_result)
}

for (svm_j in 1:svm_count) {
  result<-vector(); 
  for (svm_i in 1:cross_count) {
    result[svm_i]<-cross(ksvm(class~.,positive_negative_unique,cross=cross_count));
  }; 
  
  result_temp = cbind(result, mean(result))
  if(!exists("classification_result")){
    assign("classification_result", result_temp)
  } else {
    classification_result = rbind(classification_result, result_temp)
  }
}

write.csv(classification_result, paste0("classification_result.",test_number,".csv"), row.names = FALSE)
