#! /usr/bin/env Rscript
# stock_reducer.R

current.key <- NA
current.val <- 0.0

conn <- file("stdin", "r")

while (length(next.line <- readLines(conn, n=1)) > 0) {

  split.line <- strsplit(next.line, "\t")
  key <- split.line[[1]][1]
  val <- as.numeric(split.line[[1]][2])

  if (is.na(current.key)) {
    current.key <- key
    current.val <- val
  }
  else {
    if (current.key == key) {
      current.val <- current.val + val
    }
    else {
      write(paste(current.key, current.val, sep="\t"), stdout())
      current.key <- key
      current.val<- val
    }
  }
}
write(paste(current.key, current.val, sep="\t"), stdout())

close(conn)
