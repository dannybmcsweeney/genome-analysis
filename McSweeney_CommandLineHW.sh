---
title: "McSweeney_Command Line"
author: "Danny McSweeney"
date: "5/11/2020"
output: html_document
---
##I tried to insert ```{bash...} chunks into this file, but they would not insert. I restarted RStudio, and the option to insert a chunk disappeared and was replaced by a simple R button.

names(knitr::knit_engines$get())

#View the current directory
pwd

#See what's in the directory
ls -l

#MAke a new directory
mkdir MYDRAFTS

#Enter the directory
cd MYDRAFTS

#See what's in the directory
ls -a

#Make a new file use the nano text file maker
nano test1

#Navigating around the directories and seeing what's in them
cd
cd MYDRAFTS
ls
ls -a
cd

#Make a new directory
mkdir MYDRAFTS2
cd
ls
pwd
cd MYDRAFTS
pwd

#Remove a directory
rm -r MYDRAFTS
ls -a
home/ --
cd TERMFILES
mkdir CASK
ls
rmdir CASK
ls
cd

#concatenate files
cat .tester5
cd TERMFILES
cat TERMFILES
cat TERMFILES tester3 > temp1
cd TERMFILES2
cat TERMFILES2 tester4 > temp1

cd
ls

#Copy files
cp Tester temp1

#Move files
mv temp1 temp2

#Look at top # of rows in file
head -2 temp2

#Look at bottom # of rows in file
tail -1 temp1


grep see temp2
who

