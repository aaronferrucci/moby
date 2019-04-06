library(ggplot2)
library(dplyr)

fp <- file("moby.txt", "r", blocking = FALSE)
moby <- readLines(fp)
close(fp)
moby <- paste0(moby, sep=" ", collapse="")
x <- factor(as.integer(charToRaw(moby)))
df <- data.frame(ascii = x)
dat <- df %>% group_by(ascii) %>% summarize(count=length(ascii))
dat$ascii <- reorder(dat$ascii, -dat$count)
dat$char <- rawToChar(as.raw(levels(dat$ascii))[dat$ascii], multiple=T)
o <- order(dat$count, decreasing=T)

p <- ggplot(dat, aes(x=ascii, y=count)) + scale_x_discrete(labels=dat$char[o]) + geom_col()
print(p)

freq <- data.frame(dec=dat$ascii[o], count=dat$count[o])
freq$hex <- as.hexmode(as.integer(freq$dec))