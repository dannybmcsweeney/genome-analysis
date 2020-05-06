#Lab2_Danny McSweeney

SNPs <- c("AA", "AA", "GG", "AG", "AG", "AA", "AG", "AA", "AA", "AA", "AG")
SNPs

SNPs_cat <- factor(SNPs)
SNPs_cat

table(SNPs_cat)
plot(SNPs_cat)

as.numeric(SNPs_cat)

Day1 <- c(2,4,6,8)
Day2 <- c(3,6,9,12)
Day3 <- c(1,4,9,16)
A <- cbind(Day1, Day2,Day3)
A
A<- rbind(Day1,Day2,Day3)
A
A <- cbind(Day1, Day2,Day3)
A
B <- rbind(Day1,Day2,Day3)
B

Day4 <- c(5,10,11,20)
C <- rbind(B,Day4)
C

A*10

A[1]
A[12]

A[ ,c(1,3)]
A[c(2,4), ]

A
t(A)

Gene1 <- c(2,4,6,8)
Gene2 <- c(3,6,9,12)
Gene3 <- c(1,4,9,16)
Gene <- c("Day 1", "Day 2", "Day 3", "Day 4")

RNAseq <- data.frame(Gene1, Gene2, Gene3, row.names = Gene)
RNAseq

RNAseq$Gene3
plot(RNAseq$Gene1, RNAseq$Gene3)

plot(RNAseq$Day,RNAseq$Gene3)

RNAseq$Gene4 <- c(5,10,15,20)
RNAseq

RNAseq$Gene5 <- c(1,2,3,3)

RNAseq["Day 4",] <- rbind(10,14,20,22,3)

x=1
str(x)
a="ATGCCCTGA"
a

str(SNPs)
SNPs <- c("AA", "AA", "GG", "AG", "AG", "AA", "AG", "AA", "AA", "AA", "AG")
str(SNPs_cat)

##########################
B <- rbind(Day1,Day2,Day3)
str (B)

Gene1
Gene2
Gene3
Gene
RNAseq<- data.frame(Gene1,Gene2,Gene3, row.names = Gene)
str(RNAseq)
