How the script works  :

1) The Script first merges test and train data then
2) Gets the required Colums and Column Headers  :
  ## All cols with "-mean" in their suffix 
  and
  ## All cols with "-std()" in their suffix
  then
3)  
  ## Selects from the merged data set cols that measure 
  ## std and mean, and adds headers to cols
  
4)  
  ## Adds test activity labels ##########
  ## Adds train activity labels ##########
  ### Adds SUBJECTS Column
5) 
  Groups by ACTIVITIES and SUBJECTS Summarizing means of variables
 
  
  