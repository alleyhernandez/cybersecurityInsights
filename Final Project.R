# Load libraries
library(multcomp)
library(dplyr)

# Set options
options(scipen=999)

## US Overall Data #############################################################
# Load Yearly Summary Data
ic3yearly <- read.csv("IC3 Dataset Final.csv")

# Scaling the Adjusted.Loss
ic3yearly$Adjusted.Loss.Mil <- ic3yearly$Adjusted.Loss/1000000

# Barplots
barplot(Complaints~Year, data=ic3yearly,
    main="US Yearly Complaint Count", ylab="Complaint Count",
    col="skyblue")
barplot(Adjusted.Loss.Mil~Year, data=ic3yearly,
    main="US Yearly Victim Loss", ylab="Victim Loss ($ millions)",
    col="skyblue")


## US Yearly Crimes ############################################################
# Load Yearly Crime Data
ic3crimes <- read.csv("IC3 Yearly Crime Final.csv")

# Data Cleaning
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "BEC"] <- "BEC/AEC"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Confidence/Romance"] <- "Confidence Fraud/Romance"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Credit Card Fraud"] <- "Credit Card/Check Fraud"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Data Breach" | ic3crimes$Crime.Type == "Corporate Data Breach"] <- "Data Breach (Corporate)"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Personal Data Breach"] <- "Data Breach (Personal)"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Denial of Service"] <- "Denial of Service/TDoS"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "IPR/Copyright/Counterfeit"] <- "IPR/Copyright and Counterfeit"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Lottery/Sweepstakes"] <- "Lottery/Sweepstakes/Inheritance"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Malware" | ic3crimes$Crime.Type == "Malware/Scareware" | ic3crimes$Crime.Type == "Virus"] <- "Malware/Scareware/Virus"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Phishing"] <- "Phishing/Vishing/Smishing/Pharming"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Real Estate"] <- "Real Estate/Rental"
ic3crimes$Crime.Type[ic3crimes$Crime.Type == "Threats of Violence" | ic3crimes$Crime.Type == "Terrorism" | ic3crimes$Crime.Type == "Harassment/Threats of Violence"] <- "Terrorism/Threats of Violence"

ic3crimes$Count <- as.numeric(ic3crimes$Count)
ic3crimes$Loss <- as.numeric(ic3crimes$Loss)

# Create yearly subsets to facilitate yearly barplots 
# Focusing on 2019 - 2022
ic3crimes2022 <- ic3crimes[ic3crimes$Year == 2022, ]
ic3crimes2021 <- ic3crimes[ic3crimes$Year == 2021, ]
ic3crimes2020 <- ic3crimes[ic3crimes$Year == 2020, ]
ic3crimes2019 <- ic3crimes[ic3crimes$Year == 2019, ]
# ic3crimes2018 <- ic3crimes[ic3crimes$Year == 2018, ]
# ic3crimes2017 <- ic3crimes[ic3crimes$Year == 2017, ]
# ic3crimes2016 <- ic3crimes[ic3crimes$Year == 2016, ]
# ic3crimes2015 <- ic3crimes[ic3crimes$Year == 2015, ]

# 2022
ic3crimes2022.Count <- top_n(ic3crimes2022, 5, ic3crimes2022$Count)
ic3crimes2022.Count <- ic3crimes2022.Count[order(-ic3crimes2022.Count$Count), ]
barplot(height=ic3crimes2022.Count$Count, names.arg=ic3crimes2022.Count$Crime.Type,
    main="2022 Top 5 Cybercrime Attacks", xlab="Crime Type", ylab="Count",
    col="skyblue", ylim=c(0, 350000))
ic3crimes2022.Loss <- top_n(ic3crimes2022, 5, ic3crimes2022$Loss)
ic3crimes2022.Loss <- ic3crimes2022.Loss[order(-ic3crimes2022.Loss$Loss), ]
barplot(height=ic3crimes2022.Loss$Loss, names.arg=ic3crimes2022.Loss$Crime.Type,
    main="2022 Top 5 Cybercrime Attack Loss", xlab="Crime Type", ylab="Loss ($)",
    col="skyblue", ylim=c(0, 3500000000))

# 2021
ic3crimes2021.Count <- top_n(ic3crimes2021, 5, ic3crimes2021$Count)
ic3crimes2021.Count <- ic3crimes2021.Count[order(-ic3crimes2021.Count$Count), ]
barplot(height=ic3crimes2021.Count$Count, names.arg=ic3crimes2021.Count$Crime.Type,
    main="2021 Top 5 Cybercrime Attacks", xlab="Crime Type", ylab="Count",
    col="skyblue", ylim=c(0, 350000))
ic3crimes2021.Loss <- top_n(ic3crimes2021, 5, ic3crimes2021$Loss)
ic3crimes2021.Loss <- ic3crimes2021.Loss[order(-ic3crimes2021.Loss$Loss), ]
barplot(height=ic3crimes2021.Loss$Loss, names.arg=ic3crimes2021.Loss$Crime.Type,
    main="2021 Top 5 Cybercrime Attack Loss", xlab="Crime Type", ylab="Loss ($)",
    col="skyblue", ylim=c(0, 3500000000))

# 2020
ic3crimes2020.Count <- top_n(ic3crimes2020, 5, ic3crimes2020$Count)
ic3crimes2020.Count <- ic3crimes2020.Count[order(-ic3crimes2020.Count$Count), ]
barplot(height=ic3crimes2020.Count$Count, names.arg=ic3crimes2020.Count$Crime.Type,
    main="2020 Top 5 Cybercrime Attacks", xlab="Crime Type", ylab="Count",
    col="skyblue", ylim=c(0, 350000))
ic3crimes2020.Loss <- top_n(ic3crimes2020, 5, ic3crimes2020$Loss)
ic3crimes2020.Loss <- ic3crimes2020.Loss[order(-ic3crimes2020.Loss$Loss), ]
barplot(height=ic3crimes2020.Loss$Loss, names.arg=ic3crimes2020.Loss$Crime.Type,
    main="2020 Top 5 Cybercrime Attack Loss", xlab="Crime Type", ylab="Loss ($)",
    col="skyblue", ylim=c(0, 3500000000))

# 2019
ic3crimes2019.Count <- top_n(ic3crimes2019, 5, ic3crimes2019$Count)
ic3crimes2019.Count <- ic3crimes2019.Count[order(-ic3crimes2019.Count$Count), ]
barplot(height=ic3crimes2019.Count$Count, names.arg=ic3crimes2019.Count$Crime.Type,
    main="2019 Top 5 Cybercrime Attacks", xlab="Crime Type", ylab="Count",
    col="skyblue", ylim=c(0, 350000))
ic3crimes2019.Loss <- top_n(ic3crimes2019, 5, ic3crimes2019$Loss)
ic3crimes2019.Loss <- ic3crimes2019.Loss[order(-ic3crimes2019.Loss$Loss), ]
barplot(height=ic3crimes2019.Loss$Loss, names.arg=ic3crimes2019.Loss$Crime.Type,
    main="2019 Top 5 Cybercrime Attack Loss", xlab="Crime Type", ylab="Loss ($)",
    col="skyblue", ylim=c(0, 3500000000))


# Comparing Top Loss with Top Count
TopAttacks <- ic3crimes[ic3crimes$Crime.Type == "Phishing/Vishing/Smishing/Pharming" | ic3crimes$Crime.Type == "BEC/EAC",]

# Setup two column display
boxplot(Loss~Crime.Type, data=TopAttacks,
    main="Cybercrime Attack Loss Comparison (BEC/EAC vs Phishing/Vishing/Smishing/Pharming)", xlab="Crime Type", ylab="Loss ($)",
    col="skyblue")
boxplot(Count~Crime.Type, data=TopAttacks,
    main="Cybercrime Attack Comparison (BEC/EAC vs Phishing/Vishing/Smishing/Pharming)", xlab="Crime Type", ylab="Count",
    col="skyblue")

