library(ggplot2)
library(data.table)
sample.df <- read.csv("data/sample.csv")

colnames(sample.df) <- c(
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

sample.df[sample.df == "North America"] <- "Americas"
sample.df[sample.df == "Middle East and North Africa"] <- "Middle East / North Africa"

# Shifting the data.frame so that Tariff.Rate for the previous year's effect can
# be seen on the change in the GDP.Growth.Rate and GDP.per.Capita

shift <- function(x, n){
  c(x[-(seq(n))], rep(NA, n))
}

# Because each country has its own separate time series contained within the
# Year column, they need to be subsetted in order to be shifted properly 

by_country = list()

for (country in distinct(sample.df, Country)$Country){
  by_country[[country]] <- subset(sample.df, Country == country)[-c(5, 6, 7, 8, 9, 12, 15, 16)]
}

for (country in distinct(sample.df, Country)$Country){
  by_country[[country]]$Year <- shift(by_country[[country]]$Year, 1)
  by_country[[country]]$GDP.Billions <- shift(by_country[[country]]$GDP.Billions, 1)
  by_country[[country]]$GDP.Growth.Rate <- shift(by_country[[country]]$GDP.Growth.Rate, 1)
  by_country[[country]]$GDP.per.Capita <- shift(by_country[[country]]$GDP.per.Capita, 1)
  by_country[[country]]$Unemployment <- shift(by_country[[country]]$Unemployment, 1)
  by_country[[country]]$Public.Debt <- shift(by_country[[country]]$Public.Debt, 1)
}

for (country in distinct(sample.df, Country)$Country){
  by_country[[country]] <- by_country[[country]][-8,]
}

df <- rbindlist(by_country)

df$Year <- as.Date(df$Year)

# Calculating interquartile range to remove outliers
q1 <- quantile(df$GDP.Growth.Rate, 0.25, na.rm = TRUE)
med <- median(df$GDP.Growth.Rate, na.rm = TRUE)
q3 <- quantile(df$GDP.Growth.Rate, 0.75, na.rm = TRUE)
range <- q3 - q1

# Taking subset
no.outliers <- subset(
  df, GDP.Growth.Rate > (q1 - 1.5 * range) & GDP.Growth.Rate < (q3 + 1.5 * range)
)

Tariff.GDP.Growth <- ggplot(
  subset(no.outliers, Year == "2017-01-01"),
  aes(x = Tariff.Rate, y = GDP.Growth.Rate)
  ) +
  geom_point(aes(color = factor(Region), size = GDP.per.Capita)) +
  xlab("Tariff Rate") +
  ylab("GDP Growth Rate") +
  ggtitle("2017") +
  labs(color = "Region", size = "Per Capita GDP") +
  geom_text(
    aes(label = Country),
    subset(no.outliers, Year == "2017-01-01"),
    color = "gray20",
    check_overlap = T,
    position = position_dodge(width = 3.25)
    ) +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5))

Tariff.GDP.Growth

Tariff.GDP.per.Capita <- ggplot(
  subset(
    no.outliers,
    Year < as.Date("2018-01-01")
    ),
    aes(x = Tariff.Rate, y = GDP.per.Capita)
  ) +
  geom_point(aes(color = factor(Region))) +
  geom_smooth(method = "loess", se = F) +
  xlab("Tariff Rate") +
  ggtitle("Per Capita GDP") +
  labs(color = "Region") +
  geom_text(
    aes(label = Country),
    subset(no.outliers, Year == as.Date("2017-01-01")),
    color = "gray20",
    check_overlap = T
  ) +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5))

Tariff.GDP.per.Capita