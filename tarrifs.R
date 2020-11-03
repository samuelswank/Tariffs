library(ggplot2)
df <- read.csv("data/sample.csv")

colnames(df) <- c(
  "Year",
  "Country",
  "Region",
  "Tariff.Rate",
  "Income.Tax.Rate",
  "Corporate.Tax.Rate",
  "Tax.Burden",
  "Government.Expenditure",
  "Population.Millions",
  "GDP.Billions",
  "GDP.Growth.Rate",
  "Five.Year.GDP.Growth.Rate",
  "GDP.per.Capita",
  "Unemployment",
  "Inflation",
  "FDI.Inflow",
  "Public.Debt"
  )

df[df == "North America"] <- "Americas"
df[df == "Middle East and North Africa"] <- "Middle East / North Africa"

Tariff.GDP.Growth <- ggplot(
  # Accounting for obvious outliers
  subset(df, GDP.Growth.Rate > -5 & GDP.Growth.Rate < 20),
  aes(x = Tariff.Rate, y = GDP.Growth.Rate)
  ) +
  geom_point(aes(color = factor(Region))) +
  geom_smooth(method = "loess", se = F) +
  xlab("Tariff Rate") +
  ylab("GDP Growth Rate")

Tariff.GDP.Growth