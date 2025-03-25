###########################
#Reading Data
collegedata <- read.csv("usnewstitled.data")
head(collegedata)

profdata <- read.csv("aauptitled.data")
head(profdata)

library(dplyr)
###########################

###########################
#Swapping * --> NA
collegedata$AvMathSAT <- gsub('*', 'NA', collegedata$AvMathSAT, fixed = TRUE)
###
cols_to_clean <- c(
  "AvVerbalSAT", "AvCombinedSAT", "AvACT", 
  "MathSATQ1", "MathSATQ3", "VerbalSATQ1", "VerbalSATQ3", 
  "ACTQ1", "ACTQ3", "AppsReceived", "AppsAccepted", 
  "NewEnrolled", "Top10HSpct", "Top25HSpct", 
  "StudFulltime", "StudParttime", "InstateTuit", "OutstateTuit", 
  "Roomboard", "Room", "Board", "AddFees", "Books", 
  "PersonalSpending", "PhdPct", "TerminalPct", 
  "StudFacRatio", "DonatePct", "InstrucExpenditurePerStud", 
  "GraduationPct"
)


collegedata <- collegedata %>%
  mutate(across(all_of(cols_to_clean), ~ as.numeric(gsub('*', NA, ., fixed = TRUE))))
###
head(collegedata)
  
###########################

#Making column numeric
collegedata$AvMathSAT <- as.numeric(as.character(collegedata$AvMathSAT))
head(collegedata$AvMathSAT)
###
collegedata[cols_to_clean] <- lapply(collegedata[cols_to_clean], as.numeric)
###
###########################
#Replacing NAs --> Column Average
collegedata$AvMathSAT[is.na(collegedata$AvMathSAT)]<-round(mean(collegedata$AvMathSAT,na.rm=TRUE),digits = 0)
#head(collegedata$AvMathSAT)

###
cols_to_clean2 <- c(
  "AvVerbalSAT", "AvCombinedSAT", "AvACT", 
  "MathSATQ1", "MathSATQ3", "VerbalSATQ1", "VerbalSATQ3", 
  "ACTQ1", "ACTQ3", "AppsReceived", "AppsAccepted", 
  "NewEnrolled", "Top10HSpct", "Top25HSpct", 
  "StudFulltime", "StudParttime", "InstateTuit", "OutstateTuit", 
  "Roomboard", "Room", "Board", "AddFees", "Books", 
  "PersonalSpending", "PhdPct", "TerminalPct", "DonatePct", "InstrucExpenditurePerStud", 
  "GraduationPct"
)

collegedata <- collegedata %>%
  mutate(across(all_of(cols_to_clean2), ~ {
    if (all(is.na(.))) .  # Skip if all values are NA (avoid NaN)
    else replace(., is.na(.), round(mean(., na.rm = TRUE), digits = 0))
  }))
###
collegedata$StudFacRatio[is.na(collegedata$StudFacRatio)]<-round(mean(collegedata$StudFacRatio,na.rm=TRUE),digits = 1)

head(collegedata)
###########################

#Exporting the cleaned data as a new csv/data file
write.csv(collegedata, file = "usnewstitledCLEAN.data", row.names = FALSE)

###########################
