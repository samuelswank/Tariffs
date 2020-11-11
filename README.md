# Tariffs

This repository contains a relatively simple data visualization project on the subject of Tariffs.

## Directory Structure

```
├── data
|    ├── adjusted.csv <- sample.csv adjusted for use in data visualizations found in plots directory
|    ├── combined.csv <- collation of all index xls files
|    ├── index2013_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2013
|    ├── index2014_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2014
|    ├── index2015_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2015
|    ├── index2016_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2016
|    ├── index2017_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2017
|    ├── index2018_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2018
|    ├── index2019_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2019
|    ├── index2020_data.xls <- Heritage Foundation's Index of Economic Freedom Data for Year 2020
|    └── sample.csv <- file containing sample countries and territory data used in creating adjusted.csv
├── plots
|    ├── TariffGDPGrowth.png <- ggplot2 visualization of GDP Growth Rate's relationship to the previous year's tariff rate for sample countries in 2017
|    └── TariffGDPperCapita.png <- ggplot2 visualization of Per Capita GDP's relationship to the previous year's tariff rate for sample countries from 2013-2017
├── .gitignore <- Files and directories to ignore in GitHub repo.
├── README.md  <- You are here! Tariffs Repository README file
├── tariffs.R  <- RScript used to create ggplot2 visualizations found in plots directory
└── tariffs.ipynb  <- IPython Notebook used to create sample.csv used in tariffs.R file and tables shown in Medium article
```

## Medium Article

[Tariffs and the Future of the Job Market](https://samswank.medium.com/tariffs-99b4989ef8ea) 
