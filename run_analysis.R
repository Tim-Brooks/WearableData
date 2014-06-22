library("plyr")

features <- function() {
  removeDash <- function(str) gsub("-", "_", str)
  removeParan <- function(str) gsub("\\(\\)", "", str)
  path <- "UCI\ HAR\ Dataset/features.txt"
  df <- read.table(path, sep="")
  colnames(df) <- c("Index", "Feature")
  indexes <- c(grep("std", df$Feature), grep("mean", df$Feature))
  df <- df[indexes,]
  df <- df[order(df[,1]),]
  df$Feature <- sapply(df$Feature, removeDash)
  df$Feature <- sapply(df$Feature, removeParan)
  df
}

readFile <- function(fileName, dataSet) {
  directory <- "UCI\ HAR\ Dataset/"
  path <- paste(directory, dataSet, "/", fileName, "_", dataSet, ".txt", sep = "")
  df <- read.table(path, sep="")
  df
}

nameActivities <- function(data) {
  path <- "UCI\ HAR\ Dataset/activity_labels.txt"
  act <- read.table(path, sep="")
  f <- function(x) mapvalues(x, from = as.character(act$V1), to = as.character(act$V2))
  data[2] <- lapply(data[2], f)
  data
}

joinColumns <- function(features, dataSet) {
  subjects <- readFile("subject", dataSet)
  colnames(subjects) <- c("Subject")
  activities <- readFile("y", dataSet)
  colnames(activities) <- c("Activity")
  xs <- readFile("X", dataSet)
  xs <- xs[,features$Index]
  colnames(xs) <- features$Feature
  cbind(subjects, activities, xs)
}

joinData <- function(features) {
  rbind(joinColumns(features, "test"), joinColumns(features, "train"))
}

summarizeData <- function(data) {
  sum <- aggregate(data[colnames(data)[3:ncol(data)]], by = list(data$Subject, data$Activity), FUN=mean)
  colnames(sum)[1:2] <- colnames(data)[1:2]
  sum
}

writeFile <- function(data, name) {
  write.table(data, file=name, row.names = FALSE)
}

tidyData <- function() {
  features <- features()
  data <- nameActivities(joinData(features))
  data
}

runDataScript <- function() {
  data <- tidyData()
  summary <- summarizeData(data)
  writeFile(data, "tidy_data.txt")
  writeFile(summary, "summary.txt")
}