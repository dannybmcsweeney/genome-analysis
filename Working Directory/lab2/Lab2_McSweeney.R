#Lab No. 2
# Danny McSweeney
# 01/29/20

#Exercises

#Exercise 1
VectorA <- c(1,3,6,9,12)
VectorA
#> VectorA
#[1]  1  3  6  9 12
VectorB <- c(1,0,1,0,1)
VectorB
#> VectorB
#[1] 1 0 1 0 1
VectorA+VectorB
#> VectorA+VectorB
#[1]  2  3  7  9 13
VectorA-VectorB
#> VectorA-VectorB
#[1]  0  3  5  9 11
VectorA*VectorB
#> VectorA*VectorB
#[1]  1  0  6  0 12
VectorA/VectorB
#> VectorA/VectorB
#[1]   1 Inf   6 Inf  12


#Exercise 2
VectorC <- c(0,1,2,3)
VectorC
#> VectorC
#[1] 0 1 2 3
VectorD <- c("aa", "bb", "cc", "dd")
VectorD 
#> VectorD 
#[1] "aa" "bb" "cc" "dd"
VectorE <- c("aa",1,"bb",2)
VectorE
#> VectorE
#[1] "aa" "1"  "bb" "2" 
str(VectorC)
#> str(VectorC)
#num [1:4] 0 1 2 3
str(VectorD)
#> str(VectorD)
#chr [1:4] "aa" "bb" "cc" "dd"
str(VectorE)
#> VectorE
#[1] "aa" "1"  "bb" "2" 

#Exercise 3
genotype1 <- c("AA", "AA", "AG", "GG", "GG")
genotype2 <- c("AA", "AA", "GG", "GG", "GG")
A <- cbind(genotype1, genotype2)
A
#genotype1 genotype2
#[1,] "AA"      "AA"     
#[2,] "AA"      "AA"     
#[3,] "AG"      "GG"     
#[4,] "GG"      "GG"     
#[5,] "GG"      "GG" 
str(A)
#chr [1:5, 1:2] "AA" "AA" "AG" "GG" "GG" "AA" "AA" ...
#- attr(*, "dimnames")=List of 2
#..$ : NULL
#..$ : chr [1:2] "genotype1" "genotype2"
table(genotype)
genotype <- cbind(genotype1, genotype2)
table(genotype)
#genotype
#AA AG GG 
#4  1  5 


#Exercise No 4
time <- c(0,2,4,6,8)
treatment1 <- c(0,1,2,3,4)
treatment2 <- c(0,2,4,6,8)
treatment3 <- c(0,3,6,9,12)
treatment <- as.data.frame(cbind(treatment1,treatment2,treatment3))
treatment$Time <- c(0,2,4,6,8)
treatment
#treatment1 treatment2 treatment3 Time
#1          0          0          0    0
#2          1          2          3    2
#3          2          4          6    4
#4          3          6          9    6
#5          4          8         12    8
plot (treatment$Time,treatment$treatment3, xlab="Time", ylab="Treatment 3")


#Exercise No 5
read.table("23andME_complete.txt", header = TRUE, sep = "\t")
SNP_23andME <- read.table("23andME_complete.txt", header = TRUE, sep = "\t")
SNP_23andME
str(SNP_23andME)
#'data.frame':	960614 obs. of  4 variables:
#  $ rsid      : Factor w/ 960614 levels "i1000009","i2000003",..: 600125 532383 535928 178265 124446 723988 655510 600036 813048 254468 ...
#$ chromosome: Factor w/ 25 levels "1","10","11",..: 1 1 1 1 1 1 1 1 1 1 ...
#$ position  : int  82154 752566 752721 776546 798959 800007 838555 846808 854250 861808 ...
#$ genotype  : Factor w/ 20 levels "--","A","AA",..: 3 3 15 5 5 8 4 10 5 15 ...

#For the file, "23andMe_example_cat25.txt", there is a single object type for "chromosome".
#Whereas, for the file, "23andME_complete.txt", the object type inclues multiple factors with 25 levels total.
#Therefore, the "23andMe_example_cat25.txt" only includes part of the data included in the complete file "23andME_complete.txt".

#Exercise No 6
SNP_23andME_genotype <- table(SNP_23andME$genotype)
SNP_23andME_genotype
#   --      A     AA     AC     AG     AT      C     CC     CG     CT      D 
#21109   6676 147157  25036 109001    569   7188 173264   1003 108992     36 
#   DD     DI      G     GG     GT      I     II      T     TT 
#  157     17   7061 173054  24727    113    685   6643 148126 

##Exercise No 7
SNP_23andME_genotypeA <- subset(SNP_23andME, genotype == "A")
SNP_23andME_genotypeA
head(SNP_23andME_genotypeA, n=10)
#rsid chromosome position genotype
#930778  rs5939319          X  2700157        A
#930785     rs3671          X  2733668        A
#930788  rs5982588          X  2743627        A
#930797  rs5939382          X  2787455        A
#930806  rs5982611          X  2821450        A
#930814  rs3747394          X  2847133        A
#930833 rs11152555          X  2942986        A
#930835  rs5982635          X  2951931        A
#930840   rs936050          X  3012405        A
#930844  rs1377999          X  3025174        A

# "A" SNPs appear to be located throughout the X chromosome.

table(SNP_23andME_genotypeA$chromosome)
#1   10   11   12   13   14   15   16   17   18   19    2   20   21   22 
#0    0    0    0    0    0    0    0    0    0    0    0    0    0    0 
#3    4    5    6    7    8    9   MT    X    Y 
#0    0    0    0    0    0    0  732 5782  162 

# However, with further investigation it appears that the "A" SNP appears in both the X chromosome (5782 of them) as well as the Y chromosome (162 of them).
