# Download demo file
stock_BP <- read.csv("http://ichart.finance.yahoo.com/table.csv?s=BP")
write.csv(stock_BP,"table.csv", row.names=FALSE)

# Hadoop file system
system('Hadoop fs -rm /stock/')
system('Hadoop fs -mkdir /stock/')
system('Hadoop fs -copyFromLocal /home/rstudio/server/Demo/stock_*.R /stock')
system('Hadoop fs copyFromLocal /home/rstudio/server/Demo/table.csv /stock')
system('Hadoop fs -ls /stock')

# For running Hadoop MapReduce with streaming parameters
system(paste("hadoop jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar",
             
             " -files hdfs://sandbox.hortonworks.com:8020/stock/stock_mapper.R,hdfs://sandbox.hortonworks.com:8020/stock/stock_reducer.R",
             " -input /stock/table.csv",
             " -output /stock/outputs",
             " -mapper stock_mapper.R",
             " -reducer stock_reducer.R"))

# Copy output folder back to local folder 
system('Hadoop fs -copyToLocal /stock/output /home/rstudio/server/Demo')

# Loading ggplot2 library
library(ggplot2)

# we have stored above terminal output to stock_output.txt file

#loading it to R workspace
myStockData <- read.delim("part-00000", header=F, sep="", dec=".")

# plotting the data with ggplot2 geom_smooth function
ggplot(myStockData, aes(x=V1, y=V2)) + geom_smooth() + geom_point() + xlab("Changes") + ylab("Frequency")
