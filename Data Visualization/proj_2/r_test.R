library(ggplot2)
library(dplyr)

data = read.csv("Sugars.csv", sep = ",")
#head(data)
#head(filtered_data)

#Prelimenary plot 1: Violin plot + box plot
dodge <- position_dodge(width = 0.5)
ggplot(data, aes_string(x = "Sugar", y = "C1..C2.", fill = "Base")) +
  geom_violin(width = 0.5, position = dodge) +
  geom_boxplot(width = 0.1, position = dodge) +
  theme_gray() +
  xlab( "Sugar moiety type" ) +
  ylab("C1'-C2' bond length [Å]") +
  scale_fill_manual(values= c("#9ebcda", "#8856a7"))

#Some variations:
dodge <- position_dodge(width = 0.5)
ggplot(data, aes_string(x = "Base", y = "C1..C2.", fill = "Gamma")) +
  geom_violin(width = 0.5, position = dodge) +
  xlab("Nitrogen base") +
  ylab("C1'-C2' bond length [Å]") +
  scale_fill_brewer(type="qual", palette = 1)
  #theme_gray()

#dodge <- position_dodge(width = 0.5)
#ggplot(data, aes_string(x = "Sugar", y = "C1..C2.", fill = "Gamma")) +
#  geom_violin(width = 0.5, position = dodge) +
#  geom_boxplot(width = 0.1, position = dodge) +
#  theme_gray()


#Prelimenary plot 0: Scatter plot showing the temperature ~ bond angle.
#ggplot(data = data, aes_string(x = "Temperature", y = "C1..C2..C3.", group = 1)) +
#  geom_point() +
#  xlab("Temperature [°C]") +
#  ylab("C1'-C2'-C3' Bond angle [°]")

#Prelimenary plot 2: temperature ~ bond length
#ggplot(data = data, aes_string(x = "Temperature", y = "C1..C2.", group = 1)) +
#  geom_point() +
#  xlab("Temperature [°C]") +
#  ylab("C1'-C2' Bond length [Å]") +
#  theme_bw()

#for (name in c("C1..C2.", "C2..C3.", "C3..O3.", "C1..O4.",
#               "C2..O2.", "C4..C5.", "C4..O4.", "C5..O5.",
#               "C1..C2..C3.", "C1..C2..O2.", "C1..O4..C4.",
#               "C2..C1..O4.", "C2..C3..C4.", "C2..C3..O3.",
#               "C3..C2..O2.", "C3..C2..O2.", "C3..C4.", "C3..C4..C5.",
#               "C3..C4..O4.", "C4..C3..O3.", "C4..C5..O5.", "C5..C4..O4.")) {
#  print(ggplot(data = data, aes_string(x = "Temperature", y = name, group = 1)) +
#          geom_point() +
#          xlab("Temperature [°C]") +
#          ylab("C1-C2-C3 Bond angle [°]")) }
#Graphs shows that there seem to be no relation between temperature and bond angle/length


#Prelimenary plot 3 histogram + standard distribution
#selected_data <- select(data, "C1..C2..C3.")
#values <- as.numeric(unlist(selected_data))
#n <- length(values)
#binwidth <- 0.3
#ggplot(data, aes_string(x = "C1..C2..C3."), binwidth = binwidth, n = n) +
#  geom_histogram(color = "black", fill = "white", bins = 15, binwidth = binwidth) +
#  stat_function(fun = function(x) dnorm(x, mean = mean(values), sd = sd(values)) * n * binwidth,
#                color = "darkred", size = 0.5) +
#  ylab("Count") +
#  xlab("C1'-C2'-C3' Bond angle [°]")
binwidth <- 0.003
#Prelimenary plot 3 histogram + standard distribution
#selected_data <- select(data, "C1..C2.")
#values <- as.numeric(unlist(selected_data))
#n <- length(values)
#print(values)
#ggplot(data, aes_string(x = "C1..C2."), binwidth = binwidth, n = n) +
#  geom_histogram(color = "black", fill = "white", bins = 25, binwidth = binwidth) +
#  stat_function(fun = function(x) dnorm(x, mean = mean(values), sd = sd(values)) * n * binwidth,
#                color = "darkred", size = 0.5) +
#  ylab("Count") +
#  xlab("C1'-C2' Bond length [Å]")
