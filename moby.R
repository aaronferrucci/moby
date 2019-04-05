library(ggplot2)

# df <- data.frame(x = sample(0:255, 1000, replace=T))
fp <- file("moby.txt", "r", blocking = FALSE)
moby <- readLines(fp)
close(fp)
moby <- paste0(moby, sep=" ", collapse="")
df <- data.frame(x = as.integer(charToRaw(moby)))
ggplot(df, aes(x=x)) + geom_histogram()