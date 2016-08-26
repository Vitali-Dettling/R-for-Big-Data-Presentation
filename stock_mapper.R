#! /usr/bin/env Rscript
# stock_mapper.R

# To take input the data from streaming
input <- file("stdin", "r")

# To reading the each lines of documents till the end
while(length(currentLine <-readLines(input, n=1, warn=FALSE)) > 0)
{
  # To split the line by "," seperator
  fields <- unlist(strsplit(currentLine, ","))
  
  # Capturing open column value
  open <- as.double(fields[2])
  
  # Capturing close columns value
  close <- as.double(fields[5])
  
  # Calculating the difference of close and open attribute
  change <- (close-open)
  
  # emitting change as key and value as 1
  write(paste(change, 1, sep="\t"), stdout())
}

close(input)
