run_analysis <- function(){
 # library(dplyr)
  # Merge test and train data
  x_train<-read.table("./train/X_train.txt")  
  x_test<-read.table("./test/X_test.txt")  
  x_AllData<-rbind(x_train, x_test)
  
  
  ######## Get Required Colums and Column Headers ###########
  
  features<-read.table("./features.txt", header = FALSE)
  ## All cols with "-mean" in their suffix 
  ## includes rowNum of the variable
  meanColsAndHeaders<-features[grep(features[,2], pattern = "-mean"),]
  ## The col nums for mean variables
  meanCols<-meanColsAndHeaders[1]
  meanColsIndexes<-meanCols[,1]
  meanHeaders<-(meanColsAndHeaders[2])[,1]
  
  ## All cols with "-std()" in their suffix
  ## includes rowNum of the variable
  stdColsAndHeaders<-features[grep(features[,2], pattern = "-std"),]
  ## The col nums for std variables
  stdCols<-stdColsAndHeaders[1]
  stdColsIndexes<-stdCols[,1]
  stdHeaders<-(stdColsAndHeaders[2])[,1]
  
  meanAndStdIndexes<-c(meanColsIndexes,stdColsIndexes)
  meanAndStdHeaders<-unlist(list(meanHeaders,stdHeaders))
  
  ######## End Get Required Colums and Column Headers ###########
  
  ## Select from merged data set cols that measure 
  ## std and mean, add headers to cols
  requiredData<-x_AllData[,c(meanAndStdIndexes)]
  
  ######## Add test activity labels ##########
  y_test<-read.table("./test/y_test.txt") 
  y_test<-as.data.frame(sapply(y_test,FUN=gsub,pattern="1",replacement='WALKING'))
  y_test<-as.data.frame(sapply(y_test,FUN=gsub,pattern="2",replacement="WALKING_UPSTAIRS"))
  y_test<-as.data.frame(sapply(y_test,FUN=gsub,pattern="3",replacement="WALKING_DOWNSTAIRS"))
  y_test<-as.data.frame(sapply(y_test,FUN=gsub,pattern="4",replacement="SITTING"))
  y_test<-as.data.frame(sapply(y_test,FUN=gsub,pattern="5",replacement="STANDING"))
  y_test<-as.data.frame(sapply(y_test,FUN=gsub,pattern="6",replacement="LAYING"))
  names(y_test)<-"ACTIVITIES"
  
  
  
  ######## Add train activity labels ##########
  y_train<-read.table("./train/y_train.txt") 
  y_train<-as.data.frame(sapply(y_train,FUN=gsub,pattern="1",replacement='WALKING'))
  y_train<-as.data.frame(sapply(y_train,FUN=gsub,pattern="2",replacement="WALKING_UPSTAIRS"))
  y_train<-as.data.frame(sapply(y_train,FUN=gsub,pattern="3",replacement="WALKING_DOWNSTAIRS"))
  y_train<-as.data.frame(sapply(y_train,FUN=gsub,pattern="4",replacement="SITTING"))
  y_train<-as.data.frame(sapply(y_train,FUN=gsub,pattern="5",replacement="STANDING"))
  y_train<-as.data.frame(sapply(y_train,FUN=gsub,pattern="6",replacement="LAYING"))
  names(y_train)<-"ACTIVITIES"
  
  
  
  ###############################
  
  y_AllData<-rbind(y_train, y_test)
  
  
  # AllData<-cbind(y_AllData,requiredData)
  requiredData["ACTIVITIES"]<-NA
  requiredData["ACTIVITIES"]<-y_AllData
  
  names(requiredData)<-meanAndStdHeaders
  names(requiredData)[ncol(requiredData)]<-"ACTIVITIES"
  requiredData["ACTIVITIES"]<-NA
  requiredData["ACTIVITIES"]<-y_AllData
  
  subject_train<-read.table("./train/subject_train.txt") 
  subject_test<-read.table("./test/subject_test.txt") 
  subjects<-rbind(subject_train, subject_test)
  requiredData["SUBJECT"]<-NA
  requiredData["SUBJECT"]<-subjects
  
 requiredData<-group_by(requiredData, ACTIVITIES, SUBJECT) %>% summarise_each(funs(mean))
  
  
  requiredData
  
}