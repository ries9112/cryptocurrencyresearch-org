---
title: "Cryptocurrency Research"
date: 'Last Updated:<br/> 2021-01-06 03:05:05'
author:
  - Riccardo (Ricky) Esclapon - [LinkedIn](https://www.linkedin.com/in/esclaponriccardo/), [Personal Website](https://resclapon.com/)
  - John Chandler Johnson - [LinkedIn](https://www.linkedin.com/in/john-chandler-johnson-361a666/)
  - Kai R. Larsen - [LinkedIn](https://www.linkedin.com/in/kai-r-larsen-4413a01/), [ResearchGate](https://www.researchgate.net/profile/Kai_Larsen)
site: bookdown::gitbook
documentclass: book
bibliography:
- packages.bib
- packages_two.bib
- zotero.bib
biblio-style: apalike
link-citations: yes
view: https://github.com/ries9112/cryptocurrencyresearch-org/blob/master/%s
---

# Introduction {#introduction}



Welcome to this programming tutorial on machine learning!

In this tutorial we will use live data from the cryptocurrency markets to provide a hands-on and complete example of time-series machine learning for everyone.

## What will I learn?

-   The focus of the tutorial is on supervised machine learning, a process for building models that can predict future events, such as cryptocurrency prices. You will learn how to use the [`caret`](https://topepo.github.io/caret/index.html) package to make many different predictive models, and tools to evaluate their performance.

-   In this tutorial you will primarily learn about tools for the R programming language developed by [RStudio](https://rstudio.com/) and more specifically the [`tidyverse`](https://www.tidyverse.org/). If you are not familiar with these open source products, don't worry. We'll introduce these throughout the tutorial as needed.


-   Before we can make the models themselves, we will need to "clean" the data. You will learn how to perform "group by" operations on your data using the [`dplyr`](https://dplyr.tidyverse.org/) package and to clean and modify grouped data.

<!-- -   You will be exposed to some useful data pre-processing R packages. -->

-   You will learn to visualize data using the [`ggplot2`](https://ggplot2.tidyverse.org/) package, as well as some powerful [tools to extend the functionality of ggplot2](https://exts.ggplot2.tidyverse.org/).

-   You will gain a better understanding of the steps involved in any supervised machine learning process, as well as considerations you might need to keep in mind based on your specific data and the way you plan on acting on the predictions you have made. Each problem comes with a unique set of challenges, but there are steps that are necessary in creating any supervised machine learning model, and questions you should ask yourself regardless of the specific problem at hand.

<!-- - [TODO - Add note on cross validation] -->

-   You will learn about the value of "reproducible" research.

-   You will also learn a little about cryptocurrencies themselves, but **this is not a tutorial centered around trading or blockchain technology**.

## Before Getting Started

You can toggle the sidebar on the left side of the page by clicking on the menu button in the top left, or by pressing on the **s** key on your keyboard. You can read this document as if it were a book, scrolling to the bottom of the page and going to the next "chapter", or navigating between sections using the sidebar.

This document is the tutorial itself, but in order to make the tutorial more accessible to people with less programming experience (or none) we created a [high-level version of this tutorial](https://cryptocurrencyresearch.org/high-level/), which simplifies both the problem at hand (what we want to predict) and the specific programming steps, but uses the same tools and methodology providing easier to digest examples on one cryptocurrency using a static dataset that does not get updated over time.

### High-Level Version {#high-level-version}

We recommend for everyone to run the code in the [high-level version first](https://cryptocurrencyresearch.org/high-level/) to get more comfortable with the tools we will be using. If you are not very familiar with programming in either R or Python, or are not sure what cryptocurrencies are, you should **definitely** work your way through the [high-level version first](https://cryptocurrencyresearch.org/high-level/).

Below is an embedded version of the high-level version, you can click on the presentation below and press the **`f`** button on your keyboard to full-screen it, or use any of the links above to view it in its own window:

<iframe src="https://cryptocurrencyresearch.org/high-level/" width="672" height="400px"></iframe>

\BeginKnitrBlock{infoicon}<div class="infoicon">When following along with the high-level tutorial embedded above, the results will be completely reproducible and the document is static and does not update over time meaning your results will exactly match those shown. The document you are currently reading this text on on the other hand updates every 12 hours. You will be able to access the same data source, but it updates hourly by the 8th minute of every hour with the most recent data, so this document and your results won't perfectly match.</div>\EndKnitrBlock{infoicon}

<!-- ### Approach taken -->

<!-- It is also worth mentioning that we will be taking a very practical approach to machine learning. Because we are modeling many cryptocurrencies independently at the same time and the dataset evolves as time passes, it becomes difficult to make a decision across the board in terms of what the "best model" to use is because it may change based on the specific cryptocurrency in question and/or over time. -->

<!-- [TODO - KEEP ADDING HERE?] -->

## Format Notes

-   You can hide the sidebar on the left by pressing the ***s*** key on your keyboard.

-   The cryptocurrency data was chosen to produce results that change over time and because these markets don't have any downtime (unlike the stock market).

<!-- [TODO - JUST LIKE THE HIGH LEVEL VERSION, WE WILL USE COLOR CODING] -->

-   Whenever an **R package** is referenced, the text will be [**colored orange**]{style="color: #ae7b11;"}. We will discuss ***R packages*** and the rest of the terms below later in this document, but if you are not familiar with these terms please look through the [high-level version first](https://cryptocurrencyresearch.org/high-level/).

-   Whenever a **function** is referenced, it will be [**colored green**]{style="color: green;"}.

-   Whenever an **R object** is referenced, it will be [**colored blue**]{style="color: blue;"}. We will also refer to the **parameters** of functions in [**blue**]{style="color: blue;"}.

-   When a **term** is particularly common in machine learning or data science, we will call it out with [**purple text**]{style="color: purple;"}, but only the first time it appears.

-   Whenever text is **`highlighted this way`**, that means it is a snippet of R code, which will usually be done to bring attention to specific parts of a longer piece of code.

- You can leave feedback on any content of either version of the tutorial, for example if something is not clearly explained, by <span style="background-color: #3297FD; color: white">highlighting</span> any text and clicking on the button that says **Annotate**. Please be aware that any feedback posted is publicly visible. Thanks to [Ben Marwick](https://twitter.com/benmarwick) for [the implementation of this tool](https://benmarwick.github.io/bookdown-ort/mods.html), and to [Matthew Galganik](https://twitter.com/msalganik) for creating the ["Open Review Toolkit" (OTR)](https://www.openreviewtoolkit.org/) we are using.


## Plan of Attack

How will we generate predictive models to predict cryptocurrency prices? At a high level, here are the steps we will be taking:

1.  [Setup guide](#setup). Installation guide on getting the tools used installed on your machine.

2.  [Explore data](#explore-data). What ***is*** the data we are working with? How "good" is the "quality"?

3.  [Prepare the data](#data-prep). Make adjustments to "clean" the data based on the findings from the previous section to avoid running into problems when making models to make predictions.

4.  [Visualize the data](#visualization). Visualizing the data can be an effective way to understand relationships, trends and outliers before creating predictive models, and is generally useful for many different purposes. Definitely the most fun section!

5.  [Make predictive models](#predictive-modeling). Now we are ready to take the data available to us and use it to make predictive models that can be used to make predictions about future price movements using the latest data.

6.  [Evaluate the performance of the models](#evaluate-model-performance). Before we can use the predictive models to make predictions on the latest data, we need to understand how well we expect them to perform, which is also essential in detecting issues.

## Who is this example for?

Are you a Bob, Hosung, or Jessica below? This section provides more information on how to proceed with this tutorial.

-   **Bob (beginner)**: Bob is someone who understands the idea of predictive analytics at a high level and has heard of cryptocurrencies and is interested in learning more about both, but he has never used R. Bob would want to [opt for the more high-level version of this tutorial](https://cryptocurrencyresearch.org/high-level/). Bob might benefit from reading the free book ["R for Data Science"](https://r4ds.had.co.nz/) as well before attempting this tutorial.

-   **Hosung (intermediate)**: Hosung is a statistician who learned to use R 10 years ago. He has heard of the tidyverse, but doesn't regularly use it in his work and he usually sticks to base R as his preference. Hosung should start with the [**high-level version of this tutorial**](https://cryptocurrencyresearch.org/high-level/) and later return to this version.

-   **Jessica (expert)**: Jessica is a business analyst who has experience with both R and the Tidyverse and uses the pipe operator (**`%\>%`**) regularly. Jessica should skim over the high-level version before [**moving onto the next section**](#introduction) for the detailed tutorial.


## Reproducibility

One of the objectives of this document is to showcase the power of [**reproducibility**]{style="color: purple;"}. This tutorial does not provide coded examples on making code reproducible, but it's worth a quick discussion. The term itself is defined in different ways:

-   We can think of something as reproducible if anyone can run the exact same analysis and end up with our exact same results. This is how the [high-level version of the tutorial](#high-level-version) works.

-   Depending on our definition, we may consider something reproducible if we can run the same analysis that is shown on a newer subset of the data without running into problems. This is how this version works, where the analysis done on your own computer would be between 1 and 12 hours newer than the one shown on this document.

### The cost of non-reproducible research

Reproducibility is especially important for research in many fields, but is a valuable tool for anyone who works with data, even within a large corporation. If you work with Excel files or any kind of data, there are tools to be aware of that can save you a lot of time and money. Even if you do things that are "more involved", for example using your data to run your analysis separately and then putting together a presentation with screenshots of your results with commentary, this is also something you can automate for the future. If you do any kind of repeated manual process in Excel, chances are you would be better off creating a script that you can simply kick off to generate new results. 

Reproducibility is all about making the life of anyone who needs to run the analysis as simple as possible, including and especially for the author herself. When creating a one-time analysis, the tool used should be great for the specific task as well as have the side-effect of being able to run again with the click of a button. In our case we are using a tool called [**R Markdown**]{style="color: purple;"} [@R-rmarkdown].
<!-- because if important discoveries are made others will want to perform their own experiments and analysis before they start being accepted as fact. -->

Not being transparent about the methodology and data (when possible) used is a quantifiable cost that should be avoided, both in research and in business. A study conducted in 2015 for example approximated that for preclinical research (mostly on pharmaceuticals) alone the economy suffers a cost of $28 Billion a year associated with non-reproducible research in the United States [@freedman_economics_2015]:

<embed src="images/TheEconomicsOfReproducibilityInPreclinicalRe.pdf" width="800px" height="460px" type="application/pdf" />

Reproducibility as discussed in the paper embedded above relates to many aspects of the specific field of preclinical research, but in their work they identified 4 main categories that drove costs associated with irreproducibility as it pertains to preclinical research in the United States: 

![](images/IrreproducibilityCosts.PNG)

The "Data Analysis and Reporting" aspect (circled in red in the screenshot above) of a project is shared across many disciplines. As it related to preclinical research, in their breakdown they attribute roughly $7.19 Billion of the costs of irreproducible preclinical research to data analysis and reporting, which could potentially be avoided through the usage of open source tools that we are utilizing for this tutorial. These costs should pale in comparison to the other three categories, and this example is meant to show that there currently exists a costly lack of awareness around these tools; the tutorial itself is meant as an example to showcase the power of these open source tools and the fact that a lot of complex analysis, including this one, can be written used reproducible tools that improve the quality and cost-effectiveness of projects.

<!-- In business reproducibility can be really valuable as well, being able to run an analysis with the click of a button can save a business a lot of money, and the open source tools available through R and Python  -->

### GitHub

<!-- To that end, rather than saying "this document can be refreshed at any point", the tutorial itself is not only reproducible (in terms of performing the same analysis for the future), but is in fact run on a recurring schedule. -->

As of 2020, the most popular way of sharing open source data science work is through a website called [[**GitHub**](https://github.com/)]{style="color: purple;"} which allows users to publicly share their code and do much more. This document gets refreshed using a tool called [[**Github Actions**](https://github.com/features/actions)]{style="color: purple;"} that runs some code and updates the file you are looking at on the public **GitHub** [**Repository**]{style="color: purple;"} for the project. The website then updates to show the latest version every time the document is refreshed on the GitHub repository.

<!-- [TODO - INTRODUCE GITHUB HERE] -->

#### GitHub Repository

The public **GitHub Repository** associated with this tutorial is not only a website for us to easily distribute all the code behind this document for others to view and use, but also where it actually runs. By clicking on the option that looks like an eye in the options given at the top of the document, you can view the raw code for the page you are currently viewing on the GitHub repository. Every 12 hours, a process gets kicked off on the page associated with our project on GitHub.com and refreshes these results. Anyone can view the latest runs as they execute over time here: <https://github.com/ries9112/cryptocurrencyresearch-org/actions>

In the [next section](#setup) we will talk more about the GitHub Repository for this tutorial, for now you can check on the latest run history for this document, which is expected to update every 12 hours every day: <https://github.com/ries9112/cryptocurrencyresearch-org/actions>

<!-- If you are seeing ✅ associated with the most recent runs at the link above, that means you are looking at a version that refreshed in the last 12 hours. If you are seeing red ❌ on the latest runs, you may be looking at an older analysis, but that should not be the case, check the timestamp at the top of this document to be sure. -->

If you are running into problems using the code or notice any problems, please let us know by creating an ***issue*** on the GitHub repository: <https://github.com/ries9112/cryptocurrencyresearch-org/issues>

Go to the [next section](#setup) for instructions on getting setup to follow along with the code run in the tutorial. You can run every step either in the cloud on your web browser, or in your own R session. You can even make a copy of the GitHub Repository on your computer and run this "book" on the latest data (updated hourly), and make changes wherever you would like. All explained in the next section ➡️

## Disclaimer

\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">This tutorial is made available for learning and educational purposes only and the information to follow does not constitute trading advice in any way shape or form. We avoid giving any advice when it comes to trading strategies, as this is a very complex ecosystem that is out of the scope of this tutorial; we make no attempt in this regard, and if this, rather than data science, is your interest, your time would be better spent following a different tutorial that aims to answer those questions.</div>\EndKnitrBlock{rmdimportant}

It should also be noted that this tutorial has nothing to do with trading itself, and that there is a difference between predicting crypotcurrency prices and creating an effective trading strategy. [**See this later section for more details on why the results shown in this document mean nothing in terms of the effectiveness of a trading strategy**](#considerations).

In this document we aimed to predict the change in cryptocurrency prices, and **it is very important to recognize that this is not the same as being able to successfully make money trading on the cryptocurrency markets**. 



<!--chapter:end:0-Introduction.Rmd-->

# Setup and Installation {#setup}

Every part of this document can be run on any computer either through a cloud notebook or locally.

You can also follow along with the tutorial without running the individual steps yourself. In that case, [**you can move on to the next page where the tutorial actually begins**](#explore-data).

## Option 1 - Run in the Cloud {#run-in-the-cloud}

If you do not currently have R and RStudio installed on your computer, you can run all of the code from your web browser one step at a time here: <a href="https://gesis.mybinder.org/binder/v2/gh/ries9112/high-level-reprex-jupyter/0a291fe130f30281009aecb61bff202f048617f8?filepath=Tutorial-Full.ipynb" target="_blank">**this mobile friendly link**</a>.

This can take up to 30 seconds to load, and once it has you should see a page that looks like this:

![](images/jupyter_notebook.png)

**From here, you can run the code one cell at a time:**

![](images/jupyter_run_one_cell.png)

*You can also use `Shift` + `Enter` to run an individual code cell*

**Or run all code cells at once:**

![](images/jupyter_run_all_cells.png)

**If you feel lost and are not familiar with Jupyter Notebooks, you can do a quick interactive walkthrough under *Help --\> User Interface Tour*:**

![](images/user_interface_tour.png)

## Option 2 - Run Locally

If you want to follow along from your own computer directly (recommended option), please follow the installation instructions below. Afterwards, you will be able to run the code. You only need to follow these instructions **once**. If you have followed these steps once already, [**skip ahead to the next section**](#overview).

### Setup R

If you do not already have **R** and **R Studio** installed on your computer, you will need to:

1.  [**Install R**](https://cran.revolutionanalytics.com/).

![](images/r_install.png)

2.  [**Install RStudio**](https://rstudio.com/products/rstudio/download/). This step is optional, but it is **very recommended** that you use an integrated development environment [(IDE)](https://en.wikipedia.org/wiki/Integrated_development_environment) like RStudio as you follow along, rather than just using the R console as it was installed in step 1 above.

![](images/rstudio_install.png)

3.  Once RStudio is installed, run the application on your computer and you are ready to run the code as it is shown below and in the rest of this document!

You can run your code directly through the **Console** (what you are prompted to write code into when RStudio boots up), or create a new document to save your code as you go along: ![](images/rstudio_new_file.PNG)

You will then be able to save your document with the .R extension on your computer and re-run your code line by line.

### Install and Load Packages {#installing-and-loading-packages}

Packages are collections of functions and data that other users have made shareable outside of the functionality provided by the *base* functionality of R that comes pre-loaded every time a new session is started. We can install these packages into our own library of R tools and load them into our R session, which can enable us to write powerful code with minimal effort compared to writing the same code without the additional packages. Many packages are simply time savers for things we could do with the default/base functionality of R, but sometimes if we want to do something like make a static chart interactive when hovering over points on the chart, we are better off using a package someone already came up with rather than re-inventing the wheel for a difficult task.

### Install Pacman

Let's start by installing the [**pacman**]{style="color: #ae7b11;"} package [@R-pacman] using the function [**install.packages()**]{style="color: green;"}:


```r
install.packages('pacman')
```
We only need to install any given package once on any given computer, kind of like installing an application (like RStudio or Google Chrome) once before being able to use it. When you boot-up your computer it doesn't open every application you have installed and similarly here we choose what functionality we need for our current session by importing packages. All functionality that is made available at the start (foundational functions like [mean()]{style="color: green;"} and [max()]{style="color: green;"}) of an R session is referred to as *Base R*, functionality from other packages needs to be loaded using the [**library()**]{style="color: green;"} function.

### Load Pacman
We can load the [**pacman**]{style="color: #ae7b11;"} package using the [**library()**]{style="color: green;"} function:


```r
library(pacman)
```

[**pacman**]{style="color: #ae7b11;"} does not refer to the videogame, and stands for [***pac***]{style="color: #ae7b11;"}***kage*** [***man***]{style="color: #ae7b11;"}***ager***. After we importing this package, we can now use new functions that come with it. 

### Install All Other Packages
We can use [**p_load()**]{style="color: green;"} to install the remaining packages we will need for the rest of the tutorial. The advantage to using the new function, is the installation will happen in a “smarter” way, where **if you already have a package in your library, it will not be installed again**.



```r
p_load('pins', 'skimr', 'DT', 'httr', 'jsonlite', # Data Exploration 
       'tidyverse', 'tsibble', 'anytime', # Data Prep
       'ggTimeSeries', 'gifski', 'av', 'magick', 'ggthemes', 'plotly', # Visualization
       'ggpubr', 'ggforce', 'gganimate', 'transformr', # Visualization continued
       'caret', 'doParallel', 'parallel', 'xgboost', # Predictive Modeling
       'brnn', 'party', 'deepnet', 'elasticnet', 'pls',  # Predictive Modeling continued
       'hydroGOF', 'formattable', 'knitr') # Evaluate Model Performance
```
***It is normal for this step to take a long time, as it will install every package you will need to follow along with the rest of the tutorial.*** The next time you run this command it would be much faster because it would skip installing the already installed packages.

Running **p\_load()** is equivalent to running [**install.packages()**]{style="color: green;"} on each of the packages listed **(but only when they are not already installed on your computer)**, and then running [**library()**]{style="color: green;"} for each package in quotes separated by commas to import the functionality from the package into the current R session. **Both commands are wrapped inside the single function call to** [**p\_load()**]{style="color: green;"}. We could run each command individually using base R and create our own logic to only install packages not currently installed, but we are better off using a package that has already been developed and scrutinized by many expert programmers; the same goes for complex statistical models, we don't need to create things from scratch if we understand how to properly use tools developed by the open source community. Open source tools have become particularly good in recent years and can be used for any kind of work, including commercial work, most large corporations have started using open source tools available through R and Python.

Nice work! Now you have everything you need to [follow along with this example](#overview) ➡️.

<!-- ### GitHub (KEEP OR DEL?) -->

<!-- Because this document is produced through a free **C**ontinuous **I**ntegration (CI) tool called **GitHub Actions**, it is also really easy for anyone to use the same code on their own computer to produce this document using the latest available data (or even automate their own process). -->

<!-- If you wanted to render this document in its entirety yourself, here is how you would do it using the application RStudio: -->

<!-- 1.  Create a copy of the GitHub project on your own computer by clicking on the button in the top right of the user interface to create a **New Project**: <!-- [TODO - ADD SCREENSHOT] -->

<!-- 2.  Run the code **`install.packages('bookdown')`** to install the [**Bookdown**]{style="color: orange;"} package. -->

<!-- 3.  Now you can run this document you are currently seeing on your own computer by running the command **`bookdown::render_book('index.Rmd')`**, which should take about one hour to execute. Once it is finished, the results will update in the \*\*\_book\*\* folder, and you can view the document by clicking on any .html file contained within that folder. -->

<!--     -   You can find more information around using and editing the **bookdown** format here: https://bookdown.org/yihui/bookdown/introduction.html -->

<!--     - Feel free to open an **issue** on the GitHub Repository if you are running into any problems: https://github.com/ries9112/cryptocurrencyresearch-org/issues -->

<!--chapter:end:01-Setup.Rmd-->

# Explore the Data {#explore-data}

## Pull the Data {#pull-the-data}

The first thing we will need to do is download the latest data. We will do this by using the [**pins**]{style="color: #ae7b11;"} package [@R-pins], which has already been loaded into our session [in the previous section](#installing-and-loading-packages).

First, we will need to connect to a public GitHub repository (as [previously described](#github)) and ***register*** the ***board*** that the data is ***pinned*** to by using the [**board\_register()**]{style="color: green;"} function:


```r
board_register(name = "pins_board", 
               url = "https://raw.githubusercontent.com/predictcrypto/pins/master/", 
               board = "datatxt")
```

By running the [**board\_register()**]{style="color: green;"} command on the URL where the data is located, we can now ***"ask"*** for the data we are interested in, which is called [**hitBTC\_orderbook**]{style="color: blue;"}, by using the [**pin\_get()**]{style="color: green;"} command:


```r
cryptodata <- pin_get(name = "hitBTC_orderbook")
```

<!-- Couldn't hide the progress bar so split it into a hidden code chunk instead -->



The data has been saved to the [**cryptodata**]{style="color: blue;"} object.

## Data Preview {#data-preview}



Below is a preview of the data:

preserveead81f4a8b845547

*Only the first 2,000 rows of the data are shown in the table above. There are 300000 rows in the actual full dataset. The latest data is from 2021-01-06 (UTC timezone).*

This is [[***tidy***]{style="color: purple;"} ***data***](https://tidyr.tidyverse.org/articles/tidy-data.html), meaning:

1.  Every column is a variable.

2.  Every row is an observation.

3.  Every cell is a single value relating to a specific variable and observation.

The data is collected once per hour. Each row is an observation of an individual cryptocurrency, and the same cryptocurrency is tracked on an hourly basis, each time presented as a new row in the dataset.

## The definition of a "price" {#the-definition-of-a-price}

When we are talking about the price of a cryptocurrency, there are several different ways to define it and there is a lot more than meets the eye. Most people check cryptocurrency "prices" on websites that aggregate data across thousands of exchanges, and have ways of computing a global average that represents the current "price" of the cryptocurrency. This is what happens on the very popular website [coinmarketcap.com](https://coinmarketcap.com/), but is this the correct approach for our use case?

Before we even start programming, a crucial step of any successful predictive modeling process is defining the problem in a way that makes sense in relation to the actions we are looking to take. If we are looking to trade a specific cryptocurrency on a specific exchange, using the global average price is not going to be the best approach because we might create a model that believes we could have traded at certain prices when this was actually not the case. If this was the only data available we could certainly try and extrapolate trends across all exchanges and countries, but a better alternative available to us is to define the price as the price that we could have **actually purchased** the cryptocurrency at. If we are interested in purchasing a cryptocurrency, we should consider data for the price we could have actually purchased it at.

### Order Book

A cryptocurrency exchange works by having a constantly evolving [[***order book***]{style="color: purple;"}](https://www.investopedia.com/terms/o/order-book.asp), where traders can post specific trades they want to make to either sell or buy a cryptocurrency specifying the price and quantity. When someone posts a trade to sell a cryptocurrency at a price that someone else is looking to purchase it at, a trade between the two parties will take place.

**You can find the live order book for the exchange we will be using here: <https://hitbtc.com/btc-to-usdt>**

From that page you can scroll down to view specific information relating to the orderbooks: ![](images/orderbook_ex.PNG)

#### Market Depth

Let's focus on the **Market Depth Chart** for now: ![](images/market_depth_chart.PNG)

Here, the x-axis shows the price of the cryptocurrency, with the lower prices on the left and the higher ones on the right, while the y-axis shows the cumulative volume (here in terms of Bitcoins) of orders that could currently be triggered on each side (the "liquidity" of the market).

In the screenshot above, around the \$13,000 price point the market essentially "runs out" of people willing to buy the cryptocurrency, and for prices past that point people are looking to sell the asset. The screenshot shows there are many orders that are waiting to be fulfilled, around the \$12,500 price point shown for example the chart tells us that if we wanted to buy the cryptocurrency BTC at that price there would have to be about 1,500 BTC sold for more expensive prices before the order was triggered. The market will fulfill trades that are posted to the order book and match buyers and sellers. The price at which the two sides of the orderbook converge is the price we could currently trade the cryptocurrency on this exchange at.

Because the price works this way, we couldn't simply buy 1,500 BTC at the \$13,000 price point because we would run out of people who are willing to sell their BTC at that price point, and to fulfill the entire order we would need to pay more than what we would consider to be the "price" depending on how much we were looking to purchase. **This is [one of the many reasons for why any positive results shown here wouldn't necessarily produce an effective trading strategy if put into practice in the real world](#considerations). There is a meaningful difference between predicting price movements for the cryptocurrency markets, and actually performing effective trades, so please experiment and play around with the data as much as you'd like, but hold back the urge to use this data to perform real trades.**

#### Live Order Book

Below the Market Depth Chart we can find the actual data relating to the order books visualized above:

![](images/orderbook_ex_zoomed.PNG)

**The data we will be working with is comprised by the top 5 price points of the order book on each side**. We have access to the 5 highest [**bid**]{style="color: purple;"} prices (on the side looking to buy), and the 5 lowest [**ask**]{style="color: purple;"} prices (from traders looking to sell). In relation to the screenshot above, the data we are using would be made up of the first 5 rows shown only.

### In Summary

To summarize the implications of what was explained above, the data we are using gives us the 5 nearest prices on both sides of where the red and green lines connect on the Market Depth Chart, as well as the quantity available to purchase or sell at that given price point.

In order to make predictive models to predict the price of a cryptocurrency, we will first need to define the price as the lowest available price that allows us to buy "enough" of it based on the current orderbook data as described above.

## Data Quality {#data-quality}

Before jumping into actually cleaning your data, it's worth spending time doing some [**Exploratory Data Analysis (EDA)**]{style="color: purple;"}, which is the process of analyzing the data itself for issues before starting on any other process. Most data science and business problems will require you to have a deep understanding of your dataset and all of its caveats and issues, and without those fundamental problems understood and accounted for no model will make sense. In our case this understanding mostly comes from understanding how the price of a cryptocurrency is defined, which [we reviewed above](#the-definition-of-a-price), and there isn't too much else for us to worry about in terms of the quality of the raw data, but in other cases doing EDA will be a more involved process doing things like visualizing the different columns of the data. There are a *lot* of tools that can be used for this, but as an example we can use one of the [packages we already imported into the R session in the setup section](#installing-and-loading-packages) called [**skimr**]{style="color: #ae7b11;"} [@R-skimr] to get a quick overview/summary of the "quality" of the different columns that make up the data.

We can use the [**skim()**]{style="color: green;"} function on the [cryptodata]{style="color: blue;"} dataframe to get a summary of the data to help locate any potential data quality issues:


```r
skim(cryptodata)
```


Table: (\#tab:skimr)Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |cryptodata |
|Number of rows           |300000     |
|Number of columns        |27         |
|_______________________  |           |
|Column type frequency:   |           |
|character                |5          |
|Date                     |1          |
|numeric                  |20         |
|POSIXct                  |1          |
|________________________ |           |
|Group variables          |           |


**Variable type: character**

|skim_variable  | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:--------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|pair           |         0|             1|   5|   9|     0|      225|          0|
|symbol         |         0|             1|   2|   6|     0|      225|          0|
|quote_currency |         0|             1|   3|   3|     0|        1|          0|
|pkDummy        |         0|             1|  13|  13|     0|     2567|          0|
|pkey           |         0|             1|  15|  19|     0|   299720|          0|


**Variable type: Date**

|skim_variable | n_missing| complete_rate|min        |max        |median     | n_unique|
|:-------------|---------:|-------------:|:----------|:----------|:----------|--------:|
|date          |         0|             1|2020-09-21 |2021-01-06 |2020-11-17 |      108|


**Variable type: numeric**

|skim_variable  | n_missing| complete_rate|      mean|         sd| p0|   p25|    p50|     p75|         p100|hist  |
|:--------------|---------:|-------------:|---------:|----------:|--:|-----:|------:|-------:|------------:|:-----|
|ask_1_price    |         0|             1|    247.89|    2042.90|  0|  0.01|   0.06|    0.51|     34453.37|▇▁▁▁▁ |
|ask_1_quantity |         0|             1| 157157.88| 3991898.51|  0| 22.37| 475.00| 5091.08| 455776000.00|▇▁▁▁▁ |
|ask_2_price    |         0|             1|    248.10|    2043.69|  0|  0.01|   0.06|    0.51|     34453.38|▇▁▁▁▁ |
|ask_2_quantity |         0|             1| 166256.85| 3708363.16|  0| 30.00| 631.00| 7242.50| 459459000.00|▇▁▁▁▁ |
|ask_3_price    |         0|             1|    248.30|    2044.40|  0|  0.01|   0.06|    0.52|     34453.40|▇▁▁▁▁ |
|ask_3_quantity |         0|             1| 179531.23| 4092530.34|  0| 23.53| 568.00| 7750.00| 518082000.00|▇▁▁▁▁ |
|ask_4_price    |         0|             1|    248.47|    2045.23|  0|  0.01|   0.06|    0.53|     34453.41|▇▁▁▁▁ |
|ask_4_quantity |         0|             1| 181238.87| 4047177.28|  0| 19.12| 500.00| 8200.00| 546546000.00|▇▁▁▁▁ |
|ask_5_price    |         0|             1|    249.11|    2051.42|  0|  0.01|   0.07|    0.56|     70000.00|▇▁▁▁▁ |
|ask_5_quantity |         0|             1| 188980.10| 4385486.36|  0| 15.00| 450.00| 7940.20| 549312000.00|▇▁▁▁▁ |
|bid_1_price    |         0|             1|    246.26|    2038.57|  0|  0.00|   0.05|    0.42|     34425.36|▇▁▁▁▁ |
|bid_1_quantity |         0|             1| 143880.79| 2294743.34|  0| 21.53| 540.95| 7674.00| 296583000.00|▇▁▁▁▁ |
|bid_2_price    |         0|             1|    246.11|    2037.87|  0|  0.00|   0.05|    0.42|     34425.35|▇▁▁▁▁ |
|bid_2_quantity |         0|             1| 139624.71| 2611615.73|  0| 26.50| 609.00| 7500.00| 332190000.00|▇▁▁▁▁ |
|bid_3_price    |         0|             1|    245.90|    2037.12|  0|  0.00|   0.05|    0.41|     34425.34|▇▁▁▁▁ |
|bid_3_quantity |         0|             1| 169280.25| 2859805.46|  0| 20.00| 502.00| 7134.05| 347366000.00|▇▁▁▁▁ |
|bid_4_price    |         0|             1|    245.63|    2036.21|  0|  0.00|   0.05|    0.40|     34425.33|▇▁▁▁▁ |
|bid_4_quantity |         0|             1| 211982.48| 3236597.33|  0| 13.26| 490.00| 7570.00| 331285000.00|▇▁▁▁▁ |
|bid_5_price    |         0|             1|    245.32|    2034.98|  0|  0.00|   0.04|    0.38|     34422.91|▇▁▁▁▁ |
|bid_5_quantity |         0|             1| 246904.25| 3845731.07|  0| 10.00| 431.20| 8250.90| 384159000.00|▇▁▁▁▁ |


**Variable type: POSIXct**

|skim_variable | n_missing| complete_rate|min                 |max                 |median              | n_unique|
|:-------------|---------:|-------------:|:-------------------|:-------------------|:-------------------|--------:|
|date_time_utc |         0|             1|2020-09-21 00:00:07 |2021-01-06 02:03:58 |2020-11-17 01:00:05 |   232223|

This summary helps us understand things like how many rows with missing values there are in a given column, or how the values are distributed. In this case there shouldn't be any major data quality issues, for example the majority of values should not be NA/missing. If you are noticing something different please [create an issue on the GitHub repository for the project](https://github.com/ries9112/cryptocurrencyresearch-org/issues).

One more optional section below for anyone who wants even more specific details around the entire process by which the data is collected and made available. Move on to the [next section](#data-prep), where we make the adjustments necessary to the data before we can start making visualizations and predictive models.

## Data Source Additional Details

**This section is optional for anyone who wants to know the** ***exact*** **process of how the data is sourced and refreshed**.

The data is pulled without authentication requirements using a public API endpoint made available by the HitBTC cryptocurrency exchange (the one we are using). See the code below for an actual example of how the data was sourced that runs every time this document runs. Below is an example pulling the Ethereum (ETH) cryptocurrency, if you followed the [setup steps](#install-all-other-packages) you should be able to run the code below for yourself to pull the live order book data:

<!-- ```{r orderbooks_live_example_function} -->

<!-- get_response_content <- function(api_response) { -->

<!--   fromJSON(content(api_response, -->

<!--                    type = "text", -->

<!--                    encoding = "UTF-8"), -->

<!--           simplifyDataFrame = FALSE) -->

<!-- } -->

<!-- ``` -->


```r
fromJSON(content(GET("https://api.hitbtc.com/api/2/public/orderbook/ETHUSD",
                     query=list(limit=5)),
                 type = "text",
                 encoding = "UTF-8"))
```

```
## $symbol
## [1] "ETHUSD"
## 
## $timestamp
## [1] "2021-01-06T03:05:23.223Z"
## 
## $batchingTime
## [1] "2021-01-06T03:05:23.241Z"
## 
## $ask
##      price    size
## 1 1074.572 30.0000
## 2 1074.625  5.2500
## 3 1074.626  3.0000
## 4 1074.627  1.1521
## 5 1074.628  3.0000
## 
## $bid
##      price   size
## 1 1074.069 0.6000
## 2 1073.999 0.5520
## 3 1073.550 5.2500
## 4 1073.549 5.0000
## 5 1073.548 1.5737
```

The data is collected by a script running on a private RStudio server that iterates through all cryptocurrency options one by one at the start of every hour from the HitBTC cryptocurrency exchange API order books data (as pulled above), and appends the latest data to a private database for long-term storage. Once the data is in the database, a different script gets kicked off every hour to publish the latest data from the database to the publicly available [**pins**]{style="color: #ae7b11;"} data source [discussed at the beginning of this section](#pull-the-data).

![](images/data_lifecycle.PNG){width="208"}




<!--chapter:end:02-ExploreData.Rmd-->

# Data Prep {#data-prep}

Next we will do some data cleaning to make sure our data is in the format we need it to be in. For a gentler introduction to data prep using the [**dplyr**]{style="color: #ae7b11;"} package [@R-dplyr] [consult the high-level version](https://cryptocurrencyresearch.org/high-level/#/data-prep).


## Remove Nulls {#remove-nulls}

First off, we aren't able to do anything at all with a row of data if we don't know ***when*** the data was collected. The specific price doesn't matter if we can't tie it to a timestamp, given by the [**date_time_utc**]{style="color: blue;"} field. 

We can exclude all rows where the [**date_time_utc**]{style="color: blue;"} field has a Null (missing) value by using the [**filter()**]{style="color: green;"} function from the [**dplyr**]{style="color: #ae7b11;"} package:




```r
cryptodata <- filter(cryptodata, !is.na(date_time_utc))
```
 


 
This step removed 0 rows from the data on the latest run (2021-01-06). The [**is.na()**]{style="color: green;"} function finds all cases where the [**date_time_utc**]{style="color: blue;"} field has a Null value. The function is preceded by the [**!**]{style="color: blue;"} operator, which tells the [**filter()**]{style="color: green;"} function to exclude these rows from the data.

By the same logic, if we don't know what the price was for any of the rows, the whole row of data is useless and should be removed. But how will we define the price of a cryptocurrency?

## Calculate `price_usd` Column

In the [previous section we discussed the intricacies of a cryptocurrency's price](#the-definition-of-a-price). We could complicate our definition of a price by considering both the [**bid**]{style="color: blue;"} and [**ask**]{style="color: blue;"} prices from the perspective of someone who wants to perform trades, but [**this is not a trading tutorial**](#considerations). Instead, we will define the price of a cryptocurrency as the price we could purchase it for. We will calculate the [**price_usd**]{style="color: blue;"} field using the cheapest price available from the [**ask**]{style="color: blue;"} side where at least \$15 worth of the cryptocurrency are being sold.

Therefore, let's figure out the lowest price from the order book data that would allow us to purchase at least \$15 worth of the cryptocurrency. To do this, for each [**ask**]{style="color: blue;"} price and quantity, let's figure out the value of the trade in US Dollars. We can create each of the new [**trade_usd**]{style="color: blue;"} columns using the [**mutate()**]{style="color: green;"} function. The [**trade_usd_1**]{style="color: blue;"} should be calculated as the [**ask_1_price**]{style="color: blue;"} multiplied by the [**ask_1_quantity**]{style="color: blue;"}. The next one [**trade_usd_2**]{style="color: blue;"} should consider the [**ask_2_price**]{style="color: blue;"}, but be multiplied by the sum of [**ask_1_quantity**]{style="color: blue;"} and [**ask_2_quantity**]{style="color: blue;"} because at the [**ask_2_price**]{style="color: blue;"} pricepoint we can also purchase the quantity available at the [**ask_1_price**]{style="color: blue;"} pricepoint:


```r
cryptodata <- mutate(cryptodata, 
                     trade_usd_1 = ask_1_price * ask_1_quantity,
                     trade_usd_2 = ask_2_price * (ask_1_quantity + ask_2_quantity),
                     trade_usd_3 = ask_3_price * (ask_1_quantity + ask_2_quantity + ask_3_quantity),
                     trade_usd_4 = ask_4_price * (ask_1_quantity + ask_2_quantity + ask_3_quantity + ask_4_quantity),
                     trade_usd_5 = ask_5_price * (ask_1_quantity + ask_2_quantity + ask_3_quantity + ask_4_quantity + ask_5_quantity))
```
<!-- *For a more in-depth explanation of how [**mutate()**]{style="color: green;"} works, [see the high-level version of the tutorial](https://cryptocurrencyresearch.org/high-level/#/mutate-function---dplyr)* -->

We can confirm that the [**trade_usd_1**]{style="color: blue;"} field is calculating the $ value of the lowest ask price and quantity:

```r
head(select(cryptodata, symbol, date_time_utc, ask_1_price, ask_1_quantity, trade_usd_1))
```

```
## # A tibble: 6 x 5
##   symbol date_time_utc       ask_1_price ask_1_quantity trade_usd_1
##   <chr>  <dttm>                    <dbl>          <dbl>       <dbl>
## 1 BTC    2021-01-06 00:00:00   33948.             0.219     7443.  
## 2 ETH    2021-01-06 00:00:01    1100.             0.6        660.  
## 3 EOS    2021-01-06 00:00:02       2.89          17.7         51.1 
## 4 LTC    2021-01-06 00:00:02     159.            60         9514.  
## 5 BSV    2021-01-06 00:00:04     168.             0.222       37.3 
## 6 ADA    2021-01-06 00:00:04       0.259         10            2.59
```

Now we can use the [**mutate()**]{style="color: green;"} function to create the new field [**price_usd**]{style="color: blue;"} and find the lowest price at which we could have purchased at least \$15 worth of the cryptocurrency. We can use the [**case_when()**]{style="color: green;"} function to find the first [**trade_usd**]{style="color: blue;"} value that is greater or equal to $15, and assign the correct [**ask_price**]{style="color: blue;"} for the new column [**price_usd**]{style="color: blue;"}:


```r
cryptodata <- mutate(cryptodata, 
                     price_usd = case_when(
                       cryptodata$trade_usd_1 >= 15 ~ cryptodata$ask_1_price,
                       cryptodata$trade_usd_2 >= 15 ~ cryptodata$ask_2_price,
                       cryptodata$trade_usd_3 >= 15 ~ cryptodata$ask_3_price,
                       cryptodata$trade_usd_4 >= 15 ~ cryptodata$ask_4_price,
                       cryptodata$trade_usd_5 >= 15 ~ cryptodata$ask_5_price))
```

Let's also remove any rows that have Null values for the new [**price_usd**]{style="color: blue;"} field [like we did for the [**date_time_utc**]{style="color: blue;"} field in a previous step](#remove-nulls). These will mostly be made up of rows where the value of trades through the 5th lowest ask price was lower than \$15.




```r
cryptodata <- filter(cryptodata, !is.na(price_usd))
```



This step removed 16291 rows on the latest run.


## Clean Data by Group {#clean-data-by-group}

In the [high-level version of this tutorial](https://cryptocurrencyresearch.org/high-level/) we only dealt with one cryptocurrency. In this version however, we will be creating independent models for each cryptocurrency. Because of this, **we need to ensure data quality not only for the data as a whole, but also for the data associated with each individual cryptocurrency**. Instead of considering all rows when applying a transformation, we can [**group**]{style="color: purple;"} the data by the individual cryptocurrency and apply the transformation to each group. This will only work with compatible functions from [**dplyr**]{style="color: #ae7b11;"} and the [**tidyverse**]{style="color: #ae7b11;"}.

For example, we could count the number of observations by running the [**count()**]{style="color: green;"} function on the data:

```r
count(cryptodata)
```

```
## # A tibble: 1 x 1
##        n
##    <int>
## 1 283709
```

But what if we wanted to know how many observations in the data are associated with each cryptocurrency separately?

We can group the data using the [**group_by()**]{style="color: green;"} function from the [**dplyr**]{style="color: #ae7b11;"} package and group the data by the cryptocurrency [**symbol**]{style="color: blue;"}:


```r
cryptodata <- group_by(cryptodata, symbol)
```

Now if we run the same operation using the [**count()**]{style="color: green;"} function, the operation is performed grouped by the cryptocurrency symbol:


```r
count(cryptodata)
```

```
## # A tibble: 223 x 2
## # Groups:   symbol [223]
##    symbol     n
##    <chr>  <int>
##  1 AAB     1787
##  2 ACAT    1631
##  3 ACT     2230
##  4 ADA     2459
##  5 ADXN     938
##  6 ALGO     212
##  7 AMB     1109
##  8 AMM       87
##  9 APL       69
## 10 APPC    2350
## # … with 213 more rows
```

We can remove the grouping at any point by running the [**ungroup()**]{style="color: green;"} function:

```r
count(ungroup(cryptodata))
```

```
## # A tibble: 1 x 1
##        n
##    <int>
## 1 283709
```


### Remove symbols without enough rows

Because this dataset evolves over time, we will need to be proactive about issues that may arise even if they aren't currently a problem. 

What happens if a new cryptocurrency gets added to the cryptocurrency exchange? If we only had a couple days of data for an asset, not only would that not be enough information to build effective predictive models, but we may run into actual errors since the data will be further split into more groups to validate the results of the models against several datasets using [**cross validation**]{style="color: purple;"}, more to come on that later.

To ensure we have a reasonable amount of data for each individual cryptocurrency, let's filter out any cryptocurrencies that don't have at least 1,000 observations using the [**filter()**]{style="color: green;"} function:




```r
cryptodata <- filter(cryptodata, n() >= 1000)
```



The number of rows for the `cryptodata` dataset before the filtering step was 283709 and is now 232446. This step removed 108 cryptocurrencies from the analysis that did not have enough observations associated with them.

### Remove symbols without data from the last 3 days

If there was no data collected for a cryptocurrency over the last 3 day period, let's exclude that asset from the dataset since we are only looking to model data that is currently flowing through the process. If an asset is removed from the exchange (if a project is a scam for example) or is no longer being actively captured by the data collection process, we can't make new predictions for it, so might as well exclude these ahead of time as well.




```r
cryptodata <- filter(cryptodata, max(date) > Sys.Date()-3)
```



The number of rows for the `cryptodata` dataset before this filtering step was 180530 and is now 232446.

## Calculate Target

Our goal is to be able to make predictions on the price of each cryptocurrency 24 hours into the future from when the data was collected. Therefore, the [**target variable**]{style="color: purple;"} that we will be using as *what we want to predict* for the predictive models, is the price 24 hours into the future relative to when the data was collected. 

To do this we can create a new column in the data that is the [**price_usd**]{style="color: blue;"} offset by 24 rows (one for each hour), but before we can do that we need to make sure there are no gaps anywhere in the data.

### Convert to tsibble {#convert-to-tsibble}

We can fill any gaps in the data using the [**tsibble**]{style="color: #ae7b11;"} package [@R-tsibble], which was covered in more detail in the [high-level version of the tutorial](https://cryptocurrencyresearch.org/high-level/#/timeseries-data-prep).

#### Convert to hourly data

The data we are using was collected between the 0th and the 5th minute of every hour; it is collected in the same order every hour to try and get the timing as consistent as possible for each cryptocurrency, but the cadence is not exactly one hour. Therefore, if we convert the data now to a [**tsibble**]{style="color: blue;"} object, it would recognize the data as being collected on the wrong cadence. 

To fix this issue, let's create a new column called [**ts_index**]{style="color: blue;"} using the [**mutate()**]{style="color: green;"} function which will keep the information relating to the date and hour collected, but generalize the minutes and seconds as "00:00", which will be correctly recognized by the [**tsibble**]{style="color: #ae7b11;"} package as being data collected on an hourly basis. The [**pkDummy**]{style="color: blue;"} field contains the date and hour, so we can add the text ":00:00" to the end of that field, and then convert the new string to a date time object using the [**anytime()**]{style="color: green;"} function from the [**anytime**]{style="color: #ae7b11;"} package [@R-anytime]:

```r
cryptodata <- mutate(cryptodata, ts_index = anytime(paste0(pkDummy,':00:00')))
```

Before we can convert the data to be a [**tsibble**]{style="color: blue;"} and easily fill in the gaps, we also need to make sure there are no duplicate values in the [**ts_index**]{style="color: blue;"} column for each cryptocurrency. There shouldn't be any duplicates, but just in case any make their way into the data somehow, we can use the [**distinct()**]{style="color: green;"} function from the [**dplyr**]{style="color: #ae7b11;"} package to prevent the issue from potentially arising:


```r
cryptodata <- distinct(cryptodata, symbol, ts_index, .keep_all=TRUE)
```

Now we can finally convert the table to a [**tsibble**]{style="color: blue;"} data type by using the [**as_tsibble()**]{style="color: green;"} function from the [**tsibble**]{style="color: #ae7b11;"} package [@R-tsibble], and providing the [**symbol**]{style="color: blue;"} column for the [**key**]{style="color: blue;"} parameter to preserve the grouped structure:   


```r
cryptodata <- as_tsibble(cryptodata, index = ts_index, key = symbol)
```

Notice how the preview of the data below looks a bit different from the summary we were seeing up to this point, and now it says "A tsibble", and next to the table dimensions says **[1h]**, indicating the observations are 1 hour apart from each other. The second row tells us the "Key" of the [**tsibble**]{style="color: blue;"} is the [**symbol**]{style="color: blue;"} column

```r
cryptodata
```

```
## # A tsibble: 180,360 x 34 [1h] <UTC>
## # Key:       symbol [81]
## # Groups:    symbol [81]
##    pair  symbol quote_currency ask_1_price ask_1_quantity ask_2_price
##    <chr> <chr>  <chr>                <dbl>          <dbl>       <dbl>
##  1 AABU… AAB    USD                  0.390           104.       0.39 
##  2 AABU… AAB    USD                  0.390           104.       0.39 
##  3 AABU… AAB    USD                  0.390           104.       0.39 
##  4 AABU… AAB    USD                  0.390           104.       0.39 
##  5 AABU… AAB    USD                  0.390           104.       0.39 
##  6 AABU… AAB    USD                  0.390           104.       0.39 
##  7 AABU… AAB    USD                  0.390           104.       0.39 
##  8 AABU… AAB    USD                  0.390           104.       0.390
##  9 AABU… AAB    USD                  0.390           104.       0.390
## 10 AABU… AAB    USD                  0.390           104.       0.390
## # … with 180,350 more rows, and 28 more variables: ask_2_quantity <dbl>,
## #   ask_3_price <dbl>, ask_3_quantity <dbl>, ask_4_price <dbl>,
## #   ask_4_quantity <dbl>, ask_5_price <dbl>, ask_5_quantity <dbl>,
## #   bid_1_price <dbl>, bid_1_quantity <dbl>, bid_2_price <dbl>,
## #   bid_2_quantity <dbl>, bid_3_price <dbl>, bid_3_quantity <dbl>,
## #   bid_4_price <dbl>, bid_4_quantity <dbl>, bid_5_price <dbl>,
## #   bid_5_quantity <dbl>, date_time_utc <dttm>, date <date>, pkDummy <chr>,
## #   pkey <chr>, trade_usd_1 <dbl>, trade_usd_2 <dbl>, trade_usd_3 <dbl>,
## #   trade_usd_4 <dbl>, trade_usd_5 <dbl>, price_usd <dbl>, ts_index <dttm>
```


<!-- ### Scan gaps -->

<!-- Now we can use the [**scan_gaps()**]{style="color: green;"} function to return   -->
<!-- ```{r} -->
<!-- scan_gaps(cryptodata) -->
<!-- ``` -->

### Fill gaps

Now we can use the [**fill_gaps()**]{style="color: green;"} function from the [**tsibble**]{style="color: #ae7b11;"} package to fill any gaps found in the data, as being implicitly Null. Meaning, we will add these rows into the data with NA values for everything except for the date time field. This will allow us to safely compute the target price found 24 hours into the future relative to when each row was collected.




```r
cryptodata <- fill_gaps(cryptodata)
```



Now looking at the data again, there are 17739 additional rows that were added as implicitly missing in the data:


```r
cryptodata
```

```
## # A tsibble: 198,099 x 34 [1h] <UTC>
## # Key:       symbol [81]
## # Groups:    symbol [81]
##    pair  symbol quote_currency ask_1_price ask_1_quantity ask_2_price
##    <chr> <chr>  <chr>                <dbl>          <dbl>       <dbl>
##  1 AABU… AAB    USD                  0.390           104.       0.39 
##  2 AABU… AAB    USD                  0.390           104.       0.39 
##  3 AABU… AAB    USD                  0.390           104.       0.39 
##  4 AABU… AAB    USD                  0.390           104.       0.39 
##  5 AABU… AAB    USD                  0.390           104.       0.39 
##  6 AABU… AAB    USD                  0.390           104.       0.39 
##  7 AABU… AAB    USD                  0.390           104.       0.39 
##  8 AABU… AAB    USD                  0.390           104.       0.390
##  9 AABU… AAB    USD                  0.390           104.       0.390
## 10 AABU… AAB    USD                  0.390           104.       0.390
## # … with 198,089 more rows, and 28 more variables: ask_2_quantity <dbl>,
## #   ask_3_price <dbl>, ask_3_quantity <dbl>, ask_4_price <dbl>,
## #   ask_4_quantity <dbl>, ask_5_price <dbl>, ask_5_quantity <dbl>,
## #   bid_1_price <dbl>, bid_1_quantity <dbl>, bid_2_price <dbl>,
## #   bid_2_quantity <dbl>, bid_3_price <dbl>, bid_3_quantity <dbl>,
## #   bid_4_price <dbl>, bid_4_quantity <dbl>, bid_5_price <dbl>,
## #   bid_5_quantity <dbl>, date_time_utc <dttm>, date <date>, pkDummy <chr>,
## #   pkey <chr>, trade_usd_1 <dbl>, trade_usd_2 <dbl>, trade_usd_3 <dbl>,
## #   trade_usd_4 <dbl>, trade_usd_5 <dbl>, price_usd <dbl>, ts_index <dttm>
```

Now that all of the gaps have been filled in, let's convert the data back to be in the structure of a [[**tibble**]{style="color: #ae7b11;"}](https://tibble.tidyverse.org/), which is the data structure that supports the [grouping structure we discussed previously](#clean-data-by-group), and let's group the data by the [**symbol**]{style="color: blue;"} again:


```r
cryptodata <- group_by(as_tibble(cryptodata), symbol)
```


### Calculate Target

Now we finally have everything we need to calculate the **target variable** containing the price 24 hours into the future relative to when the data was collected. We can use the usual [**mutate()**]{style="color: green;"} function to add a new column to the data called [**target_price_24h**]{style="color: blue;"}, and use the [**lead()**]{style="color: green;"} function from [**dplyr**]{style="color: #ae7b11;"} to offset the [**price_usd**]{style="color: blue;"} column by 24 hours:


```r
cryptodata <- mutate(cryptodata, 
                     target_price_24h = lead(price_usd, 24, order_by=ts_index))
```

### Calculate Lagged Prices

What about doing the opposite? If we added a new column showing the price from 24 hours earlier, could the price movement between then and when the data was collected help us predict where the price is headed next? If the price has gone down significantly over the previous 24 hours, is the price for the next 24 hours more likely to increase or decrease? What if the price has gone down significantly over the previous 24 hours, but has increased significantly since the past hour? 

These relationships around the sensitivity of a price to recent price changes may help our models come up with more accurate forecasts about the future, so let's go ahead and add some lagged prices using the same methodology used to calculate the target variable, but this time using the [**lag()**]{style="color: green;"} function to get past observations instead of the [**lead()**]{style="color: green;"} function used before:


```r
cryptodata <- mutate(cryptodata,
                     lagged_price_1h  = lag(price_usd, 1, order_by=ts_index),
                     lagged_price_2h  = lag(price_usd, 2, order_by=ts_index),
                     lagged_price_3h  = lag(price_usd, 3, order_by=ts_index),
                     lagged_price_6h  = lag(price_usd, 6, order_by=ts_index),
                     lagged_price_12h = lag(price_usd, 12, order_by=ts_index),
                     lagged_price_24h = lag(price_usd, 24, order_by=ts_index),
                     lagged_price_3d  = lag(price_usd, 24*3, order_by=ts_index))
```
*This step can be thought of as [**data engineering**]{style="color: purple;"} more than data cleaning, because rather than fixing an issue we are enhancing the dataset with columns that may help with the forecasts.*

Let's view an example of the oldest 30 rows of data associated with the Bitcoin cryptocurrency (`symbol == "BTC"`). With the oldest data starting from the top, the [**lagged_price_1h**]{style="color: blue;"} field should have a NA value for the first row because we don't have any prices before that point. By that same logic, the [**lagged_price_24h**]{style="color: blue;"} column should be missing the first 24 values and have the last 6 values showing the first 6 rows of the [**price_usd**]{style="color: blue;"} column. The [**target_price_24h**]{style="color: blue;"} would values for the oldest data because the opposite is true and we don't know the values for data for the most recent 24 rows of the data:


```r
print(select(filter(cryptodata, symbol == 'BTC'), 
             ts_index, price_usd, lagged_price_1h, 
             lagged_price_24h, target_price_24h), n=30)
```

```
## # A tibble: 2,571 x 6
## # Groups:   symbol [1]
##    symbol ts_index            price_usd lagged_price_1h lagged_price_24h
##    <chr>  <dttm>                  <dbl>           <dbl>            <dbl>
##  1 BTC    2020-09-21 00:00:00    10923.             NA               NA 
##  2 BTC    2020-09-21 01:00:00    10965.          10923.              NA 
##  3 BTC    2020-09-21 02:00:00    10953.          10965.              NA 
##  4 BTC    2020-09-21 03:00:00    10945.          10953.              NA 
##  5 BTC    2020-09-21 04:00:00    10964.          10945.              NA 
##  6 BTC    2020-09-21 05:00:00    10959.          10964.              NA 
##  7 BTC    2020-09-21 06:00:00    10962.          10959.              NA 
##  8 BTC    2020-09-21 07:00:00    10950.          10962.              NA 
##  9 BTC    2020-09-21 08:00:00    10899.          10950.              NA 
## 10 BTC    2020-09-21 09:00:00    10849.          10899.              NA 
## 11 BTC    2020-09-21 10:00:00       NA           10849.              NA 
## 12 BTC    2020-09-21 11:00:00    10660.             NA               NA 
## 13 BTC    2020-09-21 12:00:00    10631.          10660.              NA 
## 14 BTC    2020-09-21 13:00:00    10566.          10631.              NA 
## 15 BTC    2020-09-21 14:00:00    10584.          10566.              NA 
## 16 BTC    2020-09-21 15:00:00    10411.          10584.              NA 
## 17 BTC    2020-09-21 16:00:00    10416.          10411.              NA 
## 18 BTC    2020-09-21 17:00:00    10390.          10416.              NA 
## 19 BTC    2020-09-21 18:00:00    10397.          10390.              NA 
## 20 BTC    2020-09-21 19:00:00    10436.          10397.              NA 
## 21 BTC    2020-09-21 20:00:00    10480.          10436.              NA 
## 22 BTC    2020-09-21 21:00:00    10479.          10480.              NA 
## 23 BTC    2020-09-21 22:00:00    10507.          10479.              NA 
## 24 BTC    2020-09-21 23:00:00       NA           10507.              NA 
## 25 BTC    2020-09-22 00:00:00    10424.             NA            10923.
## 26 BTC    2020-09-22 01:00:00    10467.          10424.           10965.
## 27 BTC    2020-09-22 02:00:00    10440.          10467.           10953.
## 28 BTC    2020-09-22 03:00:00    10473.          10440.           10945.
## 29 BTC    2020-09-22 04:00:00    10453.          10473.           10964.
## 30 BTC    2020-09-22 05:00:00    10470.          10453.           10959.
## # … with 2,541 more rows, and 1 more variable: target_price_24h <dbl>
```

We can wrap the code used above in the [**tail()**]{style="color: green;"} function to show the most recent data and see the opposite dynamic with the new fields we created:


```r
print(tail(select(filter(cryptodata, symbol == 'BTC'), 
                  ts_index, price_usd, lagged_price_24h, 
                  target_price_24h),30), n=30)
```

```
## # A tibble: 30 x 5
## # Groups:   symbol [1]
##    symbol ts_index            price_usd lagged_price_24h target_price_24h
##    <chr>  <dttm>                  <dbl>            <dbl>            <dbl>
##  1 BTC    2021-01-04 21:00:00    31230.           33700.           33981.
##  2 BTC    2021-01-04 22:00:00    30990.           33537.           33702.
##  3 BTC    2021-01-04 23:00:00    31288.           33110.           34171.
##  4 BTC    2021-01-05 00:00:00    31973.           32978            33948.
##  5 BTC    2021-01-05 01:00:00    32422.           32822            33909.
##  6 BTC    2021-01-05 02:00:00    32762.           33195.           33814.
##  7 BTC    2021-01-05 03:00:00    32283.           33453.              NA 
##  8 BTC    2021-01-05 04:00:00    31176            33492.              NA 
##  9 BTC    2021-01-05 05:00:00    30858.           33264.              NA 
## 10 BTC    2021-01-05 06:00:00    30439.           32810.              NA 
## 11 BTC    2021-01-05 07:00:00    31118.           33112.              NA 
## 12 BTC    2021-01-05 08:00:00    30822.           32077.              NA 
## 13 BTC    2021-01-05 09:00:00    31194.           32026.              NA 
## 14 BTC    2021-01-05 10:00:00    31561.           30993.              NA 
## 15 BTC    2021-01-05 11:00:00    31342.           30192.              NA 
## 16 BTC    2021-01-05 12:00:00    31783.           30706.              NA 
## 17 BTC    2021-01-05 13:00:00    31589.           31187.              NA 
## 18 BTC    2021-01-05 14:00:00    31466.           31397.              NA 
## 19 BTC    2021-01-05 15:00:00    32356.           32082.              NA 
## 20 BTC    2021-01-05 16:00:00    32104.           31715.              NA 
## 21 BTC    2021-01-05 17:00:00    32485.           31266.              NA 
## 22 BTC    2021-01-05 18:00:00    32754.           30983.              NA 
## 23 BTC    2021-01-05 19:00:00    33364.           31147.              NA 
## 24 BTC    2021-01-05 20:00:00    33691.           31658.              NA 
## 25 BTC    2021-01-05 21:00:00    33981.           31230.              NA 
## 26 BTC    2021-01-05 22:00:00    33702.           30990.              NA 
## 27 BTC    2021-01-05 23:00:00    34171.           31288.              NA 
## 28 BTC    2021-01-06 00:00:00    33948.           31973.              NA 
## 29 BTC    2021-01-06 01:00:00    33909.           32422.              NA 
## 30 BTC    2021-01-06 02:00:00    33814.           32762.              NA
```

Reading the code shown above is less than ideal. One of the more popular tools introduced by the [tidyverse](https://www.tidyverse.org/) is the [**%>%**]{style="color: purple;"} operator, which works by starting with the object/data you want to make changes to first, and then apply each transformation step by step. It's simply a way of re-writing the same code in a way that is easier to read by splitting the way the function is called rather than adding functions onto each other into a single line that becomes really hard to read. In the example above it becomes difficult to keep track of where things begin, the order of operations, and the parameters associated with the specific functions. Compare that to the code below:


```r
# Start with the object/data to manipulate
cryptodata %>% 
  # Filter the data to only the BTC symbol
  filter(symbol == 'BTC') %>% 
  # Select columns to display
  select(ts_index, price_usd, lagged_price_24h, target_price_24h) %>% 
  # Show the last 30 elements of the data
  tail(30) %>% 
  # Show all 30 elements instead of the default 10 for a tibble dataframe
  print(n = 30)
```

```
## # A tibble: 30 x 5
## # Groups:   symbol [1]
##    symbol ts_index            price_usd lagged_price_24h target_price_24h
##    <chr>  <dttm>                  <dbl>            <dbl>            <dbl>
##  1 BTC    2021-01-04 21:00:00    31230.           33700.           33981.
##  2 BTC    2021-01-04 22:00:00    30990.           33537.           33702.
##  3 BTC    2021-01-04 23:00:00    31288.           33110.           34171.
##  4 BTC    2021-01-05 00:00:00    31973.           32978            33948.
##  5 BTC    2021-01-05 01:00:00    32422.           32822            33909.
##  6 BTC    2021-01-05 02:00:00    32762.           33195.           33814.
##  7 BTC    2021-01-05 03:00:00    32283.           33453.              NA 
##  8 BTC    2021-01-05 04:00:00    31176            33492.              NA 
##  9 BTC    2021-01-05 05:00:00    30858.           33264.              NA 
## 10 BTC    2021-01-05 06:00:00    30439.           32810.              NA 
## 11 BTC    2021-01-05 07:00:00    31118.           33112.              NA 
## 12 BTC    2021-01-05 08:00:00    30822.           32077.              NA 
## 13 BTC    2021-01-05 09:00:00    31194.           32026.              NA 
## 14 BTC    2021-01-05 10:00:00    31561.           30993.              NA 
## 15 BTC    2021-01-05 11:00:00    31342.           30192.              NA 
## 16 BTC    2021-01-05 12:00:00    31783.           30706.              NA 
## 17 BTC    2021-01-05 13:00:00    31589.           31187.              NA 
## 18 BTC    2021-01-05 14:00:00    31466.           31397.              NA 
## 19 BTC    2021-01-05 15:00:00    32356.           32082.              NA 
## 20 BTC    2021-01-05 16:00:00    32104.           31715.              NA 
## 21 BTC    2021-01-05 17:00:00    32485.           31266.              NA 
## 22 BTC    2021-01-05 18:00:00    32754.           30983.              NA 
## 23 BTC    2021-01-05 19:00:00    33364.           31147.              NA 
## 24 BTC    2021-01-05 20:00:00    33691.           31658.              NA 
## 25 BTC    2021-01-05 21:00:00    33981.           31230.              NA 
## 26 BTC    2021-01-05 22:00:00    33702.           30990.              NA 
## 27 BTC    2021-01-05 23:00:00    34171.           31288.              NA 
## 28 BTC    2021-01-06 00:00:00    33948.           31973.              NA 
## 29 BTC    2021-01-06 01:00:00    33909.           32422.              NA 
## 30 BTC    2021-01-06 02:00:00    33814.           32762.              NA
```

There are several advantages to writing code *the* ***tidy*** *way*, but while some love it others hate it, so we won't force anyone to have to understand how the **%>%** operator works and we have stayed away from its use for the rest of the code shown, but we do encourage the use of this tool: https://magrittr.tidyverse.org/reference/pipe.html


## Remove Nulls {#remove-nulls-again}

We can't do anything with a row of data if we don't know ***when*** the data was collected, so let's just double confirm that all rows have a value for the [**date_time_utc**]{style="color: blue;"} field by using the [**filter()**]{style="color: green;"} function from the [**dplyr**]{style="color: #ae7b11;"} package to exclude any rows with NA values for the column:




```r
# Remove all NA values of date_time_utc:
cryptodata <- filter(cryptodata, !is.na(date_time_utc))
```

<!-- Uncomment code below if visualization section runs into issues on ggforce step circling low and high point correctly -->
<!-- And now the same thing for the [**price_usd**]{style="color: blue;"} column: -->

<!-- ```{r omit_nulls_price_usd_final} -->
<!-- cryptodata <- filter(cryptodata, !is.na(price_usd)) -->
<!-- ``` -->



This step removed 17739 rows from the data. This step mainly helps us avoid issues when programmatically labeling charts in the next section, move on to the [next section](#visualization) ➡️ to learn some amazingly powerful tools to visualize data!


<!--chapter:end:03-DataPrep.Rmd-->

# Visualization 📉

Making visualizations using the [**ggplot2**]{style="color: #ae7b11;"} package [@R-ggplot2] is one of the very best tools available in the R ecosystem. The ***gg*** in [**ggplot2**]{style="color: #ae7b11;"} stands for the [***Grammar of Graphics***]{style="color: purple;"}, which is essentially the idea that many different types of charts share the same underlying building blocks, and that they can be put together in different ways to make charts that look very different from each other. [In Hadley Wickham's (the creator of the package) own words,](https://qz.com/1007328/all-hail-ggplot2-the-code-powering-all-those-excellent-charts-is-10-years-old/) ***"a pie chart is just a bar chart drawn in polar coordinates", "They look very different, but in terms of the grammar they have a lot of underlying similarities."***

## Basics - ggplot2

So how does [**ggplot2**]{style="color: #ae7b11;"} actually work? ***"...in most cases you start with [**ggplot()**]{style="color: green;"}, supply a dataset and aesthetic mapping (with [**aes()**]{style="color: green;"}). You then add on layers (like [**geom_point()**]{style="color: green;"} or [**geom_histogram()**]{style="color: green;"}), scales (like [**scale_colour_brewer()**]{style="color: green;"}), faceting specifications (like [**facet_wrap()**]{style="color: green;"}) and coordinate systems (like [**coord_flip()**]{style="color: green;"})."*** - [ggplot2.tidyverse.org/](https://ggplot2.tidyverse.org/).

Let's break this down step by step.

***"start with [**ggplot()**]{style="color: green;"}, supply a dataset and aesthetic mapping (with [**aes()**]{style="color: green;"})***

Using the [**ggplot()**]{style="color: green;"} function we supply the dataset first, and then define the aesthetic mapping (the visual properties of the chart) as having the [**date_time_utc**]{style="color: blue;"} on the x-axis, and the [**price_usd**]{style="color: blue;"} on the y-axis:


```r
ggplot(data = cryptodata, aes(x = date_time_utc, y = price_usd))
```

<img src="CryptoResearchPaper_files/figure-html/ggplot_blank-1.png" width="672" />

We were expecting a chart showing price over time, but the chart now shows up but is blank because we need to perform an additional step to determine how the data points are actually shown on the chart: ***"You then add on layers (like [**geom_point()**]{style="color: green;"} or [**geom_histogram()**]{style="color: green;"})..."***

We can take the exact same code as above and add ***+ [**geom_point()**]{style="color: green;"}*** to show the data on the chart as points:


```r
ggplot(data = cryptodata, aes(x = date_time_utc, y = price_usd)) +
       # adding geom_point():
       geom_point()
```

<img src="CryptoResearchPaper_files/figure-html/ggplot_geom_point-1.png" width="672" />

The most expensive cryptocurrency being shown, "BTC" in this case, makes it difficult to take a look at any of the other ones. Let's try *zooming-in* on a single one by using the same code but making an adjustment to the [**data**]{style="color: blue;"} parameter to only show data for the cryptocurrency with the symbol **ETH**.

Let's filter the data down to the *ETH* cryptocurrency only and make the new dataset [**eth_data**]{style="color: blue;"}:


```r
eth_data <- subset(cryptodata, symbol == 'ETH')
```

We can now use the exact same code from earlier supplying the new filtered dataset for the [**data**]{style="color: blue;"} argument:


```r
ggplot(data = eth_data, 
       aes(x = date_time_utc, y = price_usd)) + 
       geom_point()
```

<img src="CryptoResearchPaper_files/figure-html/ggplot_ETH-1.png" width="672" />

<!-- *The axis automatically adjusted to the new data.* -->

This is better, but [**geom_point()**]{style="color: green;"} might not be the best choice for this chart, let's change [**geom_point()**]{style="color: green;"} to instead be [**geom_line()**]{style="color: green;"} and see what that looks like:


```r
ggplot(data = eth_data, 
       aes(x = date_time_utc, y = price_usd)) + 
       # changing geom_point() into geom_line():
       geom_line()
```

<img src="CryptoResearchPaper_files/figure-html/ggplot_ETH_line-1.png" width="672" />

Let's save the results as an object called [**crypto_chart**]{style="color: blue;"}:


```r
crypto_chart <- ggplot(data = eth_data, 
                       aes(x = date_time_utc, y = price_usd)) + 
                       geom_line()
```

We can add a line showing the trend over time adding [**stat_smooth()**]{style="color: green;"} to the chart:


```r
crypto_chart <- crypto_chart + stat_smooth()
```

And we can show the new results by calling the [**crypto_chart**]{style="color: blue;"} object again:


```r
crypto_chart
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-24-1.png" width="672" />

One particularly nice aspect of using the ggplot framework, is that we can keep adding as many elements and transformations to the chart as we would like with no limitations.

We will not save the result shown below this time, but to illustrate this point, we can add a new line showing a linear regression fit going through the data using **`stat_smooth(method = 'lm')`**. And let's also show the individual points in green. We could keep layering things on as much as we want:


```r
crypto_chart + 
        # Add linear regression line
        stat_smooth(method = 'lm', color='red') + 
        # Add points
        geom_point(color='dark green', size=0.8)
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-25-1.png" width="672" />

By not providing any [**method**]{style="color: blue;"} option, the [**stat_smooth()**]{style="color: green;"} function defaults to use the [**method**]{style="color: blue;"} called [**`loess`**, which shows the local trends](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/loess), while the **`lm`** model fits the best fitting linear regression line for the data as a whole. The results shown above were not used to overwrite the [**crypto_chart**]{style="color: blue;"} object.

<!-- Removed the step below to keep engagement higher -->
<!-- Before doing some additional formatting to the [**crypto_chart**]{style="color: blue;"} object, let's show one more example adding a new [red]{style="color: red;"} line for the [**target_price_24h**]{style="color: blue;"} column which we will aim to [predict in the predictive modeling section](#predictive-modeling), as well as an [orange]{style="color: orange;"} line showing the price 3 days in the past using the column [**lagged_price_3d**]{style="color: blue;"}. Again, we are **not overwriting** the results for the [**crypto_chart**]{style="color: blue;"} object: -->
<!-- ```{r chart_target_and_lagged} -->
<!-- crypto_chart +  -->
<!--         # red line showing target -->
<!--         geom_line(aes(x=date_time_utc, y = target_price_24h), color = 'red') +  -->
<!--         # orange line showing price 3 days before -->
<!--         geom_line(aes(x=date_time_utc, y = lagged_price_3d), color = 'orange') -->
<!-- ``` -->

It is of course important to add other components that make a visualization effective, let's add labels to the chart now using [**xlab()**]{style="color: green;"} and [**ylab()**]{style="color: green;"}, as well as [**ggtitle()**]{style="color: green;"} to add a title and subtitle:


```r
crypto_chart <- crypto_chart +
                  xlab('Date Time (UTC)') +
                  ylab('Price ($)') +
                  ggtitle(paste('Price Change Over Time -', eth_data$symbol),
                          subtitle = paste('Most recent data collected on:', 
                                           max(eth_data$date_time_utc),
                                           '(UTC)'))
# display the new chart
crypto_chart
```

<img src="CryptoResearchPaper_files/figure-html/ggplot_labels-1.png" width="672" />

The [**ggplot2**]{style="color: #ae7b11;"} package comes with a large amount of functionality that we are not coming even close to covering here. You can find a full reference of the functions you can use here:

<iframe src="https://ggplot2.tidyverse.org/reference/" width="672" height="400px"></iframe>

[*https://ggplot2.tidyverse.org/reference/*](https://ggplot2.tidyverse.org/reference/){.uri}

What makes the [**ggplot2**]{style="color: #ae7b11;"} package **even better** is the fact that [it also comes with a framework for anyone to develop their own extensions](https://cran.r-project.org/web/packages/ggplot2/vignettes/extending-ggplot2.html). Meaning there is a lot more functionality that the community has created that can be added in importing other packages that provide extensions to ggplot.

## Using Extensions

### ggthemes

To use an extension, we just need to import it into our R session like we did with [**ggplot2**]{style="color: #ae7b11;"} and the rest of the packages we want to use. We [already loaded the [**ggthemes**]{style="color: #ae7b11;"} [@R-ggthemes] package in the Setup section](#setup) so we do not need to run **`library(ggthemes)`** to import the package into the session.

We can apply a *theme* to the chart now and change the way it looks:


```r
crypto_chart <- crypto_chart + theme_economist()
# display the new chart
crypto_chart
```

<img src="CryptoResearchPaper_files/figure-html/ggthemes-1.png" width="672" />

See below for a full list of themes you can test. If you followed to this point try running the code **`crypto_chart + theme_excel()`** or any of the other options listed below instead of **`+ theme_excel()`**:

<iframe src="https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/" width="672" height="500px"></iframe>

[*https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/*](https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/){.uri}

### plotly

In some cases, it's helpful to make a chart responsive to a cursor hovering over it. We can convert any ggplot into an interactive chart by using the [**plotly**]{style="color: #ae7b11;"} [@R-plotly] package, and it is super easy!

We already imported the [**plotly**]{style="color: #ae7b11;"} package [in the setup section](#setup), so all we need to do is wrap our chart in the function [**ggplotly()**]{style="color: green;"}:


```r
ggplotly(crypto_chart)
```

preservef765cf1f3110811f

**Use your mouse to hover over specific points on the chart above**. Also notice that we did not overwrite the [**crypto_chart**]{style="color: blue;"} object, but are just displaying the results.

If you are not looking to convert a ggplot to be interactive, plotly also provides its own framework for making charts from scratch, you can find out more about it here:

<iframe src="https://plotly.com/r/" width="672" height="400px"></iframe>

[***https://plotly.com/r/***](https://plotly.com/r/){.uri}

<!-- NOT WORKING ANYMORE ON 10/21/2020: -->

### ggpubr

The [**ggpubr**]{style="color: #ae7b11;"} [@R-ggpubr] extension provides a lot of functionality that we won't cover here, but one function we can use from this extension is [**stat_cor**]{style="color: green;"}, which allows us to add a correlation coefficient (R) and p-value to the chart.


```r
crypto_chart <- crypto_chart + stat_cor()
# Show chart
crypto_chart
```

<img src="CryptoResearchPaper_files/figure-html/ggpubr-1.png" width="672" />

We will dive deeper into these metrics in [the section where we evaluate the performance of the models](#evaluate-model-performance).

### ggforce

The [**ggforce**]{style="color: #ae7b11;"} package [@R-ggforce] is a useful tool for annotating charts. We can annotate outliers for example:


```r
crypto_chart <- crypto_chart +
        geom_mark_ellipse(aes(filter = price_usd == max(price_usd),
                              label = date_time_utc,
                              description = paste0('Price spike to $', price_usd))) +
        # Now the same to circle the minimum price:
        geom_mark_ellipse(aes(filter = price_usd == min(price_usd),
                              label = date_time_utc,
                              description = paste0('Price drop to $', price_usd)))
```

When using the [**geom_mark_ellipse()**]{style="color: green;"} function we are passing the [**data**]{style="color: blue;"} argument, the [**label**]{style="color: blue;"} and the [**description**]{style="color: blue;"} through the [**aes()**]{style="color: green;"} function. We are marking two points, one for the minimum price during the time period, and one for the maximum price. For the first point we filter the data to only the point where the [**price_usd**]{style="color: blue;"} was equal to the **`max(price_usd)`** and add the labels accordingly. The same is done for the second point, but showing the lowest price point for the given date range.

Now view the new chart:


```r
crypto_chart
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-26-1.png" width="672" />

Notice that this chart is specifically annotated around these points, but we never specified the specific dates to circle, and we are always circling the maximum and minimum values regardless of the specific data. One of the points of this document is to show the idea that when it comes to data analysis, visualizations, and reporting, most people in the workplace approach these as one time tasks, but with the proper (open source/free) tools automation and reproducibility becomes a given, and any old analysis can be run again to get the exact same results, or could be performed on the most recent view of the data using the same exact methodology.

### gganimate

We can also extend the functionality of ggplot by using the [**gganimate**]{style="color: #ae7b11;"} [@R-gganimate] package, which allows us to create an animated GIF that iterates over groups in the data through the use of the [**transition_states()**]{style="color: green;"} function.


```r
animated_prices <- ggplot(data = mutate(cryptodata, groups=symbol),
                          aes(x = date_time_utc, y = price_usd)) +
                          geom_line() +
                          theme_economist() +
                          transition_states(groups) + 
                          ggtitle('Price Over Time',subtitle = '{closest_state}') +
                          stat_smooth() +
                          view_follow() # this adjusts the axis based on the group
# Show animation (slowed to 1 frame per second):
animate(animated_prices,fps=1)
```

![](CryptoResearchPaper_files/figure-html/first_gganimate-1.gif)<!-- -->

We recommend consulting this documentation for simple and straightforward examples on using [**gganimate**]{style="color: #ae7b11;"}: <https://gganimate.com/articles/gganimate.html>

### ggTimeSeries

The [**ggTimeSeries**]{style="color: #ae7b11;"} [@R-ggTimeSeries] package has functionality that is helpful in plotting time series data. We can create a calendar heatmap of the price over time using the [**ggplot_calendar_heatmap()**]{style="color: green;"} function:


```r
calendar_heatmap <- ggplot_calendar_heatmap(eth_data,'date_time_utc','price_usd') #or do target_percent_change here?
calendar_heatmap
```

<img src="CryptoResearchPaper_files/figure-html/ggtimeseries_heatmap-1.png" width="672" />

*DoW on the y-axis stands for **D**ay **o**f the **W**eek*

To read this chart in the correct date order start from the top left and work your way down and to the right once you reach the bottom of the column. The lighter the color the higher the price on the specific day.

### Rayshader

The previous chart is helpful, but a color scale like that can be a bit difficult to interpret. We could convert the previous chart into a 3d figure that is easier to visually interpret by using the amazing [**rayshader**]{style="color: #ae7b11;"} [@R-rayshader] package.

**This document runs automatically through GitHub Actions, which [does not have a graphical environment to run the code below](https://github.community/t/installation-of-xquartz-not-found/139804), which prevents it from refreshing the results with the latest data. We are showing old results for the [**rayshader**]{style="color: #ae7b11;"} section below. If you have gotten to this point, it is worth running the code below yourself on the latest data to see this amazing package in action!**


```r
# First remove the title from the legend to avoid visual issues
calendar_heatmap <- calendar_heatmap + theme(legend.title = element_blank())
# Add the date to the title to make it clear these refresh twice daily
calendar_heatmap <- calendar_heatmap + ggtitle(paste0('Through: ',substr(max(eth_data$date_time_utc),1,10)))
# Convert to 3d plot
plot_gg(calendar_heatmap, zoom = 0.60, phi = 35, theta = 45)
# Render snapshot
render_snapshot('rayshader_image.png')
# Close RGL (which opens on plot_gg() command in a separate window)
rgl.close()
```

![](rayshader_image.png)

This is the same two dimensional [calendar heatmap that was made earlier](#calendar-heatmap).

Because we can programmatically adjust the camera as shown above, that means that we can also create a snapshot, move the camera and take another one, and keep going until we have enough to make it look like a video! This is not difficult to do using the `render_movie()` function, which will take care of everything behind the scenes for the same plot as before:


```r
# This time let's remove the scale too since we aren't changing it:
calendar_heatmap <- calendar_heatmap + theme(legend.position = "none")
# Same 3d plot as before
plot_gg(calendar_heatmap, zoom = 0.60, phi = 35, theta = 45)
# Render movie
render_movie('rayshader_video.mp4')
# Close RGL
rgl.close()
```

*Click on the video below to play the output*

![](rayshader_video.mp4)

We also recommend checking out the [incredible work done by Tyler Morgan Wall on his website using [**rayshader**]{style="color: #ae7b11;"} and [**rayrender**]{style="color: #ae7b11;"}](https://www.tylermw.com/).

</br>

Awesome work! Move on to the [next section](#model-validation-plan) ➡️ to start focusing our attention on making predictive models.


<!--chapter:end:04-Visualization.Rmd-->

# Model Validation Plan

Before making predictive models, we need to be careful in considering the ways by which we will be able to define a predictive model as being "good" or "bad". We **do not** want to deploy a predictive model before having a good understanding of how we expect the model to perform once used in the real world. We will likely never get a 100% accurate representation of what the model will actually perform like in the real world without actually tracking those results over time, but there are ways for us to get a sense of whether something works or not ahead of time, as well as ensuring no blatant mistakes were made when training the models. 

## Testing Models

The simplest method of getting a sense of the efficacy of a predictive model is to take a majority of the data (usually around 80% of the observations) and assign it to be the [**train dataset**]{style="color: purple;"}, which the predictive models use to learn the statistical patterns in the data that can then be used to make predictions about the future. Using the rest of the data which has not yet been seen by the statistical models (referred to as the [**test dataset**]{style="color: purple;"}), we can assess if the statistical models work on the new data in the way that we would expect based on the results obtained on the train dataset. If the results are consistent between the two, this is a good sign. 

## Cross Validation

If we do this multiple times (a process referred to as [**cross validation**]{style="color: purple;"}) we have even more information at our disposal to understand how good the model is at predicting data it has not seen before. If the results on the test data are much worse than those obtained on the train data, this could be a sign of [[**overfitting**]{style="color: purple;"}](https://en.wikipedia.org/wiki/Overfitting) which means the model created overspecialized itself on the training data, and it is not very good at predicting new data because it learned the exact patterns of the training data instead of understanding the actual relationships between the different variables. **Always beware of results that are too good to be true. It is more likely a mistake was made somewhere in the process**. It is easy to make mistakes, which is why we need a good system to easily catch those mistakes. This is a longer discussion in its own right, but it is also important to consider how the data used to trained the model will be utilized in the context of making a new prediction; if a variable used to train the model is not available when making a new prediction, that is simply not going to work. 

In our context, it is also important to consider the date/time aspect of the data. For example, if we used data later into the future for the train dataset relative to the test data, could this give the model more information that would actually be available to it when it is time to make a new prediction? It absolutely could because the columns with the lagged prices represent prices from the past, which could be "giving away the solution" to the test data in a way that could not be leveraged when it is time to make new predictions. Therefore, when splitting the data into train/test datasets we will keep track of when the data was collected using [**time aware cross validation**]{style="color: purple;"}.

### Time Aware Cross Validation

Because of the issues just discussed above, we will need to make sure that the train data was always collected before the test data was. This is what we mean by "time aware".

We will then use "cross validation" in the sense that we will create **5 different train/test splits to assess the accuracy of the models**. From those 5, we will take the test split containing the most recent data, and consider this to be our [**holdout dataset**]{style="color: purple;"}. The holdout dataset represents the most recent version of the world that we can compare the performance of the models against, and will give us an additional way of assessing their accuracy.

This will leave us with:

- 5 train datasets to build predictive models from.

- 4 test datasets to assess the performance of the first 4 trained models against. Is the model able to predict price movements accurately and consistently when trained and tested on 4 independent subsets of the data?

- 1 holdout dataset to assess the performance of all 5 trained models. How accurate are the models at predicting the most recent subset of the data that we can assess?

**The explanation above is really important to understand!** The code and implementation of this step specifically not so much, however. Focus on understanding the idea conceptually as outlined above rather than understanding the code used below.

In the code below we are adding two new columns. First the [**split**]{style="color: blue;"}, which assigns each observation a number 1 through 5 of the cross validation split that the data belongs to based on when it was collected. Then the [**training**]{style="color: blue;"} column, which identifies each row as being part of the **train**, **test**, or **holdout** data of the given [**split**]{style="color: blue;"}.

We will not walk through the steps of the code below in detail outside of the comments left throughout the code because we would rather focus our attention on the conceptual understanding for this step as outlined above. There are many ways of doing time aware cross validation, but none worked particularly well for the way we wanted to outline the next sections, so we made our own and it's not important to understand how this is working, but it is also not that complex and uses the same tools used up to this point in this section. [See this section of the high-level tutorial for an approach that can be used on datasets outside of the one used in this tutorial](https://cryptocurrencyresearch.org/high-level/#/cross-validation-for-timeseries), and is compatible with the tools used in the predictive modeling section of both versions.


```r
# Remove rows with null date_time_utc to exclude missing data from next steps
cryptodata <- drop_na(cryptodata, date_time_utc)
# Counts by symbol
cryptodata <- mutate(group_by(cryptodata, symbol), tot_rows = n())
# Add row index by symbol
cryptodata <- mutate(arrange(cryptodata, date_time_utc), row_id = seq_along(date_time_utc))
# Calculate what rows belong in the first split
cryptodata <- cryptodata %>% mutate(split_rows_1 = as.integer(n()/5),
                                    split_rows_2 = as.integer(split_rows_1*2),
                                    split_rows_3 = as.integer(split_rows_1*3),
                                    split_rows_4 = as.integer(split_rows_1*4),
                                    split_rows_5 = as.integer(split_rows_1*5))
# Now calculate what split the current row_id belongs into
cryptodata <- mutate(cryptodata, 
                     split = case_when(
                       row_id <= split_rows_1 ~ 1,
                       row_id <= split_rows_2 ~ 2,
                       row_id <= split_rows_3 ~ 3,
                       row_id <= split_rows_4 ~ 4,
                       row_id > split_rows_4 ~ 5))
# Now figure out train/test groups
cryptodata <- cryptodata %>% mutate(train_rows_1 = (as.integer(n()/5))*0.8,
                                    test_rows_1  = train_rows_1 + (as.integer(n()/5))*0.2,
                                    train_rows_2 = test_rows_1 + train_rows_1,
                                    test_rows_2  = train_rows_2 + (as.integer(n()/5))*0.2,
                                    train_rows_3 = test_rows_2 + train_rows_1,
                                    test_rows_3  = train_rows_3 + (as.integer(n()/5))*0.2,
                                    train_rows_4 = test_rows_3 + train_rows_1,
                                    test_rows_4  = train_rows_4 + (as.integer(n()/5))*0.2,
                                    train_rows_5 = test_rows_4 + train_rows_1,
                                    test_rows_5  = train_rows_5 + (as.integer(n()/5))*0.2)
# Now assign train/test groups
cryptodata <- mutate(cryptodata, 
                     training = case_when(
                       row_id <= train_rows_1 ~ 'train',
                       row_id <= test_rows_1 ~ 'test',
                       row_id <= train_rows_2 ~ 'train',
                       row_id <= test_rows_2 ~ 'test',
                       row_id <= train_rows_3 ~ 'train',
                       row_id <= test_rows_3 ~ 'test',
                       row_id <= train_rows_4 ~ 'train',
                       row_id <= test_rows_4 ~ 'test',
                       row_id <= train_rows_5 ~ 'train',
                       row_id > train_rows_5 ~ 'holdout'))
# Remove all columns that are no longer needed now
cryptodata <- select(cryptodata, -(tot_rows:test_rows_5), -(trade_usd_1:trade_usd_5),
                     -(ask_1_price:bid_5_quantity), -pair, -quote_currency, 
                     -pkDummy, -pkey, -ts_index, split)
```

Our data now has the new columns `training` (*train*, *test* or *holdout*) and `split` (numbers 1-5) added to it, let's take a look at the new columns:


```r
select(cryptodata, training, split)
```

```
## # A tibble: 180,360 x 3
## # Groups:   symbol [81]
##    symbol training split
##    <chr>  <chr>    <dbl>
##  1 BTC    train        1
##  2 LTC    train        1
##  3 XMR    train        1
##  4 ETH    train        1
##  5 IPL    train        1
##  6 ZEC    train        1
##  7 XEM    train        1
##  8 NEXO   train        1
##  9 APPC   train        1
## 10 EOS    train        1
## # … with 180,350 more rows
```

*Notice that even though we left `symbol` variables out of our selection, but because it is part of the way we grouped our data, it was added back in with the message "Adding missing grouping variables `symbol`". The data is tied to its groupings when performing all operations until we use [**ungroup()**]{style="color: green;"} to undo them.*

Let's add the new [**split**]{style="color: blue;"} column to the way the data is grouped:


```r
cryptodata <- group_by(cryptodata, symbol, split)
```

The new field [**split**]{style="color: blue;"}, helps us split the data into 5 different datasets based on the date, and contains a number from 1-5. The new field [**training**]{style="color: blue;"} flags the data as being part of the ***train*** dataset, or the ***test***, or the ***holdout*** (for the first split) dataset for each of the 5 splits/datasets.

Running the same code as before with [**tail()**]{style="color: green;"} added, we can see rows associated with the test data of the 5th split (again remember, each of the 5 splits has a training and testing dataset):


```r
tail( select(cryptodata, training, split) )
```

```
## # A tibble: 6 x 3
## # Groups:   symbol, split [6]
##   symbol training split
##   <chr>  <chr>    <dbl>
## 1 XVG    holdout      5
## 2 AMB    holdout      5
## 3 ASP    holdout      5
## 4 REX    holdout      5
## 5 PHX    holdout      5
## 6 FTM    holdout      5
```

The easiest way to understand these groupings, is to visualize them:


```r
groups_chart <- ggplot(cryptodata,
                       aes(x = date_time_utc, y = split, color = training)) +
                       geom_point()
# now show the chart we just saved:
groups_chart
```

<img src="CryptoResearchPaper_files/figure-html/cv_groupings_visualized-1.png" width="672" />

The chart above looks strange because it includes all cryptocurrencies when they are treated independently. We can view the results for the **BTC** cryptocurrency only by running the same code as above, but instead of visualizing the dataset in its entirety, filtering the data using **`filter(cryptodata, symbol == "BTC")`**, which will give us a much better impression of the breakdown that has been created:


```r
ggplot(filter(cryptodata, symbol == 'BTC'), 
       aes(x = date_time_utc,
           y = split, 
           color = training)) +
  geom_point()
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-28-1.png" width="672" />

We can check on the groupings for each cryptocurrency by animating the [**cryptodata**]{style="color: blue;"} object:


```r
animated_chart <- groups_chart +
    transition_states(symbol) +
    ggtitle('Now showing: {closest_state}')
# show the new animated chart
animate(animated_chart, fps = 2)
```

![](CryptoResearchPaper_files/figure-html/animate_groupings-1.gif)<!-- -->

<!-- The fps needs to be 1, 2, or any number divisible by 2 or the code won't work -->

It can be a bit hard to tell how many data points there are because they end up looking like lines. Let's change the plot to use `geom_jitter()` instead of `geom_point()`, which will manually offset the points and give us a better impression of how many data points there are:


```r
animated_chart <- animated_chart +
                    geom_jitter()
# show the new animated chart
animate(animated_chart, fps = 2)
```

![](CryptoResearchPaper_files/figure-html/gganimate_jitter-1.gif)<!-- -->

## Fix Data by Split

Now that we have split the data into many different subsets, those subsets themselves may have issues that prevent the predictive models from working as expected.

### Zero Variance

One of the first models we will make [in the next section is a simple [**linear regression**]{style="color: purple;"} model](#example-simple-model). The regular R function for this **will not work** if the data contains any columns that have [***zero variance***]{style="color: purple;"}, meaning the value of the column never changes throughout the data being given to the model. Therefore, let's fix any issues relating to zero variance columns in any dataset before we change the structure of the data in the step after this one.

First let's change the grouping of the data. We are interested in calculating the zero variance based on the [**symbol**]{style="color: blue;"}, [**split**]{style="color: blue;"}, and [**training**]{style="color: blue;"} fields:

```r
cryptodata <- group_by(cryptodata, symbol, split, training)
```


Now let's create a new object called [**find_zero_var**]{style="color: blue;"} which shows the value of the minimum standard deviation across all columns and calculated based on the grouping of symbol, split and train:

```r
find_zero_var <- select(mutate(cryptodata, min_sd = min(sd(price_usd, na.rm=T), 
                                                        sd(target_price_24h, na.rm=T),
                                                        sd(lagged_price_1h, na.rm=T), 
                                                        sd(lagged_price_2h, na.rm=T),
                                                        sd(lagged_price_3h, na.rm=T), 
                                                        sd(lagged_price_6h, na.rm=T),
                                                        sd(lagged_price_12h, na.rm=T), 
                                                        sd(lagged_price_24h, na.rm=T))), min_sd)
# Show data
find_zero_var
```

```
## # A tibble: 180,360 x 4
## # Groups:   symbol, split, training [810]
##    symbol split training      min_sd
##    <chr>  <dbl> <chr>          <dbl>
##  1 BTC        1 train    143.       
##  2 LTC        1 train      0.979    
##  3 XMR        1 train      6.94     
##  4 ETH        1 train      9.84     
##  5 IPL        1 train      0.000174 
##  6 ZEC        1 train      4.83     
##  7 XEM        1 train      0.00561  
##  8 NEXO       1 train      0.00711  
##  9 APPC       1 train      0.0000476
## 10 EOS        1 train      0.0559   
## # … with 180,350 more rows
```

Next let's get to a list of cryptocurrency symbols where the minimum standard deviation across all columns for all splits of the data is 0, which is the list of cryptocurrencies we want to later remove from the data:

```r
minimum_sd <- filter(distinct(mutate(group_by(ungroup(find_zero_var), symbol),
                                     min_sd = min(min_sd, na.rm=T)), min_sd),min_sd < 0.0001)$symbol
# Show result
minimum_sd
```

```
##  [1] "IPL"   "APPC"  "REX"   "GST"   "CND"   "RCN"   "XVG"   "BYTZ"  "SUB"  
## [10] "BTT"   "SMART" "PHX"   "CUTE"  "PLA"   "MBL"   "IQ"    "BNK"   "NAV"  
## [19] "ACT"   "COCOS" "DENT"  "BRDG"  "FDZ"   "NCT"   "MESH"  "CKB"   "VSYS" 
## [28] "SYBC"
```

Now we can remove these symbols from appearing in the dataset:


```r
cryptodata <- filter(cryptodata, !(symbol %in% minimum_sd)) 
```

In the code above we match all rows where the symbol is part of the [**minimum_sd**]{style="color: blue;"} object with the list of cryptocurrency symbols to remove from the data, and we then negate the selection using the [**!**]{style="color: blue;"} operator to only keep rows with symbols not in the list we found.


## Nest data {#nest-data}

The underlying data structure we have been using up to this point is that of a [**data frame**]{style="color: purple;"}. This data type supports values of many kinds inside of its cells, so far we have seen things like numbers, strings, and dates, but we can also store an entire other data frame as a value. Doing this is called [**nesting**]{style="color: purple;"} the data.

The steps taken below and in the [predictive modeling section that comes later](#predictive-modeling) use a similar approach to [the work published by Hadley Wickham on the subject](https://r4ds.had.co.nz/many-models.html) [@R_for_data_science].

<!-- 11/10 REMOVED. CONFIRM NOT NEEDED BECAUSE ALREADY DID IN PREVIOUS STEP -->
<!-- ... First update the way the data is grouped: -->

<!-- ```{r group_for_nest} -->
<!-- cryptodata <- group_by(cryptodata, symbol, split, training) -->
<!-- ``` -->

Here is an example of what happens when we [**nest()**]{style="color: green;"} the data:


```r
nest(cryptodata) 
```

```
## # A tibble: 530 x 4
## # Groups:   symbol, training, split [530]
##    symbol training split data               
##    <chr>  <chr>    <dbl> <list>             
##  1 BTC    train        1 <tibble [410 × 11]>
##  2 LTC    train        1 <tibble [409 × 11]>
##  3 XMR    train        1 <tibble [408 × 11]>
##  4 ETH    train        1 <tibble [386 × 11]>
##  5 ZEC    train        1 <tibble [336 × 11]>
##  6 XEM    train        1 <tibble [392 × 11]>
##  7 NEXO   train        1 <tibble [409 × 11]>
##  8 EOS    train        1 <tibble [403 × 11]>
##  9 ELF    train        1 <tibble [384 × 11]>
## 10 BNT    train        1 <tibble [387 × 11]>
## # … with 520 more rows
```

We will begin by creating the new column containing the nested [**train**]{style="color: blue;"} data. Some additional steps were added to ensure the integrity of the data before we start training it, but these are not material outside of the things we have already discussed up to this point. Try to focus on the conceptual idea that we are creating a new dataset grouped by the [**symbol**]{style="color: blue;"}, [**training**]{style="color: blue;"} and [**split**]{style="color: blue;"} columns. As a first step, we are creating a new dataframe called [**cryptodata_train**]{style="color: blue;"} grouped by the [**symbol**]{style="color: blue;"} and [**split**]{style="color: blue;"} columns with the nested dataframes in the new [**train_data**]{style="color: blue;"} column:


```r
cryptodata_train <- rename(nest(filter(cryptodata, 
                                       training=='train')), 
                           train_data = 'data')
# Now remove training column
cryptodata_train <- select(ungroup(cryptodata_train, 
                                   training), 
                           -training)
# Fix issues with individual groups of the data
cryptodata_train$train_data <- lapply(cryptodata_train$train_data, na.omit)
# First add new column with nrow of train dataset
cryptodata_train <- group_by(ungroup(mutate(rowwise(cryptodata_train), 
                                            train_rows = nrow(train_data))),
                             symbol, split)
# Remove all symbols where their train data has less than 20 rows at least once
symbols_rm <- unique(filter(cryptodata_train, 
                            split < 5, train_rows < 20)$symbol)
# Remove all data relating to the symbols found above
cryptodata_train <- filter(cryptodata_train, 
                           ! symbol %in% symbols_rm) # ! is to make %not in% operator
# Drop train_rows column
cryptodata_train <- select(cryptodata_train, -train_rows)
# Show results
cryptodata_train
```

```{.scroll-lim}
## # A tibble: 255 x 3
## # Groups:   symbol, split [255]
##    symbol split train_data         
##    <chr>  <dbl> <list>             
##  1 BTC        1 <tibble [338 × 11]>
##  2 LTC        1 <tibble [337 × 11]>
##  3 XMR        1 <tibble [336 × 11]>
##  4 ETH        1 <tibble [80 × 11]> 
##  5 ZEC        1 <tibble [162 × 11]>
##  6 XEM        1 <tibble [69 × 11]> 
##  7 NEXO       1 <tibble [322 × 11]>
##  8 EOS        1 <tibble [331 × 11]>
##  9 ELF        1 <tibble [87 × 11]> 
## 10 BNT        1 <tibble [97 × 11]> 
## # … with 245 more rows
```

Now let's repeat the same process but on the [**test**]{style="color: blue;"} data to create the [**cryptodata_test**]{style="color: blue;"} object:


```r
cryptodata_test <- select(rename(nest(filter(cryptodata, 
                                             training=='test')), 
                                 test_data = 'data'), 
                          -training)
# Now remove training column
cryptodata_test <- select(ungroup(cryptodata_test, 
                                  training), 
                          -training)
# Show nested data
cryptodata_test
```

```
## # A tibble: 212 x 3
## # Groups:   symbol, split [212]
##    symbol split test_data          
##    <chr>  <dbl> <list>             
##  1 NUT        1 <tibble [68 × 11]> 
##  2 XRP        1 <tibble [52 × 11]> 
##  3 VIB        1 <tibble [73 × 11]> 
##  4 QTUM       1 <tibble [49 × 11]> 
##  5 SRN        1 <tibble [95 × 11]> 
##  6 AAB        1 <tibble [72 × 11]> 
##  7 TRX        1 <tibble [101 × 11]>
##  8 EOS        1 <tibble [101 × 11]>
##  9 OAX        1 <tibble [102 × 11]>
## 10 MANA       1 <tibble [101 × 11]>
## # … with 202 more rows
```

As well as the [**holdout**]{style="color: blue;"} data to create the [**cryptodata_holdout**]{style="color: blue;"} object:


```r
cryptodata_holdout <- rename(nest(filter(cryptodata, 
                                         training=='holdout')), 
                             holdout_data = 'data')
# Remove split and training columns from holdout
cryptodata_holdout <- select(ungroup(cryptodata_holdout, split, training), 
                             -split, -training)
# Show nested data
cryptodata_holdout
```

```
## # A tibble: 53 x 2
## # Groups:   symbol [53]
##    symbol holdout_data       
##    <chr>  <list>             
##  1 VIB    <tibble [76 × 11]> 
##  2 SEELE  <tibble [95 × 11]> 
##  3 ZRX    <tibble [106 × 11]>
##  4 LTC    <tibble [107 × 11]>
##  5 BAT    <tibble [105 × 11]>
##  6 BSV    <tibble [106 × 11]>
##  7 TRX    <tibble [102 × 11]>
##  8 XMR    <tibble [105 × 11]>
##  9 DGB    <tibble [103 × 11]>
## 10 BTC    <tibble [105 × 11]>
## # … with 43 more rows
```

### Join Results

Now we can take the results that we grouped for each subset [**cryptodata_train**]{style="color: blue;"}, [**cryptodata_test**]{style="color: blue;"}, and [**cryptodata_holdout**]{style="color: blue;"}, and we can [**join**]{style="color: purple;"} the results to have all three new columns [**train_data**]{style="color: blue;"}, [**test_data**]{style="color: blue;"}, and [**holdout_data**]{style="color: blue;"} in a single new dataframe, which we will call [**cryptodata_nested**]{style="color: blue;"}:


```r
# Join train and test
cryptodata_nested <- left_join(cryptodata_train, cryptodata_test, by = c("symbol", "split"))
# Show new data
cryptodata_nested
```

```
## # A tibble: 255 x 4
## # Groups:   symbol, split [255]
##    symbol split train_data          test_data          
##    <chr>  <dbl> <list>              <list>             
##  1 BTC        1 <tibble [338 × 11]> <tibble [103 × 11]>
##  2 LTC        1 <tibble [337 × 11]> <tibble [103 × 11]>
##  3 XMR        1 <tibble [336 × 11]> <tibble [102 × 11]>
##  4 ETH        1 <tibble [80 × 11]>  <tibble [97 × 11]> 
##  5 ZEC        1 <tibble [162 × 11]> <tibble [85 × 11]> 
##  6 XEM        1 <tibble [69 × 11]>  <tibble [99 × 11]> 
##  7 NEXO       1 <tibble [322 × 11]> <tibble [103 × 11]>
##  8 EOS        1 <tibble [331 × 11]> <tibble [101 × 11]>
##  9 ELF        1 <tibble [87 × 11]>  <tibble [96 × 11]> 
## 10 BNT        1 <tibble [97 × 11]>  <tibble [97 × 11]> 
## # … with 245 more rows
```
*The [**by**]{style="color: blue;"} argument used above defines the key to use to join the data by, in this case the cryptocurrency [**symbol**]{style="color: blue;"}, as well as the specific [**split**]{style="color: blue;"}*.

Next, let's join the new dataframe we just created [**cryptodata_nested**]{style="color: blue;"} to the holdout data as well and add the [**holdout_data**]{style="color: blue;"} column. In this case, we will want to keep the holdout data consistent for all 5 splits of a cryptocurrency instead of matching the data to a particular split; the models trained on the data from splits 1 through 5 will each have a different test dataset, but all 5 models will then be tested against the same holdout. Therefore, this time in the [**join()**]{style="color: green;"} performed below we are only supplying the cryptocurrency [**symbol**]{style="color: blue;"} for the [**by**]{style="color: blue;"} parameter:


```r
cryptodata_nested <- left_join(cryptodata_nested, cryptodata_holdout, by = "symbol")
```

Now we have our completed dataset that will allow us to iterate through each option and create many separate models as was [discussed throughout this section](#cross-validation): 


```r
cryptodata_nested
```

```
## # A tibble: 255 x 5
## # Groups:   symbol, split [255]
##    symbol split train_data          test_data           holdout_data       
##    <chr>  <dbl> <list>              <list>              <list>             
##  1 BTC        1 <tibble [338 × 11]> <tibble [103 × 11]> <tibble [105 × 11]>
##  2 LTC        1 <tibble [337 × 11]> <tibble [103 × 11]> <tibble [107 × 11]>
##  3 XMR        1 <tibble [336 × 11]> <tibble [102 × 11]> <tibble [105 × 11]>
##  4 ETH        1 <tibble [80 × 11]>  <tibble [97 × 11]>  <tibble [99 × 11]> 
##  5 ZEC        1 <tibble [162 × 11]> <tibble [85 × 11]>  <tibble [85 × 11]> 
##  6 XEM        1 <tibble [69 × 11]>  <tibble [99 × 11]>  <tibble [103 × 11]>
##  7 NEXO       1 <tibble [322 × 11]> <tibble [103 × 11]> <tibble [105 × 11]>
##  8 EOS        1 <tibble [331 × 11]> <tibble [101 × 11]> <tibble [101 × 11]>
##  9 ELF        1 <tibble [87 × 11]>  <tibble [96 × 11]>  <tibble [100 × 11]>
## 10 BNT        1 <tibble [97 × 11]>  <tibble [97 × 11]>  <tibble [101 × 11]>
## # … with 245 more rows
```

Move on to the [next section](#predictive-modeling) ➡️ to build the predictive models using the methodology discussed in this section.



<!--chapter:end:05-ModelValidationPlan.Rmd-->

# Predictive Modeling {#predictive-modeling}

We finally have everything we need to start making predictive models now that the [data has been cleaned](#data-prep) and we have come up with a [gameplan to understand the efficacy of the models](#model-validation-plan).

## Example Simple Model {#example-simple-model}

We can start by making a simple [**linear regression** model](https://en.wikipedia.org/wiki/Linear_regression):


```r
lm(formula = target_price_24h ~ ., data = cryptodata)
```

```{.scroll-lim}
## 
## Call:
## lm(formula = target_price_24h ~ ., data = cryptodata)
## 
## Coefficients:
##      (Intercept)         symbolADA         symbolAMB        symbolARDR  
##   2320.355173314       1.254764448       3.355496607       1.246642426  
##        symbolASP         symbolAVA         symbolBAT         symbolBNT  
##      2.716080375       1.269661064       0.977950043       1.189554803  
##        symbolBRD         symbolBSV         symbolBTC         symbolBTG  
##      1.334885321      -5.114219644    -335.567323472       0.895211329  
##        symbolBTM         symbolCCE         symbolCHZ         symbolCRO  
##      1.330329809       3.417600019       1.263689833       1.222552278  
##       symbolCRPT         symbolCRV         symbolCUR         symbolDCR  
##      1.277513308       2.294235561       1.111783327       0.668719630  
##        symbolDGB         symbolELF         symbolENJ         symbolEOS  
##      1.013071854       1.237375890       1.024002319       0.960258028  
##        symbolETH         symbolETP         symbolFTM          symbolHT  
##     -7.713120479       0.938630096       4.114604179       0.921152043  
##        symbolJST         symbolKMD         symbolKNC         symbolLEO  
##      1.252707248       1.239076399       1.222975639       1.475416710  
##       symbolLEVL         symbolLTC        symbolMANA        symbolNEXO  
##      2.966722148      -0.352006788       1.023534741       0.983499644  
##        symbolNUT         symbolOAX        symbolQTUM       symbolSEELE  
##      0.137686361       1.037321068       2.994397397       1.385063604  
##        symbolSRN       symbolSTORJ       symbolSUSHI         symbolTRX  
##      0.957820869       1.534300495       2.837570883       1.107696350  
##        symbolUNI         symbolVIB        symbolWAXP         symbolXEM  
##      3.541160266       1.181641644       1.247067793       1.140269438  
##        symbolXMR         symbolXNS         symbolXRP         symbolZEC  
##     -3.081122479       1.233471346       2.095975484      -0.404825513  
##        symbolZRX     date_time_utc              date         price_usd  
##      0.986852211      -0.000004095       0.228985426       1.083754425  
##  lagged_price_1h   lagged_price_2h   lagged_price_3h   lagged_price_6h  
##      0.015374394      -0.001389650       0.014556673      -0.106066153  
## lagged_price_12h  lagged_price_24h   lagged_price_3d      trainingtest  
##     -0.276995925       0.198641449       0.109097736      -9.142244931  
##    trainingtrain             split  
##    -10.949795145       2.558179831
```

We defined the [**formula**]{style="color: blue;"} for the model as **`target_price_24h ~ .`**, which means that we are want to make predictions for the [**target_price_24h**]{style="color: blue;"} field, and use (**`~`**) every other column found in the data (**`.`**). In other words, we specified a model that uses the [**target_price_24h**]{style="color: blue;"} field as the [dependent variable](https://en.wikipedia.org/wiki/Dependent_and_independent_variables), and all other columns (**`.`**) as the [independent variables](https://en.wikipedia.org/wiki/Dependent_and_independent_variables). Meaning, we are looking to predict the [**target_price_24h**]{style="color: blue;"}, which is the only column that refers to the future, and use all the information available at the time the rest of the data was collected in order to infer statistical relationships that can help us forecast the future values of the [**target_price_24h**]{style="color: blue;"} field when it is still unknown on new data that we want to make new predictions for.

In the example above we used the [**cryptodata**]{style="color: blue;"} object which contained all the non-nested data, and was a big oversimplification of the process we will actually use. 

### Using Functional Programming {#using-functional-programming}

<!-- There are several approaches we could take in order to create the models [according to the plan outlined in the previous section](#model-validation-plan). As previously mentioned, the steps taken below use a similar approach to [the work published by Hadley Wickham on the subject](https://r4ds.had.co.nz/many-models.html) [@R_for_data_science]. Because this work is particularly well respected, we went with a methodology that uses [**functional programming**]{style="color: purple;"}. There are pros and cons to using different methods (i.e. a ***for loop***), and this tutorial itself was originally written using three different fundamentally different approaches before settling on a **functional programming** approach, which is a programming paradigm that focuses on the actions being taken, rather than focusing on  -->

From this point forward, we will deal with the new dataset [**cryptodata_nested**]{style="color: blue;"}, review the [previous section where it was created](#nest-data) if you missed it. Here is a preview of the data again:

```r
cryptodata_nested
```

```
## # A tibble: 255 x 5
## # Groups:   symbol, split [255]
##    symbol split train_data          test_data           holdout_data       
##    <chr>  <dbl> <list>              <list>              <list>             
##  1 BTC        1 <tibble [338 × 11]> <tibble [103 × 11]> <tibble [105 × 11]>
##  2 LTC        1 <tibble [337 × 11]> <tibble [103 × 11]> <tibble [107 × 11]>
##  3 XMR        1 <tibble [336 × 11]> <tibble [102 × 11]> <tibble [105 × 11]>
##  4 ETH        1 <tibble [80 × 11]>  <tibble [97 × 11]>  <tibble [99 × 11]> 
##  5 ZEC        1 <tibble [162 × 11]> <tibble [85 × 11]>  <tibble [85 × 11]> 
##  6 XEM        1 <tibble [69 × 11]>  <tibble [99 × 11]>  <tibble [103 × 11]>
##  7 NEXO       1 <tibble [322 × 11]> <tibble [103 × 11]> <tibble [105 × 11]>
##  8 EOS        1 <tibble [331 × 11]> <tibble [101 × 11]> <tibble [101 × 11]>
##  9 ELF        1 <tibble [87 × 11]>  <tibble [96 × 11]>  <tibble [100 × 11]>
## 10 BNT        1 <tibble [97 × 11]>  <tibble [97 × 11]>  <tibble [101 × 11]>
## # … with 245 more rows
```

Because we are now dealing with a **nested dataframe**, performing operations on the individual nested datasets is not as straightforward. We could extract the individual elements out of the data using [[**indexing**]{style="color: purple;"}](https://rspatial.org/intr/4-indexing.html), for example we can return the first element of the column [**train_data**]{style="color: blue;"} by running this code:

```r
cryptodata_nested$train_data[[1]]
```

```
## # A tibble: 338 x 11
##    date_time_utc       date       price_usd target_price_24h lagged_price_1h
##    <dttm>              <date>         <dbl>            <dbl>           <dbl>
##  1 2020-09-24 00:00:06 2020-09-24    10242.           10732.          10271.
##  2 2020-09-24 01:00:06 2020-09-24    10295.           10704.          10242.
##  3 2020-09-24 02:00:06 2020-09-24    10290.           10687.          10295.
##  4 2020-09-24 03:00:07 2020-09-24    10296.           10712.          10290.
##  5 2020-09-24 04:00:06 2020-09-24    10307.           10670.          10296.
##  6 2020-09-24 05:00:07 2020-09-24    10284.           10671.          10307.
##  7 2020-09-24 06:00:07 2020-09-24    10288.           10645.          10284.
##  8 2020-09-24 07:00:06 2020-09-24    10291.           10691.          10288.
##  9 2020-09-24 08:00:06 2020-09-24    10343.           10689.          10291.
## 10 2020-09-24 09:00:06 2020-09-24    10315.           10590.          10343.
## # … with 328 more rows, and 6 more variables: lagged_price_2h <dbl>,
## #   lagged_price_3h <dbl>, lagged_price_6h <dbl>, lagged_price_12h <dbl>,
## #   lagged_price_24h <dbl>, lagged_price_3d <dbl>
```

As we already saw dataframes are really flexible as a data structure. We can create a new column in the data to store the models themselves that are associated with each row of the data. There are several ways that we could go about doing this (this tutorial itself was written to execute the same commands using three fundamentally different methodologies), but in this tutorial we will take a [**functional programming**]{style="color: purple;"} approach. This means we will focus the operations we will perform on the actions we want to take themselves, which can be contrasted to a [**for loop**]{style="color: purple;"} which emphasizes the objects more using a similar structure that we used in the example above showing the first element of the [**train_data**]{style="color: blue;"} column.

When using a **functional programming** approach, we first need to create functions for the operations we want to perform. Let's wrap the [**lm()**]{style="color: green;"} function [we used as an example earlier](#example-simple-model) and create a new custom function called [**linear_model**]{style="color: blue;"}, which takes a dataframe as an input (the [**train_data**]{style="color: blue;"} we will provide for each row of the nested dataset), and generates a linear regression model:


```r
linear_model <- function(df){
  lm(target_price_24h ~ . -date_time_utc -date, data = df)
}
```

We can now use the [**map()**]{style="color: green;"} function from the [[**purrr**]{style="color: #ae7b11;"} package](#https://purrr.tidyverse.org/) in conjunction with the [**mutate()**]{style="color: green;"} function from [**dplyr**]{style="color: #ae7b11;"} to create a new column in the data which contains an individual linear regression model for each row of [**train_data**]{style="color: blue;"}:


```r
mutate(cryptodata_nested, lm_model = map(train_data, linear_model))
```

```
## # A tibble: 255 x 6
## # Groups:   symbol, split [255]
##    symbol split train_data         test_data          holdout_data      lm_model
##    <chr>  <dbl> <list>             <list>             <list>            <list>  
##  1 BTC        1 <tibble [338 × 11… <tibble [103 × 11… <tibble [105 × 1… <lm>    
##  2 LTC        1 <tibble [337 × 11… <tibble [103 × 11… <tibble [107 × 1… <lm>    
##  3 XMR        1 <tibble [336 × 11… <tibble [102 × 11… <tibble [105 × 1… <lm>    
##  4 ETH        1 <tibble [80 × 11]> <tibble [97 × 11]> <tibble [99 × 11… <lm>    
##  5 ZEC        1 <tibble [162 × 11… <tibble [85 × 11]> <tibble [85 × 11… <lm>    
##  6 XEM        1 <tibble [69 × 11]> <tibble [99 × 11]> <tibble [103 × 1… <lm>    
##  7 NEXO       1 <tibble [322 × 11… <tibble [103 × 11… <tibble [105 × 1… <lm>    
##  8 EOS        1 <tibble [331 × 11… <tibble [101 × 11… <tibble [101 × 1… <lm>    
##  9 ELF        1 <tibble [87 × 11]> <tibble [96 × 11]> <tibble [100 × 1… <lm>    
## 10 BNT        1 <tibble [97 × 11]> <tibble [97 × 11]> <tibble [101 × 1… <lm>    
## # … with 245 more rows
```

Awesome! Now we can use the [same tools we learned in the high-level version to make a wider variety of predictive models to test](https://cryptocurrencyresearch.org/high-level/#/caret-package)

## Caret

Refer back to the [high-level version of the tutorial](https://cryptocurrencyresearch.org/high-level/#/caret-package) for an explanation of the caret package, or consult this document: https://topepo.github.io/caret/index.html

### Parallel Processing

R is a ***single thredded*** application, meaning it only uses one CPU at a time when performing operations. The step below is optional and uses the [**parallel**]{style="color: #ae7b11;"} and [**doParallel**]{style="color: #ae7b11;"} packages to allow R to use more than a single CPU when creating the predictive models, which will speed up the process considerably:


```r
cl <- makePSOCKcluster(detectCores()-1)
registerDoParallel(cl)
```

### More Functional Programming {#more-functional-programming}

Now we can repeat the process we [used earlier to create a column with the linear regression models](#using-functional-programming) to create **the exact same models**, but this time using the [**caret**]{style="color: #ae7b11;"} package.


```r
linear_model_caret <- function(df){
  
  train(target_price_24h ~ . -date_time_utc -date, data = df,
        method = 'lm',
        trControl=trainControl(method="none"))
  
}
```
*We specified the method as **`lm`** for linear regression. See the high-level version for a refresher on how to use different [**methods**]{style="color: blue;"} to make different models: https://cryptocurrencyresearch.org/high-level/#/method-options. the [**trControl**]{style="color: blue;"} argument tells the [**caret**]{style="color: #ae7b11;"} package to avoid additional resampling of the data. As a default behavior [**caret**]{style="color: #ae7b11;"} will do re-sampling on the data and do [**hyperparameter tuning**]{style="color: purple;"} to select values to use for the paramters to get the best results, but we will avoid this discussion for this tutorial. See the [official [**caret**]{style="color: #ae7b11;"} documentation for more details](https://topepo.github.io/caret/random-hyperparameter-search.html).*

Here is the full list of models that we can make using the [**caret**]{style="color: #ae7b11;"} package and the [steps described the high-level version of the tutorial](https://cryptocurrencyresearch.org/high-level/#/method-options):
<iframe src="https://topepo.github.io/caret/available-models.html" width="672" height="400px"></iframe>

We can now use the new function we created [**linear_model_caret**]{style="color: blue;"} in conjunction with [**map()**]{style="color: green;"} and [**mutate()**]{style="color: green;"} to create a new column in the [**cryptodata_nested**]{style="color: green;"} dataset called [**lm_model**]{style="color: blue;"} with the trained linear regression model for each split of the data (by cryptocurrency [**symbol**]{style="color: blue;"} and [**split**]{style="color: blue;"}):


```r
cryptodata_nested <- mutate(cryptodata_nested, 
                            lm_model = map(train_data, linear_model_caret))
```

We can see the new column called [**lm_model**]{style="color: blue;"} with the nested dataframe grouping variables:

```r
select(cryptodata_nested, lm_model)
```

```
## # A tibble: 255 x 3
## # Groups:   symbol, split [255]
##    symbol split lm_model
##    <chr>  <dbl> <list>  
##  1 BTC        1 <train> 
##  2 LTC        1 <train> 
##  3 XMR        1 <train> 
##  4 ETH        1 <train> 
##  5 ZEC        1 <train> 
##  6 XEM        1 <train> 
##  7 NEXO       1 <train> 
##  8 EOS        1 <train> 
##  9 ELF        1 <train> 
## 10 BNT        1 <train> 
## # … with 245 more rows
```

And we can view the summarized contents of the first trained model:

```r
cryptodata_nested$lm_model[[1]]
```

```
## Linear Regression 
## 
## 338 samples
##  10 predictor
## 
## No pre-processing
## Resampling: None
```


<!-- ### Cross Validation {#cross-validation-preds} -->

<!-- In the previous output, we saw the output said: ***Resampling: None*** because when building the function we specified we did not want any resampling for the [**trControl**]{style="color: blue;"} argument of the [**train()**]{style="color: green;"} function. Within each split of the data however, we can create three separate additional cross validation splits, which will allow the [**caret**]{style="color: #ae7b11;"} package to do some minimal [**hyperparameter**]{style="color: blue;"} tuning, which is the process by which it will test different options for the parameters (which vary based on the specific model being used) to find the most optimal combination of them. -->

<!-- Within each split we created, we can set caret to perform an additional cross-validation step to allow it to do a minimal level of automated hyperparameter tuning as it creates the models (the more we do the longer it will take). -->

<!-- ```{r} -->
<!-- fitControl <- trainControl(method = "repeatedcv", -->
<!--                            number = 3, -->
<!--                            repeats = 3) -->
<!-- ``` -->

### Generalize the Function

We can adapt the [function we built earlier for the linear regression models using caret](#more-functional-programming), and add a parameter that allows us to specify the [**method**]{style="color: blue;"} we want to use (as in what predictive model):


```r
model_caret <- function(df, method_choice){
  
  train(target_price_24h ~ . -date_time_utc -date, data = df,
        method = method_choice,
        trControl=trainControl(method="none"))

}
```

### XGBoost Models

Now we can do the same thing we did [earlier for the linear regression models](#more-functional-programming), but use the new function called [**model_caret**]{style="color: blue;"} using the [**map2()**]{style="color: green;"} function to also specify the model as [**xgbLinear**]{style="color: blue;"} to create an [**XGBoost**]{style="color: purple;"} model:


```r
cryptodata_nested <- mutate(cryptodata_nested, 
                            xgb_model = map2(train_data, "xgbLinear", model_caret))
```

We won't dive into the specifics of each individual model as the correct one to use may depend on a lot of factors and that is a discussion outside the scope of this tutorial. We chose to use the [**XGBoost**](https://xgboost.readthedocs.io/en/latest/parameter.html) model as an example because it has recently [gained a lot of popularity as a very effective framework for a variety of problems](https://towardsdatascience.com/https-medium-com-vishalmorde-xgboost-algorithm-long-she-may-rein-edd9f99be63d), and is an essential model for any data scientist to have at their disposal.

There are several possible configurations for XGBoost models, you can find the official documentation here: https://xgboost.readthedocs.io/en/latest/parameter.html


### Neural Network Models

We can keep adding models. As we saw, [caret allows for the usage of over 200 predictive models](https://topepo.github.io/caret/available-models.html). Let's make another set of models, this time setting the [**method**]{style="color: blue;"} to [***`dnn`***]{style="color: blue;"} to create [**deep neural networks**]{style="color: purple;"} :


```r
cryptodata_nested <- mutate(cryptodata_nested, 
                            nnet_model = map2(train_data, "dnn", model_caret))
```
*Again, we will not dive into the specifics of the individual models, but a quick Google search will return a myriad of information on the subject.*


<!-- ### Bayesian Regularized Neural Network Models -->

<!-- Next let's create [Bayesian Regularized Neural Network](https://stats.stackexchange.com/questions/328342/is-bayesian-ridge-regression-another-name-of-bayesian-linear-regression) models using the [**method**]{style="color: blue;"} [***`brnn`***]{style="color: blue;"} -->

<!-- ```{r bayesian_ridge_regression} -->
<!-- cryptodata_nested <- mutate(cryptodata_nested,  -->
<!--                             brnn_model = map2(train_data, "brnn", model_caret)) -->
<!-- ``` -->


<!-- ### Elastic Net Models - removed because of package conflict-->

<!-- Next let's create [Elastic Net](https://en.wikipedia.org/wiki/Elastic_net_regularization) models using the [**method**]{style="color: blue;"} [***`brnn`***]{style="color: blue;"} -->

<!-- ```{r elastic_net_models} -->
<!-- cryptodata_nested <- mutate(cryptodata_nested,  -->
<!--                             enet_model = map2(train_data, "enet", model_caret)) -->
<!-- ``` -->

### Random Forest	Models

Next let's use create [Random Forest](https://stats.stackexchange.com/questions/12140/conditional-inference-trees-vs-traditional-decision-trees) models using the [[**method**]{style="color: blue;"} [***`ctree`***]{style="color: blue;"}](https://en.wikipedia.org/wiki/Random_forest)


```r
cryptodata_nested <- mutate(cryptodata_nested, 
                            rf_model = map2(train_data, "ctree", model_caret))
```


### Principal Component Analysis

For one last set of models, let's make [Principal Component Analysis](https://en.wikipedia.org/wiki/Principal_Component_Analysis) models using the [**method**]{style="color: blue;"} [***`pcr`***]{style="color: blue;"}


```r
cryptodata_nested <- mutate(cryptodata_nested, 
                            pcr_model = map2(train_data, "pcr", model_caret))
```


### Caret Options

Caret offers some additional options to help pre-process the data as well. We outlined an [example of this in the high-level version of the tutorial when showing how to make a [**Support Vector Machine**]{style="color: purple;"} model](https://cryptocurrencyresearch.org/high-level/#/caret-additional-options), which requires the data to be [**centered**]{style="color: purple;"} and [**scaled**]{style="color: purple;"} to avoid running into problems (which we won't discuss further here).


## Make Predictions

Awesome! We have trained the predictive models, and we want to start getting a better understanding of how accurate the models are on data they have never seen before. In order to make these comparisons, we will want to make predictions on the test and holdout datasets, and compare those predictions to what actually ended up happening.

In order to make predictions, we can use the [**prediict()**]{style="color: green;"} function, here is an example on the first elements of the nested dataframe:


```r
predict(object = cryptodata_nested$lm_model[[1]],
        newdata = cryptodata_nested$test_data[[1]],
        na.action = na.pass)
```

```
##        1        2        3        4        5        6        7        8 
## 10682.40 10680.63 10677.36 10687.94 10668.94 10674.94 10674.89 10672.75 
##        9       10       11       12       13       14       15       16 
## 10677.38 10662.43 10663.87 10683.39 10678.47 10690.70 10692.18 10688.43 
##       17       18       19       20       21       22       23       24 
## 10681.45 10675.74 10673.93 10679.40 10668.08 10676.18 10688.42 10697.09 
##       25       26       27       28       29       30       31       32 
## 10695.32 10697.40 10696.98 10696.24 10707.77 10703.05 10699.69 10728.15 
##       33       34       35       36       37       38       39       40 
## 10721.97 10724.03 10728.76 10726.30 10709.79 10706.78 10712.75 10740.47 
##       41       42       43       44       45       46       47       48 
## 10748.12 10751.74 10747.08 10750.61 10750.04 10757.18 10756.41 10779.57 
##       49       50       51       52       53       54       55       56 
## 10773.52 10787.00 10782.06 10775.12 10776.33 10775.58 10780.34 10777.51 
##       57       58       59       60       61       62       63       64 
## 10767.07 10765.22 10768.67 10789.28 10791.30 10787.72 10786.67 10776.91 
##       65       66       67       68       69       70       71       72 
## 10783.86 10783.54 10773.97 10776.51 10769.82 10782.27 10782.58 10769.26 
##       73       74       75       76       77       78       79       80 
## 10773.12 10771.28 10777.74 10776.48 10785.07 10796.12 10793.70 10784.38 
##       81       82       83       84       85       86       87       88 
## 10778.46 10775.90 10751.68 10706.53 10712.23 10708.39 10719.60 10722.59 
##       89       90       91       92       93       94       95       96 
## 10715.57 10714.99 10713.17 10715.42 10708.02 10719.77 10714.25 10715.67 
##       97       98       99      100      101      102      103 
## 10719.76 10725.04 10733.97 10723.70 10719.82 10709.44 10718.97
```

Now we can create a new custom function called [**make_predictions**]{style="color: blue;"} that wraps this functionality in a way that we can use with [**map()**]{style="color: green;"} to iterate through all options of the nested dataframe:


```r
make_predictions <- function(model, test){
  
  predict(object  = model, newdata = test, na.action = na.pass)
  
}
```

Now we can create the new columns [**lm_test_predictions**]{style="color: blue;"} and [**lm_holdout_predictions**]{style="color: blue;"} with the predictions:


```r
cryptodata_nested <- mutate(cryptodata_nested, 
                            lm_test_predictions =  map2(lm_model,
                                                   test_data,
                                                   make_predictions),
                            
                            lm_holdout_predictions =  map2(lm_model,
                                                      holdout_data,
                                                      make_predictions))
```

The predictions were made using the models that had only seen the **training data**, and we can start assessing how good the model is on data it has not seen before in the **test** and **holdout** sets. Let's view the results from the previous step:


```r
select(cryptodata_nested, lm_test_predictions, lm_holdout_predictions)
```

```
## # A tibble: 255 x 4
## # Groups:   symbol, split [255]
##    symbol split lm_test_predictions lm_holdout_predictions
##    <chr>  <dbl> <list>              <list>                
##  1 BTC        1 <dbl [103]>         <dbl [105]>           
##  2 LTC        1 <dbl [103]>         <dbl [107]>           
##  3 XMR        1 <dbl [102]>         <dbl [105]>           
##  4 ETH        1 <dbl [97]>          <dbl [99]>            
##  5 ZEC        1 <dbl [85]>          <dbl [85]>            
##  6 XEM        1 <dbl [99]>          <dbl [103]>           
##  7 NEXO       1 <dbl [103]>         <dbl [105]>           
##  8 EOS        1 <dbl [101]>         <dbl [101]>           
##  9 ELF        1 <dbl [96]>          <dbl [100]>           
## 10 BNT        1 <dbl [97]>          <dbl [101]>           
## # … with 245 more rows
```

Now we can do the same for the rest of the models:


```r
cryptodata_nested <- mutate(cryptodata_nested, 
                            # XGBoost:
                            xgb_test_predictions =  map2(xgb_model,
                                                         test_data,
                                                         make_predictions),
                            # holdout
                            xgb_holdout_predictions =  map2(xgb_model,
                                                            holdout_data,
                                                            make_predictions),
                            # Neural Network:
                            nnet_test_predictions =  map2(nnet_model,
                                                          test_data,
                                                          make_predictions),
                            # holdout
                            nnet_holdout_predictions =  map2(nnet_model,
                                                             holdout_data,
                                                             make_predictions),
                            # Random Forest:
                            rf_test_predictions =  map2(rf_model,
                                                               test_data,
                                                               make_predictions),
                            # holdout
                            rf_holdout_predictions =  map2(rf_model,
                                                                  holdout_data,
                                                                  make_predictions),
                            # PCR:
                            pcr_test_predictions =  map2(pcr_model,
                                                         test_data,
                                                         make_predictions),
                            # holdout
                            pcr_holdout_predictions =  map2(pcr_model,
                                                            holdout_data,
                                                            make_predictions))
```

We are done using the [**caret**]{style="color: #ae7b11;"} package and can stop the parallel processing cluster:


```r
stopCluster(cl)
```

\BeginKnitrBlock{infoicon}<div class="infoicon">In this example we used the [caret package](https://topepo.github.io/caret/) because it provides a straightforward option to create a variety of models, but there are several great similar alternatives to make a variety of models in both R and Python. Some noteworthy mentions are [tidymodels](https://www.tidymodels.org/), [mlr](https://mlr3.mlr-org.com/), and [scikit-learn](https://scikit-learn.org/stable/).</div>\EndKnitrBlock{infoicon}


## Timeseries 

Because this tutorial is already very dense, we will just focus on the models we created above. When creating predictive models on timeseries data there are some other excellent options which consider when the information was collected in similar but more intricate ways to the way we did when creating the lagged variables.

For more information on using excellent tools for [ARIMA and ETS models, consult the high-level version of this tutorial where they were discussed](https://cryptocurrencyresearch.org/high-level/#/timeseries-predictive-modeling).



<!-- [TODO - HERE TALK ABOUT ARIMA AND ETS AND MAKE MODELS! KEEP SAME STRUCTURE AND WILL BE ABLE TO DO postResample()] -->

<!-- [TODO - AFTERWARDS ALSO NEED TO ADD NEW STEPS INTO NEXT SECTION!] -->



<!-- ### Convert to tsibble {#convert-to-tsibble-pred-model} -->

<!-- Repeat the steps we performed in the [Data Prep section to convert the data to the [**tsibble**]{style="color: blue;"} format](#convert-to-tsibble): -->

<!-- STEPS BELOW NEED TO BE CONVERTED FOR NESTED DATA USING FUNCTIONAL PROGRAMMING -->
<!-- ```{r} -->
<!-- cryptodata <- mutate(cryptodata, ts_index = anytime(paste0(pkDummy,':00:00'))) -->
<!-- # Distinct data by ts_index and symbol -->
<!-- cryptodata <- distinct(cryptodata, symbol, ts_index, .keep_all=TRUE) -->
<!-- # Convert to tsibble -->
<!-- cryptodata <- as_tsibble(cryptodata, index = ts_index, key = symbol) -->
<!-- ``` -->


Move on to the [next section](#evaluate-model-performance) ➡️ to assess the accuracy of the models as described in the [previous section](#model-validation-plan).

<!--chapter:end:06-PredictiveModeling.Rmd-->

# Evaluate Model Performance {#evaluate-model-performance}

Now we get to see the results of our hard work! There are some additional data preparation steps we need to take before we can visualize the results in aggregate; if you are just looking for the charts showing the results they are [shown later on in the "Visualize Results" section below](#interactive-dashboard).

## Summarizing models

Because we know what really happened for the target variable in the test data we used in the previous step, we can get a good idea of how good the model performed on a dataset it has never seen before. We do this to avoid overfitting, which is the idea that the model may work really well on the training data we provided, but not on the new data that we want to predictions on. If the performance on the test set is good, that is a good sign. If the data is split into several subsets and each subset has consistent results for the training and test datasets, that is an even better sign the model may perform as expected.

The first row of the data is for the BTC cryptocurrency for the split number 1. For this row of data (and all others), we made predictions for the [**test_data**]{style="color: blue;"} using a linear regression model and saved the results in the [**lm_test_predictions**]{style="color: blue;"} column. The models were trained on the [**train_data**]{style="color: blue;"} and had not yet seen the results from the [**test_data**]{style="color: blue;"}, so how accurate was the model in its predictions on this data? 

### MAE

Each individual prediction can be compared to the observation of what actually happened, and for each prediction we can calculate the error between the two. We can then take all of the values for the error of the prediction relative to the actual observations, and summarize the performance as a [[**M**ean **A**bsolute **Error**]{style="color: purple;"}](https://en.wikipedia.org/wiki/Mean_absolute_error) (MAE) of those values, which gives us a single value to use as an indicator of the accuracy of the model. The higher the MAE score, the higher the error, meaning the model performs worse when the value is larger.

### RMSE

A common metric to evaluate the performance of a model is the [**R**oot **M**ean **S**quare **E**rror](https://en.wikipedia.org/wiki/Root-mean-square_deviation), which is similar to the MAE but squares and then takes the square root of the values. An interesting implication of this, is that the RMSE will always be larger or equal to the MAE, where a large degree of error on a single observation would get penalized more by the RMSE. The higher the RMSE value, the worse the performance of the model, and can range from 0 to infinity, meaning there is no defined limit on the amount of error you could have (unlike the next metric).

### R Squared

The [**$R^2$**]{style="color: purple;"}, also known as the [**coefficient of determination**]{style="color: purple;"}, is a measure that describes the strength in the correlation between the predictions made and the actual results. A value of 1.0 would mean that the predictions made were exactly identical to the actual results. A perfect score is usually concerning because even a great model shouldn't be exactly 100% accurate and usually indicates a mistake was made that gave away the results to the model and would not perform nearly as good when put into practice in the real world, but in the case of the $R^2$ the higher the score (from 0 to 1) the better.


### Get Metrics

We can return the RMSE and $R^2$ metrics for the BTC cryptocurrency and the split number 1 by using the [**postResample()**]{style="color: green;"} function from the [**caret**]{style="color: #ae7b11;"} package:


```r
postResample(pred = cryptodata_nested$lm_test_predictions[[1]], 
             obs = cryptodata_nested$test_data[[1]]$target_price_24h)
```

```
##        RMSE    Rsquared         MAE 
## 603.5376662   0.2514686 578.7992431
```

We can extract the first element to return the **RMSE** metric, and the second element for the **R Squared (R\^2)** metric. We are using **`[[1]]`** to extract the first element of the [**lm\_test\_predictions**]{style="color: blue;"} and [**test\_data**]{style="color: blue;"} and compare the predictions to the actual value of the [**target\_price24h**]{style="color: blue;"} column.

This model used the earliest subset of the data available for the  cryptocurrency. How does the same model used to predict this older subset of the data perform when applied to the most recent subset of the data from the **holdout**?

We can get the same summary of results comparing the [**lm_holdout_predictions**]{style="color: blue;"} to what actually happened to the [**target_price_24h**]{style="color: blue;"} column of the actual [**holdout_data**]{style="color: blue;"}:


```r
postResample(pred = cryptodata_nested$lm_holdout_predictions[[1]], 
             obs = cryptodata_nested$holdout_data[[1]]$target_price_24h)
```

```
##      RMSE  Rsquared       MAE 
##        NA 0.2107372        NA
```

*The result above may show a value of NA for the RMSE metric. [We will explain and resolve the issue later on](#calculate-rmse-no-NA)*.


### Comparing Metrics

Why not just pick one metric and stick to it? We certainly could, but these two metrics complement each other. For example, if we had a model that always predicts a 0% price change for the time period, the model may have a low error but it wouldn't actually be very informative in the direction or magnitude of those movements and the predictions and actuals would not be very correlated with each other which would lead to a low $R^2$ value. We are using both because it helps paint a more complete picture in this sense, and depending on the task you may want to use a different set of metrics to evaluate the performance. It is also worth mentioning that if your target variable you are predicting is either 0 or 1, this would be a [**classification**]{style="color: purple;"} problem where different metrics become more appropriate to use.

<!-- How do these two results compare and why is this comparison important? The **RMSE** is helpful in understanding the magnitude of the errors of the predictions, while the **$R^2$** helps us determine how easily we can predict future values.  -->

**These are indicators that should be taken with a grain of salt individually, but comparing the results across many different models for the same cryptocurrency can help us determine which models work best for the problem, and then comparing those results across many cryptocurrencies can help us understand which cryptocurrencies we can predict with the most accuracy**.

Before we can draw these comparisons however, we will need to "standardize" the values to create a fair comparison across all dataasets.

<!-- TODO: If for holdout a cryptocurrency averaged less than 1% price movement for the holdout it's not volatile enough for us for it to be relevant, for example if a cryptocurrency is a stablecoin -->


## Data Prep - Adjust Prices

<!-- [TODO - add note on first doing lm only?] -->

Because cryptocurrencies can vary dramatically in their prices with some trading in the tens of thousands of dollars and others trading for less than a cent, we need to make sure to standardize the RMSE columns to provide a fair comparison for the metric.

Therefore, before using the `postResample()` function, let's convert both the predictions and the target to be the % change in price over the 24 hour period, rather than the change in price (\$).

\BeginKnitrBlock{infoicon}<div class="infoicon">This step is particularly tedious, but it is important. As with the rest of this tutorial, try to understand what we are doing and why even if you find the code overwhelming. All we are doing in this "Adjust Prices" section is we are adjusting all of the prices to be represented as percentage change between observations, which will allow us to draw a fair comparison of the metrics across all cryptocurrencies, which would not be possible using the prices themselves. If you want to [skip the tedious steps and want to see the performance of the models visualized, click here to skip ahead.](#visualize-results)</div>\EndKnitrBlock{infoicon}

### Add Last Price

<!-- [TODO - write better - KEEP GOING 11/14] -->

In order to convert the first prediction made to be a percentage, we need to know the previous price, which would be the last observation from the train data. Therefore, let's make a function to add the [**last_price_train**]{style="color: blue;"} column and append it to the predictions made so we can calculate the % change of the first element relative to the last observation in the train data, before later removing the value not associated with the predictions:


```r
last_train_price <- function(train_data, predictions){
  c(tail(train_data$price_usd,1), predictions)
}
```

**We will first perform all steps on the linear regression models to make the code a little more digestible, and we will then perform the [same steps for the rest of the models](#adjust-prices-all-models).**

#### Test 

Overwrite the old predictions for the first 4 splits of the test data using the new function created above:


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            lm_test_predictions = ifelse(split < 5,
                                                         map2(train_data, lm_test_predictions, last_train_price),
                                                         NA))
```
*The [**mutate()**]{style="color: green;"} function is used to create the new column [**lm_test_predictions**]{style="color: blue;"} assigning the value only for the first 4 splits where the test data would actually exist (the 5th being the holdout set) using the [**ifelse()**]{style="color: green;"} function*.


#### Holdout

Do the same but for the holdout now. For the holdout we need to take the last price point of the 5th split:

```r
cryptodata_nested_holdout <- mutate(filter(cryptodata_nested, split == 5),
                                    lm_holdout_predictions = map2(train_data, lm_holdout_predictions, last_train_price))
```

Now join the holdout data to all rows based on the cryptocurrency symbol alone:


```r
cryptodata_nested <- left_join(cryptodata_nested, 
                               select(cryptodata_nested_holdout, symbol, lm_holdout_predictions),
                               by='symbol')
# Remove unwanted columns
cryptodata_nested <- select(cryptodata_nested, -lm_holdout_predictions.x, -split.y)
# Rename the columns kept
cryptodata_nested <- rename(cryptodata_nested, 
                            lm_holdout_predictions = 'lm_holdout_predictions.y',
                            split = 'split.x')
# Reset the correct grouping structure
cryptodata_nested <- group_by(cryptodata_nested, symbol, split)
```

### Convert to Percentage Change

Now we have everything we need to accurately calculate the percentage change between observations including the first one. Let's make a new function to calculate the percentage change:


```r
standardize_perc_change <- function(predictions){
  results <- (diff(c(lag(predictions, 1), predictions)) / lag(predictions, 1))*100
  # Exclude the first element, next element will be % change of first prediction
  tail(head(results, length(predictions)), length(predictions)-1)
}
```

Overwrite the old predictions with the new predictions adjusted as a percentage now:


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            lm_test_predictions = ifelse(split < 5,
                                                         map(lm_test_predictions, standardize_perc_change),
                                                         NA),
                            # Holdout for all splits
                            lm_holdout_predictions = map(lm_holdout_predictions, standardize_perc_change))
```

### Actuals

Now do the same thing to the actual prices. Let's make a new column called [**actuals**]{style="color: blue;"} containing the real price values (rather than the predicted ones):


```r
actuals_create <- function(train_data, test_data){
  c(tail(train_data$price_usd,1), as.numeric(unlist(select(test_data, price_usd))))
}
```

Use the new function to create the new column [**actuals**]{style="color: blue;"}:


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            actuals_test = ifelse(split < 5,
                                             map2(train_data, test_data, actuals_create),
                                             NA))
```

#### Holdout

Again, for the holdout we need the price from the training data of the 5th split to perform the first calculation:

```r
cryptodata_nested_holdout <- mutate(filter(cryptodata_nested, split == 5),
                                    actuals_holdout = map2(train_data, holdout_data, actuals_create))
```

Join the holdout data to all rows based on the cryptocurrency symbol alone:


```r
cryptodata_nested <- left_join(cryptodata_nested, 
                               select(cryptodata_nested_holdout, symbol, actuals_holdout),
                               by='symbol')
# Remove unwanted columns
cryptodata_nested <- select(cryptodata_nested, -split.y)
# Rename the columns kept
cryptodata_nested <- rename(cryptodata_nested, split = 'split.x')
# Reset the correct grouping structure
cryptodata_nested <- group_by(cryptodata_nested, symbol, split)
```


### Actuals as % Change

Now we can convert the new [**actuals**]{style="color: blue;"} to express the [**price_usd**]{style="color: blue;"} as a % change relative to the previous value using adapting the function from earlier:


```r
actuals_perc_change <- function(predictions){
  results <- (diff(c(lag(predictions, 1), predictions)) / lag(predictions, 1))*100
  # Exclude the first element, next element will be % change of first prediction
  tail(head(results, length(predictions)), length(predictions)-1)
}
```


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            actuals_test = ifelse(split < 5,
                                             map(actuals_test, actuals_perc_change),
                                             NA),
                            actuals_holdout = map(actuals_holdout, actuals_perc_change))
```

## Review Summary Statistics

Now that we standardized the price to show the percentage change relative to the previous period instead of the price in dollars, we can actually compare the summary statistics across all cryptocurrencies and have it be a fair comparison.

Let's get the same statistic as we did at the beginning of this section, but this time on the standardized values. This time to calculate the RMSE error metric let's use the [**rmse()**]{style="color: green;"} function from the [**hydroGOF**]{style="color: #ae7b11;"} package because it allows us to set the [**`na.rm = T`**]{style="color: blue;"} parameter, and otherwise one NA value would return NA for the overall RMSE:


```r
hydroGOF::rmse(cryptodata_nested$lm_test_predictions[[1]], 
               cryptodata_nested$actuals_test[[1]], 
               na.rm=T)
```

```
## [1] 0.6828315
```


### Calculate R\^2

Now we can do the same for the R Squared metric using the same [**postResample()**]{style="color: green;"} function that we used at [the start of this section](#evaluate-model-performance):


```r
evaluate_preds_rsq <- function(predictions, actuals){

  postResample(pred = predictions, obs = actuals)[[2]]

}
```


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            lm_rsq_test = unlist(ifelse(split < 5,
                                                         map2(lm_test_predictions, actuals_test, evaluate_preds_rsq),
                                                         NA)),
                            lm_rsq_holdout = unlist(map2(lm_holdout_predictions, actuals_holdout, evaluate_preds_rsq)))
```

Look at the results:


```r
select(cryptodata_nested, lm_rsq_test, lm_rsq_holdout)
```

```
## # A tibble: 255 x 4
## # Groups:   symbol, split [255]
##    symbol split lm_rsq_test lm_rsq_holdout
##    <chr>  <dbl>       <dbl>          <dbl>
##  1 BTC        1     0.348            0.947
##  2 LTC        1     0.0527           0.981
##  3 XMR        1     0.735            0.611
##  4 ETH        1     1                0.954
##  5 ZEC        1     0.548            0.499
##  6 XEM        1     0.639            0.543
##  7 NEXO       1     0.0300           0.659
##  8 EOS        1     0.00328          0.917
##  9 ELF        1     0.611            0.796
## 10 BNT        1     0.823            0.926
## # … with 245 more rows
```


### Calculate RMSE {#calculate-rmse-no-NA}

Similarly let's make a function to get the RMSE metric for all models:


```r
evaluate_preds_rmse <- function(predictions, actuals){

  hydroGOF::rmse(predictions, actuals, na.rm=T)

}
```

Now we can use the [**map2()**]{style="color: green;"} function to use it to get the RMSE metric for both the test data and the holdout:


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            lm_rmse_test = unlist(ifelse(split < 5,
                                                         map2(lm_test_predictions, actuals_test, evaluate_preds_rmse),
                                                         NA)),
                            lm_rmse_holdout = unlist(map2(lm_holdout_predictions, actuals_holdout, evaluate_preds_rmse)))
```

<!-- [TODO - Add explanation for ifelse() to add rmse based on test or holdout] -->

Look at the results. Wrapping them in [**`print(n=500)`**]{style="color: blue;"} overwrites the behavior to only give a preview of the data so we can view the full results (up to 500 observations).


```r
print(select(cryptodata_nested, lm_rmse_test, lm_rmse_holdout, lm_rsq_test, lm_rsq_holdout), n=500)
```

```
## # A tibble: 255 x 6
## # Groups:   symbol, split [255]
##     symbol split lm_rmse_test lm_rmse_holdout lm_rsq_test lm_rsq_holdout
##     <chr>  <dbl>        <dbl>           <dbl>       <dbl>          <dbl>
##   1 BTC        1      0.683            0.462     0.348           0.947  
##   2 LTC        1      0.967            0.763     0.0527          0.981  
##   3 XMR        1      1.13             2.11      0.735           0.611  
##   4 ETH        1      0.142            0.839     1               0.954  
##   5 ZEC        1      0.611            0.805     0.548           0.499  
##   6 XEM        1      0.654            1.22      0.639           0.543  
##   7 NEXO       1      1.22             1.61      0.0300          0.659  
##   8 EOS        1      1.27             0.473     0.00328         0.917  
##   9 ELF        1      0.626            0.693     0.611           0.796  
##  10 BNT        1      1.64             1.35      0.823           0.926  
##  11 MANA       1      0.620            0.546     0.810           0.832  
##  12 BAT        1      0.937            0.466     0.473           0.800  
##  13 OAX        1      1.10             0.296     0.000425        0.752  
##  14 SRN        1      4.54            14.1       0.456           0.346  
##  15 ZRX        1      0.573            0.901     0.757           0.663  
##  16 DGB        1      0.530            1.42      0.459           0.699  
##  17 ENJ        1      2.61             2.31      0.199           0.631  
##  18 TRX        1      0.605            0.707     0.298           0.803  
##  19 BSV        1      0.443            0.494     0.729           0.797  
##  20 BTM        1      0.834            0.723     0.866           0.781  
##  21 STORJ      1      4.88             0.688     0.0152          0.803  
##  22 VIB        1      1.32           NaN         0.105          NA      
##  23 BTG        1      0.187            0.829     0.987           0.737  
##  24 HT         1      0.267            1.49      0.0906          0.164  
##  25 ETP        1      0.869            1.75      0.296           0.744  
##  26 CRO        1      0.263            1.12      0.797           0.847  
##  27 NUT        1      0.513            0.0324    0.0148          0.00156
##  28 DCR        1      0.485            1.47      0.590           0.687  
##  29 CHZ        1      0.548            1.30      0.512           0.698  
##  30 ADA        1      0.933            1.06      0.282           0.945  
##  31 BRD        1      8.22            18.4       0.951           0.212  
##  32 XNS        1      4.16             6.26      0.600           0.00831
##  33 ARDR       1      1.33             1.53      0.605           0.424  
##  34 WAXP       1      0.809            0.833     0.681           0.437  
##  35 XRP        1      1.20             1.33      0.433           0.429  
##  36 KNC        1      0.660            0.885     0.583           0.852  
##  37 LEO        1      0.00690          0.620     0.395           0.159  
##  38 KMD        1      1.18             1.04      0.568           0.661  
##  39 QTUM       1      1.24             2.53      0.683           0.0507 
##  40 CUR        1      2.34             0.231     0.401           0.00176
##  41 JST        1      2.24             0.874     0.667           0.785  
##  42 SEELE      1     17.8              2.48      0.0157          0.0324 
##  43 AAB        1      0.352           53.3       0.0191          0.0655 
##  44 AVA        1      0.737            1.24      0.523           0.896  
##  45 CRPT       1      1.72             1.91      0.101           0.806  
##  46 XRP        2    NaN                1.33     NA               0.429  
##  47 NUT        2      1.26             0.0324    0.784           0.00156
##  48 QTUM       2      1.60             2.53      0.285           0.0507 
##  49 VIB        2      4.80           NaN         0.516          NA      
##  50 AAB        2      2.15            53.3       0.0710          0.0655 
##  51 SRN        2      8.01            14.1       0.341           0.346  
##  52 TRX        2      0.560            0.707     0.562           0.803  
##  53 EOS        2      0.687            0.473     0.516           0.917  
##  54 OAX        2      5.13             0.296     0.106           0.752  
##  55 MANA       2      0.629            0.546     0.475           0.832  
##  56 ETP        2      0.682            1.75      0.643           0.744  
##  57 XMR        2      0.706            2.11      0.608           0.611  
##  58 ZRX        2      0.756            0.901     0.480           0.663  
##  59 BAT        2      0.642            0.466     0.614           0.800  
##  60 LTC        2      0.507            0.763     0.616           0.981  
##  61 DGB        2      1.33             1.42      0.269           0.699  
##  62 BTC        2      0.243            0.462     0.841           0.947  
##  63 NEXO       2      0.750            1.61      0.720           0.659  
##  64 DCR        2      0.622            1.47      0.663           0.687  
##  65 ENJ        2      3.83             2.31      0.0902          0.631  
##  66 BSV        2      0.431            0.494     0.830           0.797  
##  67 HT         2      0.869            1.49      0.937           0.164  
##  68 BNT        2      0.907            1.35      0.553           0.926  
##  69 KNC        2      0.499            0.885     0.863           0.852  
##  70 CUR        2      0.0746           0.231     0.708           0.00176
##  71 CRO        2      0.787            1.12      0.818           0.847  
##  72 BTG        2      0.747            0.829     0.380           0.737  
##  73 ETH        2      1.05             0.839     0.617           0.954  
##  74 SEELE      2      2.73             2.48      0.702           0.0324 
##  75 BRD        2      4.46            18.4       0.0683          0.212  
##  76 AVA        2      4.51             1.24      0.363           0.896  
##  77 XNS        2      8.96             6.26      0.344           0.00831
##  78 XEM        2      0.642            1.22      0.708           0.543  
##  79 CHZ        2      0.573            1.30      0.604           0.698  
##  80 ARDR       2      2.10             1.53      0.0388          0.424  
##  81 WAXP       2      0.744            0.833     0.570           0.437  
##  82 JST        2      1.34             0.874     0.904           0.785  
##  83 ADA        2      0.611            1.06      0.548           0.945  
##  84 KMD        2      0.806            1.04      0.242           0.661  
##  85 ELF        2      0.860            0.693     0.559           0.796  
##  86 CRPT       2      0.449            1.91      0.760           0.806  
##  87 CRV        1      2.49             1.61      1               0.628  
##  88 BTM        2      1.27             0.723     0.461           0.781  
##  89 STORJ      2      2.20             0.688     0.536           0.803  
##  90 ASP        1      2.78             3.36      0.964           0.395  
##  91 LEO        2      0.00800          0.620     0.00903         0.159  
##  92 NUT        3    NaN                0.0324   NA               0.00156
##  93 AAB        3      1.14            53.3       0.00766         0.0655 
##  94 ZEC        2      0.865            0.805     0.620           0.499  
##  95 LEVL       1      9.01             9.06      0.138           0.247  
##  96 UNI        1     20.5              3.15      0.00282         0.517  
##  97 VIB        3      4.22           NaN         0.264          NA      
##  98 ETP        3      1.18             1.75      0.389           0.744  
##  99 ZRX        3      1.10             0.901     0.877           0.663  
## 100 BAT        3      0.809            0.466     0.529           0.800  
## 101 DGB        3      1.11             1.42      0.733           0.699  
## 102 LTC        3      0.929            0.763     0.764           0.981  
## 103 BTC        3      0.367            0.462     0.760           0.947  
## 104 XMR        3      0.863            2.11      0.664           0.611  
## 105 DCR        3      1.04             1.47      0.557           0.687  
## 106 NEXO       3      1.21             1.61      0.549           0.659  
## 107 BSV        3      2.47             0.494     0.190           0.797  
## 108 OAX        3      6.20             0.296     0.276           0.752  
## 109 CCE        1      4.69             6.47      0.261           0.00535
## 110 MANA       3      0.863            0.546     0.888           0.832  
## 111 ENJ        3      1.80             2.31      0.334           0.631  
## 112 TRX        3      1.04             0.707     0.971           0.803  
## 113 EOS        3      0.929            0.473     0.912           0.917  
## 114 SRN        3      2.61            14.1       0.528           0.346  
## 115 CUR        3     20.4              0.231     0.103           0.00176
## 116 HT         3      0.309            1.49      0.896           0.164  
## 117 ASP        2      3.16             3.36      0.0925          0.395  
## 118 KNC        3      2.00             0.885     0.660           0.852  
## 119 SEELE      3      4.26             2.48      0.228           0.0324 
## 120 XEM        3      2.19             1.22      0.831           0.543  
## 121 CHZ        3      2.56             1.30      0.00824         0.698  
## 122 XNS        3      7.40             6.26      0.0160          0.00831
## 123 ARDR       3      2.46             1.53      0.592           0.424  
## 124 WAXP       3      1.30             0.833     0.790           0.437  
## 125 JST        3      2.63             0.874     0.638           0.785  
## 126 ADA        3      0.936            1.06      0.949           0.945  
## 127 KMD        3      3.49             1.04      0.473           0.661  
## 128 CRV        2    NaN                1.61     NA               0.628  
## 129 BTG        3      1.66             0.829     0.338           0.737  
## 130 BNT        3      2.11             1.35      0.100           0.926  
## 131 AVA        3      2.94             1.24      0.195           0.896  
## 132 CRO        3      0.564            1.12      0.960           0.847  
## 133 BRD        3      4.03            18.4       0.210           0.212  
## 134 ETH        3      1.62             0.839     0.118           0.954  
## 135 ELF        3      0.773            0.693     0.868           0.796  
## 136 CRPT       3      2.34             1.91      0.0347          0.806  
## 137 STORJ      3      1.31             0.688     0.679           0.803  
## 138 BTM        3      3.46             0.723     0.0516          0.781  
## 139 LEO        3      1.72             0.620     0.613           0.159  
## 140 FTM        1      3.00             5.83      0.158           0.519  
## 141 AAB        4      0.0965          53.3      NA               0.0655 
## 142 LEVL       2      5.38             9.06      1               0.247  
## 143 ZEC        3      0.606            0.805     0.894           0.499  
## 144 UNI        2      2.98             3.15      0.172           0.517  
## 145 CCE        2      5.79             6.47      0.631           0.00535
## 146 ASP        3      4.50             3.36      0.0732          0.395  
## 147 FTM        2      2.03             5.83      0.343           0.519  
## 148 SRN        4      4.21            14.1       0.814           0.346  
## 149 CUR        4      2.30             0.231     0.240           0.00176
## 150 DGB        4      0.667            1.42      0.604           0.699  
## 151 ZRX        4      0.696            0.901     0.658           0.663  
## 152 LTC        4      0.621            0.763     0.861           0.981  
## 153 XMR        4      0.708            2.11      0.938           0.611  
## 154 BTC        4      0.244            0.462     0.958           0.947  
## 155 BAT        4      0.652            0.466     0.600           0.800  
## 156 NEXO       4      1.17             1.61      0.597           0.659  
## 157 DCR        4      0.980            1.47      0.703           0.687  
## 158 ETP        4      1.12             1.75      0.644           0.744  
## 159 CRV        3      1.81             1.61      0.141           0.628  
## 160 SEELE      4      5.99             2.48      0.515           0.0324 
## 161 BSV        4      0.570            0.494     0.550           0.797  
## 162 KNC        4      1.60             0.885     0.00594         0.852  
## 163 OAX        4      3.16             0.296     0.645           0.752  
## 164 MANA       4      0.590            0.546     0.784           0.832  
## 165 ENJ        4      0.939            2.31      0.544           0.631  
## 166 TRX        4      0.534            0.707     0.449           0.803  
## 167 EOS        4      0.537            0.473     0.544           0.917  
## 168 HT         4      0.717            1.49      0.182           0.164  
## 169 CHZ        4      1.45             1.30      0.831           0.698  
## 170 XNS        4      3.81             6.26      0.392           0.00831
## 171 XEM        4      0.815            1.22      0.717           0.543  
## 172 KMD        4      0.462            1.04      0.633           0.661  
## 173 ARDR       4      0.609            1.53      0.873           0.424  
## 174 WAXP       4      0.323            0.833     0.869           0.437  
## 175 JST        4      0.523            0.874     0.472           0.785  
## 176 ADA        4      0.519            1.06      0.671           0.945  
## 177 BNT        4      2.79             1.35      0.954           0.926  
## 178 BTG        4      0.520            0.829     0.807           0.737  
## 179 BRD        4      1.01            18.4       0.369           0.212  
## 180 ETH        4      0.574            0.839     0.863           0.954  
## 181 CRO        4      0.327            1.12      0.933           0.847  
## 182 ELF        4      0.418            0.693     0.761           0.796  
## 183 AVA        4      0.604            1.24      0.832           0.896  
## 184 VIB        4      3.41           NaN         0.247          NA      
## 185 UNI        3      2.63             3.15      0.179           0.517  
## 186 STORJ      4      0.658            0.688     0.489           0.803  
## 187 LEVL       3      5.56             9.06      0.0903          0.247  
## 188 BTM        4      0.580            0.723     0.708           0.781  
## 189 LEO        4      0.0712           0.620     0.000432        0.159  
## 190 CCE        3      0.688            6.47     NA               0.00535
## 191 CRPT       4      2.78             1.91      0.426           0.806  
## 192 ZEC        4      0.324            0.805     0.960           0.499  
## 193 FTM        3      0.905            5.83      0.527           0.519  
## 194 XRP        3      1.72             1.33      0.680           0.429  
## 195 ASP        4      1.12             3.36      0.538           0.395  
## 196 QTUM       3      0.885            2.53      0.593           0.0507 
## 197 NUT        4      0.0331           0.0324    0.0917          0.00156
## 198 AAB        5     NA               53.3      NA               0.0655 
## 199 CRV        4      2.97             1.61      0.831           0.628  
## 200 UNI        4      1.55             3.15      0.626           0.517  
## 201 LEVL       4      6.33             9.06      0.662           0.247  
## 202 VIB        5     NA              NaN        NA              NA      
## 203 FTM        4      1.02             5.83      0.681           0.519  
## 204 CCE        4      9.65             6.47      0.190           0.00535
## 205 SEELE      5     NA                2.48     NA               0.0324 
## 206 SRN        5     NA               14.1      NA               0.346  
## 207 ZRX        5     NA                0.901    NA               0.663  
## 208 XMR        5     NA                2.11     NA               0.611  
## 209 DGB        5     NA                1.42     NA               0.699  
## 210 LTC        5     NA                0.763    NA               0.981  
## 211 BAT        5     NA                0.466    NA               0.800  
## 212 XRP        4      6.38             1.33      0.509           0.429  
## 213 BTC        5     NA                0.462    NA               0.947  
## 214 NEXO       5     NA                1.61     NA               0.659  
## 215 DCR        5     NA                1.47     NA               0.687  
## 216 ETP        5     NA                1.75     NA               0.744  
## 217 BSV        5     NA                0.494    NA               0.797  
## 218 TRX        5     NA                0.707    NA               0.803  
## 219 MANA       5     NA                0.546    NA               0.832  
## 220 OAX        5     NA                0.296    NA               0.752  
## 221 ENJ        5     NA                2.31     NA               0.631  
## 222 EOS        5     NA                0.473    NA               0.917  
## 223 HT         5     NA                1.49     NA               0.164  
## 224 KNC        5     NA                0.885    NA               0.852  
## 225 XEM        5     NA                1.22     NA               0.543  
## 226 KMD        5     NA                1.04     NA               0.661  
## 227 CHZ        5     NA                1.30     NA               0.698  
## 228 ARDR       5     NA                1.53     NA               0.424  
## 229 WAXP       5     NA                0.833    NA               0.437  
## 230 ADA        5     NA                1.06     NA               0.945  
## 231 XNS        5     NA                6.26     NA               0.00831
## 232 JST        5     NA                0.874    NA               0.785  
## 233 BNT        5     NA                1.35     NA               0.926  
## 234 CRO        5     NA                1.12     NA               0.847  
## 235 ETH        5     NA                0.839    NA               0.954  
## 236 ELF        5     NA                0.693    NA               0.796  
## 237 BRD        5     NA               18.4      NA               0.212  
## 238 BTG        5     NA                0.829    NA               0.737  
## 239 QTUM       4      3.64             2.53      0.00584         0.0507 
## 240 CUR        5     NA                0.231    NA               0.00176
## 241 AVA        5     NA                1.24     NA               0.896  
## 242 STORJ      5     NA                0.688    NA               0.803  
## 243 LEO        5     NA                0.620    NA               0.159  
## 244 BTM        5     NA                0.723    NA               0.781  
## 245 CRPT       5     NA                1.91     NA               0.806  
## 246 ZEC        5     NA                0.805    NA               0.499  
## 247 ASP        5     NA                3.36     NA               0.395  
## 248 LEVL       5     NA                9.06     NA               0.247  
## 249 NUT        5     NA                0.0324   NA               0.00156
## 250 CRV        5     NA                1.61     NA               0.628  
## 251 UNI        5     NA                3.15     NA               0.517  
## 252 CCE        5     NA                6.47     NA               0.00535
## 253 FTM        5     NA                5.83     NA               0.519  
## 254 XRP        5     NA                1.33     NA               0.429  
## 255 QTUM       5     NA                2.53     NA               0.0507
```

Out of 255 groups, 79 had an equal or lower RMSE score for the holdout than the test set.


## Adjust Prices - All Models{#adjust-prices-all-models}

Let's repeat the same steps that we outlined above for all models.

### Add Last Price


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            # XGBoost:
                            xgb_test_predictions = ifelse(split < 5,
                                                         map2(train_data, xgb_test_predictions, last_train_price),
                                                         NA),
                            # Neural Network:
                            nnet_test_predictions = ifelse(split < 5,
                                                         map2(train_data, nnet_test_predictions, last_train_price),
                                                         NA),
                            # Random Forest:
                            rf_test_predictions = ifelse(split < 5,
                                                         map2(train_data, rf_test_predictions, last_train_price),
                                                         NA),
                            # PCR:
                            pcr_test_predictions = ifelse(split < 5,
                                                         map2(train_data, pcr_test_predictions, last_train_price),
                                                         NA))
```

##### Holdout


```r
cryptodata_nested_holdout <- mutate(filter(cryptodata_nested, split == 5),
                                    # XGBoost:
                                    xgb_holdout_predictions = map2(train_data, xgb_holdout_predictions, last_train_price),
                                    # Neural Network:
                                    nnet_holdout_predictions = map2(train_data, nnet_holdout_predictions, last_train_price),
                                    # Random Forest:
                                    rf_holdout_predictions = map2(train_data, rf_holdout_predictions, last_train_price),
                                    # PCR:
                                    pcr_holdout_predictions = map2(train_data, pcr_holdout_predictions, last_train_price))
```

Join the holdout data to all rows based on the cryptocurrency symbol alone:


```r
cryptodata_nested <- left_join(cryptodata_nested, 
                               select(cryptodata_nested_holdout, symbol, 
                                      xgb_holdout_predictions, nnet_holdout_predictions, 
                                      rf_holdout_predictions, pcr_holdout_predictions),
                               by='symbol')
# Remove unwanted columns
cryptodata_nested <- select(cryptodata_nested, -xgb_holdout_predictions.x, 
                            -nnet_holdout_predictions.x,-rf_holdout_predictions.x, 
                            -pcr_holdout_predictions.x, -split.y)
# Rename the columns kept
cryptodata_nested <- rename(cryptodata_nested, 
                            xgb_holdout_predictions = 'xgb_holdout_predictions.y',
                            nnet_holdout_predictions = 'nnet_holdout_predictions.y',
                            rf_holdout_predictions = 'rf_holdout_predictions.y',
                            pcr_holdout_predictions = 'pcr_holdout_predictions.y',
                            split = 'split.x')
# Reset the correct grouping structure
cryptodata_nested <- group_by(cryptodata_nested, symbol, split)
```

### Convert to % Change

Overwrite the old predictions with the new predictions adjusted as a percentage now:


```r
cryptodata_nested <- mutate(cryptodata_nested,
                            # XGBoost:
                            xgb_test_predictions = ifelse(split < 5,
                                                         map(xgb_test_predictions, standardize_perc_change),
                                                         NA),
                            # holdout - all splits
                            xgb_holdout_predictions = map(xgb_holdout_predictions, standardize_perc_change),
                            # nnet:
                            nnet_test_predictions = ifelse(split < 5,
                                                         map(nnet_test_predictions, standardize_perc_change),
                                                         NA),
                            # holdout - all splits
                            nnet_holdout_predictions = map(nnet_holdout_predictions, standardize_perc_change),
                            # Random Forest:
                            rf_test_predictions = ifelse(split < 5,
                                                         map(rf_test_predictions, standardize_perc_change),
                                                         NA),
                            # holdout - all splits
                            rf_holdout_predictions = map(rf_holdout_predictions, standardize_perc_change),
                            # PCR:
                            pcr_test_predictions = ifelse(split < 5,
                                                         map(pcr_test_predictions, standardize_perc_change),
                                                         NA),
                            # holdout - all splits
                            pcr_holdout_predictions = map(pcr_holdout_predictions, standardize_perc_change))
```

### Add Metrics

Add the RMSE and $R^2$ metrics:

```r
cryptodata_nested <- mutate(cryptodata_nested,
                            # XGBoost - RMSE - Test
                            xgb_rmse_test = unlist(ifelse(split < 5,
                                                         map2(xgb_test_predictions, actuals_test, evaluate_preds_rmse),
                                                         NA)),
                            # And holdout:
                            xgb_rmse_holdout = unlist(map2(xgb_holdout_predictions, actuals_holdout ,evaluate_preds_rmse)),
                            # XGBoost - R^2 - Test
                            xgb_rsq_test = unlist(ifelse(split < 5,
                                                         map2(xgb_test_predictions, actuals_test, evaluate_preds_rsq),
                                                         NA)),
                            # And holdout:
                            xgb_rsq_holdout = unlist(map2(xgb_holdout_predictions, actuals_holdout, evaluate_preds_rsq)),
                            # Neural Network - RMSE - Test
                            nnet_rmse_test = unlist(ifelse(split < 5,
                                                         map2(nnet_test_predictions, actuals_test, evaluate_preds_rmse),
                                                         NA)),
                            # And holdout:
                            nnet_rmse_holdout = unlist(map2(nnet_holdout_predictions, actuals_holdout, evaluate_preds_rmse)),
                            # Neural Network - R^2 - Test
                            nnet_rsq_test = unlist(ifelse(split < 5,
                                                         map2(nnet_test_predictions, actuals_test, evaluate_preds_rsq),
                                                         NA)),
                            # And holdout:
                            nnet_rsq_holdout = unlist(map2(nnet_holdout_predictions, actuals_holdout, evaluate_preds_rsq)),
                            # Random Forest - RMSE - Test
                            rf_rmse_test = unlist(ifelse(split < 5,
                                                         map2(rf_test_predictions, actuals_test, evaluate_preds_rmse),
                                                         NA)),
                            # And holdout:
                            rf_rmse_holdout = unlist(map2(rf_holdout_predictions, actuals_holdout, evaluate_preds_rmse)),
                            # Random Forest - R^2 - Test
                            rf_rsq_test = unlist(ifelse(split < 5,
                                                         map2(rf_test_predictions, actuals_test, evaluate_preds_rsq),
                                                         NA)),
                            # And holdout:
                            rf_rsq_holdout = unlist(map2(rf_holdout_predictions, actuals_holdout, evaluate_preds_rsq)),
                            # PCR - RMSE - Test
                            pcr_rmse_test = unlist(ifelse(split < 5,
                                                         map2(pcr_test_predictions, actuals_test, evaluate_preds_rmse),
                                                         NA)),
                            # And holdout:
                            pcr_rmse_holdout = unlist(map2(pcr_holdout_predictions, actuals_holdout, evaluate_preds_rmse)),
                            # PCR - R^2 - Test
                            pcr_rsq_test = unlist(ifelse(split < 5,
                                                         map2(pcr_test_predictions, actuals_test, evaluate_preds_rsq),
                                                         NA)),
                            # And holdout:
                            pcr_rsq_holdout = unlist(map2(pcr_holdout_predictions, actuals_holdout, evaluate_preds_rsq)))
```

Now we have RMSE and $R^2$ values for every model created for every cryptocurrency and split of the data:


```r
select(cryptodata_nested, lm_rmse_test, lm_rsq_test, lm_rmse_holdout, lm_rsq_holdout)
```

```
## # A tibble: 255 x 6
## # Groups:   symbol, split [255]
##    symbol split lm_rmse_test lm_rsq_test lm_rmse_holdout lm_rsq_holdout
##    <chr>  <dbl>        <dbl>       <dbl>           <dbl>          <dbl>
##  1 BTC        1        0.683     0.348             0.462          0.947
##  2 LTC        1        0.967     0.0527            0.763          0.981
##  3 XMR        1        1.13      0.735             2.11           0.611
##  4 ETH        1        0.142     1                 0.839          0.954
##  5 ZEC        1        0.611     0.548             0.805          0.499
##  6 XEM        1        0.654     0.639             1.22           0.543
##  7 NEXO       1        1.22      0.0300            1.61           0.659
##  8 EOS        1        1.27      0.00328           0.473          0.917
##  9 ELF        1        0.626     0.611             0.693          0.796
## 10 BNT        1        1.64      0.823             1.35           0.926
## # … with 245 more rows
```
*Only the results for the linear regression model are shown. There are equivalent columns for the XGBoost, neural network, random forest and PCR models.*


## Evaluate Metrics Across Splits

Next, let's evaluate the metrics across all [**splits**]{style="color: blue;"} and keeping moving along with the [model validation plan as was originally outlined](#time-aware-cross-validation). Let's create a new dataset called [**cryptodata_metrics**][**splits**]{style="color: blue;"} that is not grouped by the [**split**]{style="color: blue;"} column and is instead only grouped by the [**symbol**]{style="color: blue;"}:


```r
cryptodata_metrics <- group_by(select(ungroup(cryptodata_nested),-split),symbol)
```

### Evaluate RMSE Test

Now for each model we can create a new column giving the average RMSE for the 4 cross-validation test splits:


```r
rmse_test <- mutate(cryptodata_metrics,
                      lm = mean(lm_rmse_test, na.rm = T),
                      xgb = mean(xgb_rmse_test, na.rm = T),
                      nnet = mean(nnet_rmse_test, na.rm = T),
                      rf = mean(rf_rmse_test, na.rm = T),
                      pcr = mean(pcr_rmse_test, na.rm = T))
```

Now we can use the [**gather()**]{style="color: green;"} function to summarize the columns as rows:


```r
rmse_test <- unique(gather(select(rmse_test, lm:pcr), 'model', 'rmse', -symbol))
# Show results
rmse_test
```

```
## # A tibble: 255 x 3
## # Groups:   symbol [51]
##    symbol model  rmse
##    <chr>  <chr> <dbl>
##  1 BTC    lm    0.384
##  2 LTC    lm    0.756
##  3 XMR    lm    0.851
##  4 ETH    lm    0.848
##  5 ZEC    lm    0.602
##  6 XEM    lm    1.07 
##  7 NEXO   lm    1.09 
##  8 EOS    lm    0.856
##  9 ELF    lm    0.669
## 10 BNT    lm    1.86 
## # … with 245 more rows
```

Now tag the results as having been for the test set:


```r
rmse_test$eval_set <- 'test'
```

### Holdout

Now repeat the same process for the holdout set:


```r
rmse_holdout <- mutate(cryptodata_metrics,
                      lm = mean(lm_rmse_holdout, na.rm = T),
                      xgb = mean(xgb_rmse_holdout, na.rm = T),
                      nnet = mean(nnet_rmse_holdout, na.rm = T),
                      rf = mean(rf_rmse_holdout, na.rm = T),
                      pcr = mean(pcr_rmse_holdout, na.rm = T))
```

Again, use the [**gather()**]{style="color: green;"} function to summarize the columns as rows:


```r
rmse_holdout <- unique(gather(select(rmse_holdout, lm:pcr), 'model', 'rmse', -symbol))
# Show results
rmse_holdout
```

```
## # A tibble: 255 x 3
## # Groups:   symbol [51]
##    symbol model  rmse
##    <chr>  <chr> <dbl>
##  1 BTC    lm    0.462
##  2 LTC    lm    0.763
##  3 XMR    lm    2.11 
##  4 ETH    lm    0.839
##  5 ZEC    lm    0.805
##  6 XEM    lm    1.22 
##  7 NEXO   lm    1.61 
##  8 EOS    lm    0.473
##  9 ELF    lm    0.693
## 10 BNT    lm    1.35 
## # … with 245 more rows
```

Now tag the results as having been for the holdout set:


```r
rmse_holdout$eval_set <- 'holdout'
```

### Union Results

Now we can [**union()**]{style="color: green;"} the results to stack the rows from the two datasets on top of each other:

```r
rmse_scores <- union(rmse_test, rmse_holdout)
```

## Evaluate R^2

Now let's repeat the same steps we took for the RMSE metrics above for the $R^2$ metric as well.

### Test

For each model again we will create a new column giving the average $R^2$ for the 4 cross-validation test splits:


```r
rsq_test <- mutate(cryptodata_metrics,
                      lm = mean(lm_rsq_test, na.rm = T),
                      xgb = mean(xgb_rsq_test, na.rm = T),
                      nnet = mean(nnet_rsq_test, na.rm = T),
                      rf = mean(rf_rsq_test, na.rm = T),
                      pcr = mean(pcr_rsq_test, na.rm = T))
```

Now we can use the [**gather()**]{style="color: green;"} function to summarize the columns as rows:


```r
rsq_test <- unique(gather(select(rsq_test, lm:pcr), 'model', 'rsq', -symbol))
# Show results
rsq_test
```

```
## # A tibble: 255 x 3
## # Groups:   symbol [51]
##    symbol model   rsq
##    <chr>  <chr> <dbl>
##  1 BTC    lm    0.727
##  2 LTC    lm    0.573
##  3 XMR    lm    0.736
##  4 ETH    lm    0.649
##  5 ZEC    lm    0.755
##  6 XEM    lm    0.724
##  7 NEXO   lm    0.474
##  8 EOS    lm    0.494
##  9 ELF    lm    0.700
## 10 BNT    lm    0.607
## # … with 245 more rows
```

Now tag the results as having been for the test set


```r
rsq_test$eval_set <- 'test'
```

### Holdout

Do the same and calculate the averages for the holdout sets:


```r
rsq_holdout <- mutate(cryptodata_metrics,
                      lm = mean(lm_rsq_holdout, na.rm = T),
                      xgb = mean(xgb_rsq_holdout, na.rm = T),
                      nnet = mean(nnet_rsq_holdout, na.rm = T),
                      rf = mean(rf_rsq_holdout, na.rm = T),
                      pcr = mean(pcr_rsq_holdout, na.rm = T))
```

Now we can use the [**gather()**]{style="color: green;"} function to summarize the columns as rows:


```r
rsq_holdout <- unique(gather(select(rsq_holdout, lm:pcr), 'model', 'rsq', -symbol))
# Show results
rsq_holdout
```

```
## # A tibble: 255 x 3
## # Groups:   symbol [51]
##    symbol model   rsq
##    <chr>  <chr> <dbl>
##  1 BTC    lm    0.947
##  2 LTC    lm    0.981
##  3 XMR    lm    0.611
##  4 ETH    lm    0.954
##  5 ZEC    lm    0.499
##  6 XEM    lm    0.543
##  7 NEXO   lm    0.659
##  8 EOS    lm    0.917
##  9 ELF    lm    0.796
## 10 BNT    lm    0.926
## # … with 245 more rows
```

Now tag the results as having been for the holdout set:


```r
rsq_holdout$eval_set <- 'holdout'
```

### Union Results


```r
rsq_scores <- union(rsq_test, rsq_holdout)
```

## Visualize Results {#visualize-results}

Now we can take the same tools we learned in the [Visualization section from earlier](#visualization) and visualize the results of the models.

### RMSE Visualization

<!-- [TODO - Can I compare test and holdout here?] -->

<!-- ```{r} -->

<!-- ggplot(rmse_scores, aes(x=split, y=rmse, color = model)) + -->

<!--   geom_boxplot() + -->

<!--   geom_point() + -->

<!--   ylim(c(0,50)) + -->

<!--   facet_wrap(~eval_set) -->

<!-- ``` -->

### Both

Now we have everything we need to use the two metrics to compare the results.

#### Join Datasets

First join the two objects [**rmse_scores**]{style="color: blue;"} and [**rsq_scores**]{style="color: blue;"} into the new object [**plot_scores]{style="color: blue;"}:


```r
plot_scores <- merge(rmse_scores, rsq_scores)
```

#### Plot Results

Now we can plot the results on a chart:


```r
ggplot(plot_scores, aes(x=rsq, y=rmse, color = model)) +
  geom_point() +
  ylim(c(0,10))
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-74-1.png" width="672" />

Running the same code wrapped in the [**ggplotly()**]{style="color: green;"} function from the [**plotly**]{style="color: #ae7b11;"} package (as we [have already done](#plotly)) we can make the chart interactive. Try hovering over the points on the chart with your mouse.


```r
ggplotly(ggplot(plot_scores, aes(x=rsq, y=rmse, color = model, symbol = symbol)) +
           geom_point() +
           ylim(c(0,10)),
         tooltip = c("model", "symbol", "rmse", "rsq"))
```

preserve5694f275f221563f

**The additional [**tooltip**]{style="color: blue;"} argument was passed to [**ggpltoly()**]{style="color: green;"} to specify the label when hovering over the individual points**.

### Results by the Cryptocurrency

We can use the [**facet_wrap()**]{style="color: green;"} function from [**ggplot2**]{style="color: #ae7b11;"} to create an individual chart for each cryptocurrency:


```r
ggplot(plot_scores, aes(x=rsq, y=rmse, color = model)) +
  geom_point() +
  geom_smooth() +
  ylim(c(0,10)) +
  facet_wrap(~symbol)
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-76-1.png" width="672" />

Every 12 hours once this document reaches this point, the results are saved to GitHub using the [**pins**]{style="color: #ae7b11;"} package (which we [used to read in the data at the start](#pull-the-data)), and a separate script running on a different server creates the complete dataset in our database over time. You won't be able to run the code shown below (nor do you have a reason to):


```r
# register board
board_register("github", repo = "predictcrypto/pins", token=pins_key)
# Add current date time
plot_scores$last_refreshed <- Sys.time()
# pin data
pin(plot_scores, board='github', name='crypto_tutorial_results_latest')
```

## Interactive Dashboard
Use the interactive app below to explore the results over time by the individual cryptocurrency. Use the filters on the left sidebar to visualize the results you are interested in:

<iframe src="https://predictcrypto.shinyapps.io/tutorial_latest_model_summary/?showcase=0" width="100%" height="600px"></iframe>

*If you have trouble viewing the embedded dashboard you can open it here instead: <https://predictcrypto.shinyapps.io/tutorial_latest_model_summary/>*

The default view shows the holdout results for all models. **Another interesting comparison to make is between the holdout and the test set for fewer models (2 is ideal)**.

\BeginKnitrBlock{infoicon}<div class="infoicon">The app shown above also has a button to **Show Code**. If you were to show the code and copy and paste it into an RStudio session on your computer into a file with the .Rmd file extension and you then *Knit* the file, the same exact app should show up on your computer, no logins or setup outside of the packages required for the code to run; RStudio should automatically prompt you to install packages that are not currently installed on your computer.</div>\EndKnitrBlock{infoicon}

<!-- TODO - NOT logging MLflow metrics here because needs Python install. Instead run them through R Studio Server. -->

## Visualizations - Historical Metrics

We can pull the same data into this R session using the `pin_get()` function:

```r
metrics_historical <- pin_get(name = "full_metrics")
```

The data is limited to metrics for runs from the past 30 days and includes new data every 12 hours. Using the tools we used in the [data prep section](#data-prep), we can answer a couple more questions.

### Best Models

**Overall**, which **model** has the best metrics for all runs from the last 30 days?

#### Summarize the data

```r
# First create grouped data
best_models <- group_by(metrics_historical, model, eval_set)
# Now summarize the data
best_models <- summarize(best_models,
                         rmse = mean(rmse, na.rm=T),
                         rsq  = mean(rsq, na.rm=T))
# Show results
best_models
```

```
## # A tibble: 10 x 4
## # Groups:   model [5]
##    model eval_set  rmse    rsq
##    <chr> <chr>    <dbl>  <dbl>
##  1 lm    holdout  17.3  0.534 
##  2 lm    test      8.61 0.490 
##  3 nnet  holdout   4.32 0.160 
##  4 nnet  test      3.78 0.187 
##  5 pcr   holdout   2.61 0.285 
##  6 pcr   test      2.17 0.305 
##  7 rf    holdout   3.28 0.137 
##  8 rf    test      3.27 0.140 
##  9 xgb   holdout   3.71 0.0869
## 10 xgb   test      3.67 0.0992
```

#### Plot RMSE by Model


```r
ggplot(best_models, aes(model, rmse, fill = eval_set)) + 
  geom_bar(stat = "identity", position = 'dodge') +
  ggtitle('RMSE by Model', 'Comparing Test and Holdout')
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-79-1.png" width="672" />


<!-- Plotly version: -->
<!-- ```{r plotly_accuracy_over_time} -->
<!-- ggplotly(ggplot(best_models, aes(model, rmse, fill = eval_set)) +  -->
<!--            geom_bar(stat = "identity", position = 'dodge') + -->
<!--            ggtitle('RMSE by Model', 'Comparing Test and Holdout') ) -->
<!-- ``` -->

#### Plot $R^2$ by Model


```r
ggplot(best_models, aes(model, rsq, fill = eval_set)) + 
  geom_bar(stat = "identity", position = 'dodge') +
  ggtitle('R^2 by Model', 'Comparing Test and Holdout')
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-80-1.png" width="672" />



### Most Predictable Cryptocurrency


<!-- [TODO - HERE FIND MOST (AND LEAST) PREDICTABLE CRYPTOCURRENCIES] -->

**Overall**, which **cryptocurrency** has the best metrics for all runs from the last 30 days?

#### Summarize the data

```r
# First create grouped data
predictable_cryptos <- group_by(metrics_historical, symbol, eval_set)
# Now summarize the data
predictable_cryptos <- summarize(predictable_cryptos,
                         rmse = mean(rmse, na.rm=T),
                         rsq  = mean(rsq, na.rm=T))
# Arrange from most predictable (according to R^2) to least 
predictable_cryptos <- arrange(predictable_cryptos, desc(rsq))
# Show results
predictable_cryptos
```

```{.scroll-lim}
## # A tibble: 132 x 4
## # Groups:   symbol [66]
##    symbol eval_set  rmse   rsq
##    <chr>  <chr>    <dbl> <dbl>
##  1 ICX    holdout  18.5  0.505
##  2 SYBC   test     17.3  0.474
##  3 LEO    test      2.31 0.446
##  4 RCN    holdout   1.53 0.405
##  5 RCN    test      3.40 0.400
##  6 QTUM   test      2.81 0.394
##  7 XUC    holdout  13.7  0.378
##  8 REX    holdout   3.92 0.378
##  9 BTC    holdout   1.32 0.372
## 10 VSYS   holdout   3.05 0.370
## # … with 122 more rows
```

<style type="text/css">
.scroll-100 {
  max-height: 100px;
  overflow-y: auto;
  background-color: inherit;
}
</style>

Show the top 15 most predictable cryptocurrencies (according to the $R^2$) using the `formattable` package [@R-formattable] to color code the cells:

```r
formattable(head(predictable_cryptos ,15), 
            list(rmse = color_tile("#71CA97", "red"),
                 rsq = color_tile("firebrick1", "#71CA97")))
```


<table class="table table-condensed">
 <thead>
  <tr>
   <th style="text-align:right;"> symbol </th>
   <th style="text-align:right;"> eval_set </th>
   <th style="text-align:right;"> rmse </th>
   <th style="text-align:right;"> rsq </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> ICX </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ff0000">18.460710</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #71ca97">0.5047455</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> SYBC </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f50d0a">17.307129</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #8aae84">0.4742285</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> LEO </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #79be8e">2.312984</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #a19573">0.4464591</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> RCN </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #72c795">1.534461</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #c3705a">0.4054836</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> RCN </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #82b184">3.401700</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #c86b57">0.3997117</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> QTUM </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #7db889">2.813093</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #cd6554">0.3940865</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> XUC </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d73829">13.698767</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #da574a">0.3784843</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> REX </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #86ab80">3.922976</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #da574a">0.3779996</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> BTC </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #71ca97">1.315971</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #df5146">0.3717990</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> VSYS </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #7fb587">3.049818</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #e15045">0.3703250</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> LEVL </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #97926d">6.003310</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #e54b42">0.3645880</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> CRV </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #929973">5.390609</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #e74840">0.3620290</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> LEVL </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #aa785a">8.201466</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #fa3433">0.3394951</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> PAXG </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #78bf8f">2.219924</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #fb3332">0.3380713</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> ETH </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #71c895">1.432630</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ff3030">0.3344292</span> </td>
  </tr>
</tbody>
</table>


### Accuracy Over Time

<!-- [TODO - HERE HAVE ACCURACY OVER TIME. TWO LINES, ONE FOR HOLDOUT AND ONE FOR TEST, AND DO RMSE FIRST AND THEN RSQ] -->

#### Summarize the data

```r
# First create grouped data
accuracy_over_time <- group_by(metrics_historical, date_utc)
# Now summarize the data
accuracy_over_time <- summarize(accuracy_over_time, 
                                rmse = mean(rmse, na.rm=T),
                                rsq  = mean(rsq, na.rm=T))
# Ungroup data
accuracy_over_time <- ungroup(accuracy_over_time)
# Show results
accuracy_over_time
```

```
## # A tibble: 30 x 3
##    date_utc    rmse   rsq
##    <chr>      <dbl> <dbl>
##  1 2020-12-07  8.54 0.245
##  2 2020-12-08 21.2  0.214
##  3 2020-12-09  3.30 0.246
##  4 2020-12-10  2.62 0.237
##  5 2020-12-11  2.39 0.258
##  6 2020-12-12  2.37 0.226
##  7 2020-12-13  2.49 0.219
##  8 2020-12-14  3.22 0.224
##  9 2020-12-15  4.82 0.254
## 10 2020-12-16  5.11 0.255
## # … with 20 more rows
```

#### Plot RMSE

<!-- [TODO - here is it better to facet_wrap by eval_set to compare test/holdout?] -->

Remember, for RMSE the lower the score, the more accurate the models were.


```r
ggplot(accuracy_over_time, aes(x = date_utc, y = rmse, group = 1)) +
  # Plot RMSE over time
  geom_point(color = 'red', size = 2) +
  geom_line(color = 'red', size = 1)
```

<img src="CryptoResearchPaper_files/figure-html/plot_accuracy_over_time_rmse-1.png" width="672" />

#### Plot R^2

For the R^2 recall that we are looking at the correlation between the predictions made and what actually happened, so the higher the score the better, with a maximum score of 1 that would mean the predictions were 100% correlated with each other and therefore identical.


```r
ggplot(accuracy_over_time, aes(x = date_utc, y = rsq, group = 1)) +
  # Plot R^2 over time
  geom_point(aes(x = date_utc, y = rsq), color = 'dark green', size = 2) +
  geom_line(aes(x = date_utc, y = rsq), color = 'dark green', size = 1)
```

<img src="CryptoResearchPaper_files/figure-html/plot_accuracy_over_time_rsq-1.png" width="672" />


[Refer back to the interactive dashboard](#interactive-dashboard) to take a more specific subset of results instead of the aggregate analysis shown above.


<!-- ## Making Predictions -->

<!-- Once we have used the information visualized in this section to determine which models we want to go ahead and use, we want to start thinking about how to make predictions on new data. -->

<!-- To make new predictions, we would start by pulling the newest data. Next we want to make sure the data has the exact same columns that were used to train the models minus the target variable which we will predict. We need to apply the exact same data preparation steps that were performed on the data to train the models to the new data in order to make new predictions. -->

<!-- We have omitted these steps to discourage people from performing real trades. Congratulations, you have made it all the way through all of the code! Learn more about why you should not attempt performing trades using the system outlined [in the next section](#considerations). -->



<!-- [TODO - HERE unnest data for holdout predictions and write the data to pins! From there pick up using RStudio Server script] -->

<!-- HIDDEN: Add new pin with actual predictions from holdout for true comparisons! -->


<!--chapter:end:07-EvaluateModelPerformance.Rmd-->

# Considerations

## Not a trading tutorial

In this document we aimed to predict the change in cryptocurrency prices, and **it is very important to recognize that this is not the same as being able to successfully make money trading on the cryptocurrency markets**. 

This is a very important distinction for the following reasons (and many more we have not thought of):

-   [We already covered some of the reasons for why there is a meaningful difference between predicting price movements for the cryptocurrency markets and actually performing effective trades in the data exploration section](#market-depth), but things are further complicated by the fact that trades can be posted as either a [**limit order**]{style="color: purple;"} or a [**market order**]{style="color: purple;"}. A limit order gets added to the order book after the trader specifies the price point and the quantity, while a market order initiates a trade with the most favorable price from the order book. This is why someone doing a limit order would be referred to as a [**market maker**]{style="color: purple;"}, while someone posting a market order would be consider to be a [**market taker**]{style="color: purple;"}; this indicates whether someone is **creating new liquidity** for the market, or are **taking from the available liquidity**, which has implications in terms of the fees that the exchange actually charges, because exchanges prefer encouring activity that results in more liquidity rather than less. See [this link for the latest specific maker and taker fees based on trading volume](https://hitbtc.com/fee-tier) and [more details on their rationale](https://hitbtc.com/fees-and-limits) (as was also explained here).

- There are **many** cryptocurrencies that have really low levels of liquidity, which can severely affect the ability to purchase the cryptocurrency at the desired price point and at the desired time. Simply put, things can get extraordinarily complex.

- When programmatically trading it is easy to make a single mistake that ends up being more costly than the potential upside of a successful trading system.

- Even if these models were at all accurate in predicting price changes, that would not necessarily indicate that future performance would be any good. **The data made available in this tutorial is very limited in scope and perspective**, and has no way of understanding more complex dynamics like world events and news coverage, which could very well have an effect on the prices.

- Finding an effective trading strategy is easier said than done. Even if we could be accurate in predicting these markets, there is no guarantee we would be able to translate those predictions into an effective trading strategy. There are many nuances (i.e. trading fees) to deal with and decisions to be made, coming up with a good trade execution plan that works consistently is **not easy**.

- Another thing we did not consider in this tutorial is the distinction between the price at which we could buy the cryptocurrency (the "ask" price), and the price at which we could sell it (the "bid" price). In our example we predicted where the ask price was headed rather than considering a specific trading dynamic. 

- One additional consideration to make, is that a good trading strategy would not only consider the beginning and ending points, but would make small adjustments based on how things are going over time, and that is another consideration that is not relevant to the approach we took because we are predicting price changes between those two points rather than coming up with a good trading strategy.


\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">Hopefully it is clear by now, but this tutorial is not meant to show anyone how to trade on the cryptocurrency markets, but rather encourage people to apply these tools to their own data problems, and that is the reason the tutorial stops here (also because we like not getting sued).</div>\EndKnitrBlock{rmdimportant}


## Session Information

Below is information relating to the specific R session that was run. If you are unable to reproduce these steps, you can find the correct version of the tools to install below. Otherwise follow the [instructions to run the code in the cloud](#run-in-the-cloud) instead.


```r
sessionInfo()
```

```
## R version 4.0.3 (2020-10-10)
## Platform: x86_64-apple-darwin17.0 (64-bit)
## Running under: macOS Catalina 10.15.7
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRblas.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
##  [1] stats4    grid      parallel  stats     graphics  grDevices utils    
##  [8] datasets  methods   base     
## 
## other attached packages:
##  [1] formattable_0.2.0.1 hydroGOF_0.4-0      pls_2.7-3          
##  [4] elasticnet_1.3      lars_1.2            deepnet_0.2        
##  [7] party_1.3-5         strucchange_1.5-2   sandwich_3.0-0     
## [10] zoo_1.8-8           modeltools_0.2-23   mvtnorm_1.1-1      
## [13] brnn_0.8            truncnorm_1.0-8     Formula_1.2-4      
## [16] xgboost_1.0.0.2     doParallel_1.0.15   iterators_1.0.12   
## [19] foreach_1.5.0       caret_6.0-86        lattice_0.20-38    
## [22] transformr_0.1.3    gganimate_1.0.5     ggforce_0.3.2      
## [25] ggpubr_0.4.0        plotly_4.9.2.1      ggthemes_4.2.0     
## [28] magick_2.5.0        av_0.5.1            gifski_0.8.6       
## [31] ggTimeSeries_1.0.1  anytime_0.3.7       tsibble_0.9.2      
## [34] forcats_0.5.0       stringr_1.4.0       dplyr_1.0.2        
## [37] purrr_0.3.4         readr_1.3.1         tidyr_1.1.1        
## [40] tibble_3.0.4        ggplot2_3.3.2       tidyverse_1.3.0    
## [43] jsonlite_1.7.1      httr_1.4.2          DT_0.15            
## [46] skimr_2.1           pins_0.4.0          pacman_0.5.1       
## [49] knitr_1.30          bookdown_0.21      
## 
## loaded via a namespace (and not attached):
##   [1] utf8_1.1.4           tidyselect_1.1.0     htmlwidgets_1.5.1   
##   [4] maptools_1.0-2       lpSolve_5.6.15       pROC_1.16.2         
##   [7] munsell_0.5.0        codetools_0.2-16     units_0.6-7         
##  [10] withr_2.3.0          colorspace_1.4-1     filelock_1.0.2      
##  [13] highr_0.8            rstudioapi_0.11      ggsignif_0.6.0      
##  [16] labeling_0.3         repr_1.1.0           polyclip_1.10-0     
##  [19] farver_2.0.3         vctrs_0.3.2          generics_0.0.2      
##  [22] TH.data_1.0-10       ipred_0.9-9          xfun_0.18           
##  [25] R6_2.4.1             reshape_0.8.8        assertthat_0.2.1    
##  [28] hydroTSM_0.6-0       scales_1.1.1         multcomp_1.4-15     
##  [31] nnet_7.3-12          gtable_0.3.0         timeDate_3043.102   
##  [34] rlang_0.4.7          splines_4.0.3        rstatix_0.6.0       
##  [37] lazyeval_0.2.2       ModelMetrics_1.2.2.2 broom_0.7.2         
##  [40] yaml_2.2.1           reshape2_1.4.3       abind_1.4-5         
##  [43] modelr_0.1.6         crosstalk_1.1.0.1    backports_1.1.6     
##  [46] tools_4.0.3          lava_1.6.7           gstat_2.0-6         
##  [49] ellipsis_0.3.1       Rcpp_1.0.4.6         plyr_1.8.6          
##  [52] base64enc_0.1-3      progress_1.2.2       classInt_0.4-3      
##  [55] prettyunits_1.1.1    rpart_4.1-15         haven_2.2.0         
##  [58] fs_1.4.1             magrittr_1.5         data.table_1.12.8   
##  [61] openxlsx_4.2.2       spacetime_1.2-3      reprex_0.3.0        
##  [64] matrixStats_0.57.0   hms_0.5.3            evaluate_0.14       
##  [67] rio_0.5.16           readxl_1.3.1         compiler_4.0.3      
##  [70] KernSmooth_2.23-16   crayon_1.3.4         htmltools_0.5.0     
##  [73] mgcv_1.8-31          libcoin_1.0-6        lubridate_1.7.8     
##  [76] DBI_1.1.0            tweenr_1.0.1         dbplyr_1.4.2        
##  [79] MASS_7.3-51.5        rappdirs_0.3.1       sf_0.9-6            
##  [82] Matrix_1.2-18        car_3.0-10           cli_2.0.2           
##  [85] gower_0.2.1          pkgconfig_2.0.3      coin_1.3-1          
##  [88] foreign_0.8-80       sp_1.4-1             recipes_0.1.14      
##  [91] xml2_1.3.1           prodlim_2019.11.13   rvest_0.3.5         
##  [94] digest_0.6.25        rmarkdown_2.5        cellranger_1.1.0    
##  [97] intervals_0.15.2     curl_4.3             lifecycle_0.2.0     
## [100] nlme_3.1-144         carData_3.0-4        viridisLite_0.3.0   
## [103] fansi_0.4.1          pillar_1.4.4         survival_3.1-8      
## [106] glue_1.4.1           xts_0.12.1           zip_2.0.4           
## [109] FNN_1.1.3            class_7.3-15         stringi_1.4.6       
## [112] automap_1.0-14       e1071_1.7-4
```

<!--chapter:end:08-Considerations.Rmd-->

# Archive

Below is an archive of this same document from different dates. By clicking on any of the links below you can view this same document as was published on a given date. 

## November 2020

[November 15th, 2020 - Night](https://5fb1e6effc84560009eb761b--researchpaper.netlify.app/)

[November 15th, 2020 - Morning](https://5fb13daca7ee8500082a9e87--researchpaper.netlify.app/)

[November 14th, 2020 - Night](https://5fb0e95719046d0007714fea--researchpaper.netlify.app/)

<!-- [November 10, 2020 - Morning](https://5fa98c019806070007a1948c--researchpaper.netlify.app/) -->

<!-- ## May 2020 -->
<!-- [May 23, 2020 - Morning](https://5ec910b25ba546000683ef75--researchpaper.netlify.app/) -->

<!-- [May 22, 2020 - Morning](https://5ec7bfda63f2680006dc7adb--researchpaper.netlify.app/) -->

<!-- [May 21, 2020 - Morning](https://5ec66e35e51006000702d6a6--researchpaper.netlify.app/) -->

<!-- [May 20, 2020 - Morning](https://5ec54d80a11b3100064e7032--researchpaper.netlify.app/) -->

<!-- [May 19, 2020 - Morning](https://5ec3ebd67cef13000653e8ec--researchpaper.netlify.app/) -->

<!-- [May 18, 2020 - Morning](https://5ec27a599a31b90007d45f5e--researchpaper.netlify.app/) -->


<!--chapter:end:09-Archive.Rmd-->

# References

## Document Format

The **bookdown** package [@R-bookdown] was used to produce this document, which was built on top of **R Markdown** [@R-rmarkdown] and **knitr** [@R-knitr].

- https://bookdown.org/

- https://rmarkdown.rstudio.com/

- https://yihui.org/knitr/




## Open Review Toolkit {#open-review-toolkit-ref}

Thanks to [Ben Marwick](https://github.com/benmarwick) for outlining how to use the [Open Review Toolkit](https://www.openreviewtoolkit.org/) in bookdown to collect feedback on the document: https://benmarwick.github.io/bookdown-ort/mods.html#open-review-block

## Visualization

- https://www.rayshader.com/

- https://ggplot2.tidyverse.org/

- https://www.data-imaginist.com/2019/the-ggforce-awakens-again/


## Predictive Modeling

- https://topepo.github.io/caret/available-models.html

### Time Series

- https://tidyverts.org/

## Evaluate Model Performance

- https://en.wikipedia.org/wiki/Root-mean-square_deviation

- https://medium.com/human-in-a-machine-world/mae-and-rmse-which-metric-is-better-e60ac3bde13d

- https://en.wikipedia.org/wiki/Coefficient_of_determination

## Additional Contributors

A big thank you to anyone who has left feedback to improve this document:

- [David Butler](https://github.com/nimisis) for [pointing out a typo](https://github.com/ries9112/cryptocurrencyresearch-org/pull/1)

## R Packages Used

<!--chapter:end:10-references.Rmd-->

