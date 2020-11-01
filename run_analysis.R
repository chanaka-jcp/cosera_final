x_test<-read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/test/X_test.txt",header = FALSE)
y_test<-read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/test/y_test.txt",header = FALSE)
x_train<-read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/train/X_train.txt",header = FALSE)
y_train<-read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/train/y_train.txt",header = FALSE)
s_train <- read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/train/subject_train.txt", header = FALSE) 
s_test <- read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test) 
s <- rbind(s_train, s_test)
features <- read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/features.txt")
names(features) <- c('feat_id', 'feat_name')
index_features <- grep("-mean()|-std()", features$feat_name)
x <- x[, index_features]
names(x) <- gsub("(|)", "", (features[index_features, 2]))
activities <- read.table("C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/activity_labels.txt")
names(activities) <- c('act_id', 'act_name') 
y[, 1] = activities[y[, 1], 2]
names(y) <- "Activity" 
names(s) <- "Subject"
tidy_DataSet <- cbind(s, y, x)

p <- tidy_DataSet[, 3:dim(tidy_DataSet)[2]]
tidyDataAvgSet <- aggregate(p,list(tidy_DataSet$Subject, tidy_DataSet$Activity), mean)
names(tidyDataAvgSet)[1] <- "Subject" 
names(tidyDataAvgSet)[2] <- "Activity"

write.table(tidy_DataSet, "C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/tidyDataFile.csv")
write.table(tidyDataAvgSet, "C:/Users/Chanaka/Desktop/cosera R/UCI HAR Dataset/tidyDatAvgsubmit.txt",row.name=FALSE)