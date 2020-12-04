---
title: "Cryptocurrency Research"
date: 'Last Updated:<br/> 2020-12-04 14:28:11'
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

preserve12de9956c225ee9a

*Only the first 2,000 rows of the data are shown in the table above. There are 300000 rows in the actual full dataset. The latest data is from 2020-12-04 (UTC timezone).*

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
|pair           |         0|             1|   5|   9|     0|      226|          0|
|symbol         |         0|             1|   2|   6|     0|      226|          0|
|quote_currency |         0|             1|   3|   3|     0|        1|          0|
|pkDummy        |         0|             1|  13|  13|     0|     2783|          0|
|pkey           |         0|             1|  15|  19|     0|   299720|          0|


**Variable type: Date**

|skim_variable | n_missing| complete_rate|min        |max        |median     | n_unique|
|:-------------|---------:|-------------:|:----------|:----------|:----------|--------:|
|date          |         0|             1|2020-08-10 |2020-12-04 |2020-10-09 |      117|


**Variable type: numeric**

|skim_variable  | n_missing| complete_rate|      mean|         sd| p0|   p25|    p50|     p75|        p100|hist  |
|:--------------|---------:|-------------:|---------:|----------:|--:|-----:|------:|-------:|-----------:|:-----|
|ask_1_price    |         0|             1|    227.10|    1760.56|  0|  0.01|   0.05|    0.53|     29423.0|▇▁▁▁▁ |
|ask_1_quantity |         0|             1| 172616.61| 4606893.68|  0| 20.10| 440.00| 4157.05| 455776000.0|▇▁▁▁▁ |
|ask_2_price    |         0|             1|    227.35|    1761.51|  0|  0.01|   0.05|    0.54|     29441.8|▇▁▁▁▁ |
|ask_2_quantity |         0|             1| 187330.12| 4167047.92|  0| 21.62| 510.00| 6150.00| 459459000.0|▇▁▁▁▁ |
|ask_3_price    |         0|             1|    227.65|    1762.40|  0|  0.01|   0.06|    0.55|     29464.4|▇▁▁▁▁ |
|ask_3_quantity |         0|             1| 225287.13| 4492677.22|  0| 18.00| 460.00| 7510.00| 518082000.0|▇▁▁▁▁ |
|ask_4_price    |         0|             1|    227.92|    1763.44|  0|  0.01|   0.06|    0.56|     29476.3|▇▁▁▁▁ |
|ask_4_quantity |         0|             1| 235026.00| 4406315.34|  0| 15.10| 484.10| 8100.00| 546546000.0|▇▁▁▁▁ |
|ask_5_price    |         0|             1|    228.40|    1766.11|  0|  0.01|   0.06|    0.58|     29477.3|▇▁▁▁▁ |
|ask_5_quantity |         0|             1| 242552.95| 4712957.83|  0| 12.80| 444.43| 8790.00| 549312000.0|▇▁▁▁▁ |
|bid_1_price    |         0|             1|    225.26|    1755.36|  0|  0.00|   0.05|    0.47|     29400.0|▇▁▁▁▁ |
|bid_1_quantity |         0|             1| 147837.23| 2437046.53|  0| 20.00| 559.00| 6712.25| 296583000.0|▇▁▁▁▁ |
|bid_2_price    |         0|             1|    225.06|    1754.52|  0|  0.00|   0.04|    0.46|     29369.5|▇▁▁▁▁ |
|bid_2_quantity |         0|             1| 148973.40| 2730147.70|  0| 21.21| 500.00| 6181.27| 332190000.0|▇▁▁▁▁ |
|bid_3_price    |         0|             1|    224.77|    1753.59|  0|  0.00|   0.04|    0.46|     29355.8|▇▁▁▁▁ |
|bid_3_quantity |         0|             1| 204028.52| 3043673.31|  0| 14.37| 420.00| 6362.18| 347366000.0|▇▁▁▁▁ |
|bid_4_price    |         0|             1|    224.41|    1752.49|  0|  0.00|   0.04|    0.44|     29340.7|▇▁▁▁▁ |
|bid_4_quantity |         0|             1| 258290.39| 3438279.05|  0| 10.00| 400.00| 7426.00| 331285000.0|▇▁▁▁▁ |
|bid_5_price    |         0|             1|    223.97|    1750.96|  0|  0.00|   0.04|    0.42|     29311.3|▇▁▁▁▁ |
|bid_5_quantity |         0|             1| 307659.18| 4075563.80|  0| 10.00| 380.00| 8664.00| 384159000.0|▇▁▁▁▁ |


**Variable type: POSIXct**

|skim_variable | n_missing| complete_rate|min                 |max                 |median              | n_unique|
|:-------------|---------:|-------------:|:-------------------|:-------------------|:-------------------|--------:|
|date_time_utc |         0|             1|2020-08-10 04:29:09 |2020-12-04 14:03:39 |2020-10-09 13:03:01 |   255033|

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
## [1] "2020-12-04T14:28:35.088Z"
## 
## $batchingTime
## [1] "2020-12-04T14:28:35.119Z"
## 
## $ask
##     price   size
## 1 594.311 0.6000
## 2 594.312 0.3350
## 3 594.314 0.2350
## 4 594.321 0.2500
## 5 594.325 3.0000
## 
## $bid
##     price    size
## 1 594.048  0.6000
## 2 593.784  3.7500
## 3 593.783 30.0000
## 4 593.731  1.0200
## 5 593.698  3.3000
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
 


 
This step removed 0 rows from the data on the latest run (2020-12-04). The [**is.na()**]{style="color: green;"} function finds all cases where the [**date_time_utc**]{style="color: blue;"} field has a Null value. The function is preceded by the [**!**]{style="color: blue;"} operator, which tells the [**filter()**]{style="color: green;"} function to exclude these rows from the data.

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
## 1 BTC    2020-12-04 00:00:01   19413.             0.031       602. 
## 2 ETH    2020-12-04 00:00:01     616.             0.585       360. 
## 3 EOS    2020-12-04 00:00:02       3.07        1890          5808. 
## 4 LTC    2020-12-04 00:00:02      89.0            0.7          62.3
## 5 BSV    2020-12-04 00:00:04     171.             0.36         61.5
## 6 ADA    2020-12-04 00:00:04       0.164        220            36.1
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



This step removed 17439 rows on the latest run.


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
## 1 282561
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
## # A tibble: 224 x 2
## # Groups:   symbol [224]
##    symbol     n
##    <chr>  <int>
##  1 AAB     1389
##  2 ACAT    2341
##  3 ACT     2020
##  4 ADA     1679
##  5 ADX      386
##  6 ADXN     714
##  7 ALGO      39
##  8 AMB      606
##  9 AMM     1008
## 10 APL      694
## # … with 214 more rows
```

We can remove the grouping at any point by running the [**ungroup()**]{style="color: green;"} function:

```r
count(ungroup(cryptodata))
```

```
## # A tibble: 1 x 1
##        n
##    <int>
## 1 282561
```


### Remove symbols without enough rows

Because this dataset evolves over time, we will need to be proactive about issues that may arise even if they aren't currently a problem. 

What happens if a new cryptocurrency gets added to the cryptocurrency exchange? If we only had a couple days of data for an asset, not only would that not be enough information to build effective predictive models, but we may run into actual errors since the data will be further split into more groups to validate the results of the models against several datasets using [**cross validation**]{style="color: purple;"}, more to come on that later.

To ensure we have a reasonable amount of data for each individual cryptocurrency, let's filter out any cryptocurrencies that don't have at least 1,000 observations using the [**filter()**]{style="color: green;"} function:




```r
cryptodata <- filter(cryptodata, n() >= 1000)
```



The number of rows for the `cryptodata` dataset before the filtering step was 282561 and is now 237767. This step removed 96 cryptocurrencies from the analysis that did not have enough observations associated with them.

### Remove symbols without data from the last 3 days

If there was no data collected for a cryptocurrency over the last 3 day period, let's exclude that asset from the dataset since we are only looking to model data that is currently flowing through the process. If an asset is removed from the exchange (if a project is a scam for example) or is no longer being actively captured by the data collection process, we can't make new predictions for it, so might as well exclude these ahead of time as well.




```r
cryptodata <- filter(cryptodata, max(date) > Sys.Date()-3)
```



The number of rows for the `cryptodata` dataset before this filtering step was 225722 and is now 237767.

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
## # A tsibble: 225,487 x 34 [1h] <UTC>
## # Key:       symbol [118]
## # Groups:    symbol [118]
##    pair  symbol quote_currency ask_1_price ask_1_quantity ask_2_price
##    <chr> <chr>  <chr>                <dbl>          <dbl>       <dbl>
##  1 ACAT… ACAT   USD                0.00019         118300     0.00022
##  2 ACAT… ACAT   USD                0.00019         118300     0.00022
##  3 ACAT… ACAT   USD                0.00019         118300     0.00022
##  4 ACAT… ACAT   USD                0.00019         118300     0.00022
##  5 ACAT… ACAT   USD                0.00019         118300     0.00022
##  6 ACAT… ACAT   USD                0.00019         118300     0.00022
##  7 ACAT… ACAT   USD                0.00019         118300     0.00022
##  8 ACAT… ACAT   USD                0.00019         118300     0.00022
##  9 ACAT… ACAT   USD                0.00019         118300     0.00022
## 10 ACAT… ACAT   USD                0.00019         118300     0.00022
## # … with 225,477 more rows, and 28 more variables: ask_2_quantity <dbl>,
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



Now looking at the data again, there are 49673 additional rows that were added as implicitly missing in the data:


```r
cryptodata
```

```
## # A tsibble: 275,160 x 34 [1h] <UTC>
## # Key:       symbol [118]
## # Groups:    symbol [118]
##    pair  symbol quote_currency ask_1_price ask_1_quantity ask_2_price
##    <chr> <chr>  <chr>                <dbl>          <dbl>       <dbl>
##  1 ACAT… ACAT   USD                0.00019         118300     0.00022
##  2 ACAT… ACAT   USD                0.00019         118300     0.00022
##  3 ACAT… ACAT   USD                0.00019         118300     0.00022
##  4 ACAT… ACAT   USD                0.00019         118300     0.00022
##  5 ACAT… ACAT   USD                0.00019         118300     0.00022
##  6 ACAT… ACAT   USD                0.00019         118300     0.00022
##  7 ACAT… ACAT   USD                0.00019         118300     0.00022
##  8 ACAT… ACAT   USD                0.00019         118300     0.00022
##  9 ACAT… ACAT   USD                0.00019         118300     0.00022
## 10 ACAT… ACAT   USD                0.00019         118300     0.00022
## # … with 275,150 more rows, and 28 more variables: ask_2_quantity <dbl>,
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
## # A tibble: 2,795 x 6
## # Groups:   symbol [1]
##    symbol ts_index            price_usd lagged_price_1h lagged_price_24h
##    <chr>  <dttm>                  <dbl>           <dbl>            <dbl>
##  1 BTC    2020-08-10 04:00:00    11997.             NA               NA 
##  2 BTC    2020-08-10 05:00:00    11986.          11997.              NA 
##  3 BTC    2020-08-10 06:00:00    11973.          11986.              NA 
##  4 BTC    2020-08-10 07:00:00    11994.          11973.              NA 
##  5 BTC    2020-08-10 08:00:00    11984.          11994.              NA 
##  6 BTC    2020-08-10 09:00:00    11962.          11984.              NA 
##  7 BTC    2020-08-10 10:00:00    11989.          11962.              NA 
##  8 BTC    2020-08-10 11:00:00    11709.          11989.              NA 
##  9 BTC    2020-08-10 12:00:00    11721.          11709.              NA 
## 10 BTC    2020-08-10 13:00:00    11890.          11721.              NA 
## 11 BTC    2020-08-10 14:00:00    11908.          11890.              NA 
## 12 BTC    2020-08-10 15:00:00    11889.          11908.              NA 
## 13 BTC    2020-08-10 16:00:00    11918.          11889.              NA 
## 14 BTC    2020-08-10 17:00:00       NA           11918.              NA 
## 15 BTC    2020-08-10 18:00:00       NA              NA               NA 
## 16 BTC    2020-08-10 19:00:00       NA              NA               NA 
## 17 BTC    2020-08-10 20:00:00       NA              NA               NA 
## 18 BTC    2020-08-10 21:00:00       NA              NA               NA 
## 19 BTC    2020-08-10 22:00:00       NA              NA               NA 
## 20 BTC    2020-08-10 23:00:00       NA              NA               NA 
## 21 BTC    2020-08-11 00:00:00    11906.             NA               NA 
## 22 BTC    2020-08-11 01:00:00    11863.          11906.              NA 
## 23 BTC    2020-08-11 02:00:00    11901.          11863.              NA 
## 24 BTC    2020-08-11 03:00:00    11868.          11901.              NA 
## 25 BTC    2020-08-11 04:00:00    11840.          11868.           11997.
## 26 BTC    2020-08-11 05:00:00    11820.          11840.           11986.
## 27 BTC    2020-08-11 06:00:00    11847.          11820.           11973.
## 28 BTC    2020-08-11 07:00:00    11774.          11847.           11994.
## 29 BTC    2020-08-11 08:00:00    11761.          11774.           11984.
## 30 BTC    2020-08-11 09:00:00    11753.          11761.           11962.
## # … with 2,765 more rows, and 1 more variable: target_price_24h <dbl>
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
##  1 BTC    2020-12-03 09:00:00    19384.           19205.           19388.
##  2 BTC    2020-12-03 10:00:00    19361.           19036.           19353.
##  3 BTC    2020-12-03 11:00:00    19350.           19103.           18978.
##  4 BTC    2020-12-03 12:00:00    19395.           19127.           18835.
##  5 BTC    2020-12-03 13:00:00    19322.           18953.           19028.
##  6 BTC    2020-12-03 14:00:00    19281.           19128.           19009.
##  7 BTC    2020-12-03 15:00:00    19347.           18912.              NA 
##  8 BTC    2020-12-03 16:00:00    19537.           18889.              NA 
##  9 BTC    2020-12-03 17:00:00    19353.           18850.              NA 
## 10 BTC    2020-12-03 18:00:00    19297.           18973.              NA 
## 11 BTC    2020-12-03 19:00:00    19369.           19012.              NA 
## 12 BTC    2020-12-03 20:00:00    19410.           19101.              NA 
## 13 BTC    2020-12-03 21:00:00    19365.           19080.              NA 
## 14 BTC    2020-12-03 22:00:00    19428.           19142.              NA 
## 15 BTC    2020-12-03 23:00:00    19456.           19108.              NA 
## 16 BTC    2020-12-04 00:00:00    19413.           19206.              NA 
## 17 BTC    2020-12-04 01:00:00    19460.           19183.              NA 
## 18 BTC    2020-12-04 02:00:00    19322.           19019.              NA 
## 19 BTC    2020-12-04 03:00:00    19246.           19041.              NA 
## 20 BTC    2020-12-04 04:00:00    19157.           19087.              NA 
## 21 BTC    2020-12-04 05:00:00    19283.           19035.              NA 
## 22 BTC    2020-12-04 06:00:00    19193.           18919.              NA 
## 23 BTC    2020-12-04 07:00:00    19310.           18973.              NA 
## 24 BTC    2020-12-04 08:00:00    19285.           19210.              NA 
## 25 BTC    2020-12-04 09:00:00    19388.           19384.              NA 
## 26 BTC    2020-12-04 10:00:00    19353.           19361.              NA 
## 27 BTC    2020-12-04 11:00:00    18978.           19350.              NA 
## 28 BTC    2020-12-04 12:00:00    18835.           19395.              NA 
## 29 BTC    2020-12-04 13:00:00    19028.           19322.              NA 
## 30 BTC    2020-12-04 14:00:00    19009.           19281.              NA
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
##  1 BTC    2020-12-03 09:00:00    19384.           19205.           19388.
##  2 BTC    2020-12-03 10:00:00    19361.           19036.           19353.
##  3 BTC    2020-12-03 11:00:00    19350.           19103.           18978.
##  4 BTC    2020-12-03 12:00:00    19395.           19127.           18835.
##  5 BTC    2020-12-03 13:00:00    19322.           18953.           19028.
##  6 BTC    2020-12-03 14:00:00    19281.           19128.           19009.
##  7 BTC    2020-12-03 15:00:00    19347.           18912.              NA 
##  8 BTC    2020-12-03 16:00:00    19537.           18889.              NA 
##  9 BTC    2020-12-03 17:00:00    19353.           18850.              NA 
## 10 BTC    2020-12-03 18:00:00    19297.           18973.              NA 
## 11 BTC    2020-12-03 19:00:00    19369.           19012.              NA 
## 12 BTC    2020-12-03 20:00:00    19410.           19101.              NA 
## 13 BTC    2020-12-03 21:00:00    19365.           19080.              NA 
## 14 BTC    2020-12-03 22:00:00    19428.           19142.              NA 
## 15 BTC    2020-12-03 23:00:00    19456.           19108.              NA 
## 16 BTC    2020-12-04 00:00:00    19413.           19206.              NA 
## 17 BTC    2020-12-04 01:00:00    19460.           19183.              NA 
## 18 BTC    2020-12-04 02:00:00    19322.           19019.              NA 
## 19 BTC    2020-12-04 03:00:00    19246.           19041.              NA 
## 20 BTC    2020-12-04 04:00:00    19157.           19087.              NA 
## 21 BTC    2020-12-04 05:00:00    19283.           19035.              NA 
## 22 BTC    2020-12-04 06:00:00    19193.           18919.              NA 
## 23 BTC    2020-12-04 07:00:00    19310.           18973.              NA 
## 24 BTC    2020-12-04 08:00:00    19285.           19210.              NA 
## 25 BTC    2020-12-04 09:00:00    19388.           19384.              NA 
## 26 BTC    2020-12-04 10:00:00    19353.           19361.              NA 
## 27 BTC    2020-12-04 11:00:00    18978.           19350.              NA 
## 28 BTC    2020-12-04 12:00:00    18835.           19395.              NA 
## 29 BTC    2020-12-04 13:00:00    19028.           19322.              NA 
## 30 BTC    2020-12-04 14:00:00    19009.           19281.              NA
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



This step removed 49673 rows from the data. This step mainly helps us avoid issues when programmatically labeling charts in the next section, move on to the [next section](#visualization) ➡️ to learn some amazingly powerful tools to visualize data!


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

The most expensive cryptocurrency being shown, "YFI" in this case, makes it difficult to take a look at any of the other ones. Let's try *zooming-in* on a single one by using the same code but making an adjustment to the [**data**]{style="color: blue;"} parameter to only show data for the cryptocurrency with the symbol **ETH**.

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

preserve285096a15c40b224

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
## # A tibble: 225,487 x 3
## # Groups:   symbol [118]
##    symbol training split
##    <chr>  <chr>    <dbl>
##  1 EOS    train        1
##  2 BCH    train        1
##  3 POA20  train        1
##  4 NEO    train        1
##  5 IQ     train        1
##  6 EDG    train        1
##  7 LEO    train        1
##  8 STX    train        1
##  9 GBX    train        1
## 10 ACT    train        1
## # … with 225,477 more rows
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
## 1 BCH    holdout      5
## 2 DRT    holdout      5
## 3 PAXG   holdout      5
## 4 IHT    holdout      5
## 5 HTML   holdout      5
## 6 POA20  holdout      5
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
## # A tibble: 225,487 x 4
## # Groups:   symbol, split, training [1,180]
##    symbol split training   min_sd
##    <chr>  <dbl> <chr>       <dbl>
##  1 EOS        1 train    0.256   
##  2 BCH        1 train    9.50    
##  3 POA20      1 train    0.0250  
##  4 NEO        1 train    0.610   
##  5 IQ         1 train    0.0126  
##  6 EDG        1 train    0.000805
##  7 LEO        1 train    0.111   
##  8 STX        1 train    0.000552
##  9 GBX        1 train    0.00331 
## 10 ACT        1 train    0.00623 
## # … with 225,477 more rows
```

Next let's get to a list of cryptocurrency symbols where the minimum standard deviation across all columns for all splits of the data is 0, which is the list of cryptocurrencies we want to later remove from the data:

```r
minimum_sd <- filter(distinct(mutate(group_by(ungroup(find_zero_var), symbol),
                                     min_sd = min(min_sd, na.rm=T)), min_sd),min_sd < 0.0001)$symbol
# Show result
minimum_sd
```

```
##  [1] "POA20" "IQ"    "LEO"   "STX"   "ACT"   "EURS"  "MBL"   "ACAT"  "RCN"  
## [10] "FDZ"   "PXG"   "CVC"   "PAXG"  "MESH"  "REX"   "DRT"   "NAV"   "XDN"  
## [19] "CUR"   "DENT"  "IPL"   "XVG"   "APPC"  "NCT"   "HTML"  "ELEC"  "PMA"  
## [28] "IHT"   "CDT"   "COCOS" "SPC"   "SBD"   "GST"   "CND"   "BYTZ"  "SUB"  
## [37] "PLA"   "BTT"   "SMART" "MG"    "SWM"   "PHX"   "CUTE"  "BCN"   "CHZ"  
## [46] "SENT"  "BNK"   "CHAT"  "WIKI"  "ERK"   "NEU"   "XPR"   "BRDG"  "ECA"  
## [55] "DAPP"  "CKB"   "SEELE" "VSYS"  "CMCT"  "SYBC"
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
## # A tibble: 580 x 4
## # Groups:   symbol, training, split [580]
##    symbol training split data               
##    <chr>  <chr>    <dbl> <list>             
##  1 EOS    train        1 <tibble [437 × 11]>
##  2 BCH    train        1 <tibble [184 × 11]>
##  3 NEO    train        1 <tibble [184 × 11]>
##  4 EDG    train        1 <tibble [435 × 11]>
##  5 GBX    train        1 <tibble [272 × 11]>
##  6 BTG    train        1 <tibble [419 × 11]>
##  7 LINK   train        1 <tibble [306 × 11]>
##  8 VET    train        1 <tibble [392 × 11]>
##  9 IHF    train        1 <tibble [345 × 11]>
## 10 DGB    train        1 <tibble [444 × 11]>
## # … with 570 more rows
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
## # A tibble: 280 x 3
## # Groups:   symbol, split [280]
##    symbol split train_data         
##    <chr>  <dbl> <list>             
##  1 EOS        1 <tibble [351 × 11]>
##  2 BCH        1 <tibble [112 × 11]>
##  3 NEO        1 <tibble [112 × 11]>
##  4 EDG        1 <tibble [349 × 11]>
##  5 BTG        1 <tibble [327 × 11]>
##  6 VET        1 <tibble [312 × 11]>
##  7 IHF        1 <tibble [261 × 11]>
##  8 DGB        1 <tibble [358 × 11]>
##  9 XUC        1 <tibble [97 × 11]> 
## 10 LTC        1 <tibble [353 × 11]>
## # … with 270 more rows
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
## # A tibble: 232 x 3
## # Groups:   symbol, split [232]
##    symbol split test_data         
##    <chr>  <dbl> <list>            
##  1 XUC        1 <tibble [43 × 11]>
##  2 BCH        1 <tibble [46 × 11]>
##  3 NEO        1 <tibble [47 × 11]>
##  4 MKR        1 <tibble [46 × 11]>
##  5 XRP        1 <tibble [49 × 11]>
##  6 ICX        1 <tibble [45 × 11]>
##  7 GBX        1 <tibble [68 × 11]>
##  8 LINK       1 <tibble [77 × 11]>
##  9 NUT        1 <tibble [79 × 11]>
## 10 IHF        1 <tibble [87 × 11]>
## # … with 222 more rows
```

As well as the [**hoildout**]{style="color: blue;"} data to create the [**cryptodata_holdout**]{style="color: blue;"} object:


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
## # A tibble: 58 x 2
## # Groups:   symbol [58]
##    symbol holdout_data       
##    <chr>  <list>             
##  1 MKR    <tibble [49 × 11]> 
##  2 ICX    <tibble [45 × 11]> 
##  3 XRP    <tibble [52 × 11]> 
##  4 NUT    <tibble [81 × 11]> 
##  5 GBX    <tibble [72 × 11]> 
##  6 VET    <tibble [102 × 11]>
##  7 EDG    <tibble [111 × 11]>
##  8 LINK   <tibble [80 × 11]> 
##  9 AYA    <tibble [93 × 11]> 
## 10 REP    <tibble [96 × 11]> 
## # … with 48 more rows
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
## # A tibble: 280 x 4
## # Groups:   symbol, split [280]
##    symbol split train_data          test_data          
##    <chr>  <dbl> <list>              <list>             
##  1 EOS        1 <tibble [351 × 11]> <tibble [110 × 11]>
##  2 BCH        1 <tibble [112 × 11]> <tibble [46 × 11]> 
##  3 NEO        1 <tibble [112 × 11]> <tibble [47 × 11]> 
##  4 EDG        1 <tibble [349 × 11]> <tibble [109 × 11]>
##  5 BTG        1 <tibble [327 × 11]> <tibble [105 × 11]>
##  6 VET        1 <tibble [312 × 11]> <tibble [99 × 11]> 
##  7 IHF        1 <tibble [261 × 11]> <tibble [87 × 11]> 
##  8 DGB        1 <tibble [358 × 11]> <tibble [111 × 11]>
##  9 XUC        1 <tibble [97 × 11]>  <tibble [43 × 11]> 
## 10 LTC        1 <tibble [353 × 11]> <tibble [111 × 11]>
## # … with 270 more rows
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
## # A tibble: 280 x 5
## # Groups:   symbol, split [280]
##    symbol split train_data          test_data           holdout_data       
##    <chr>  <dbl> <list>              <list>              <list>             
##  1 EOS        1 <tibble [351 × 11]> <tibble [110 × 11]> <tibble [111 × 11]>
##  2 BCH        1 <tibble [112 × 11]> <tibble [46 × 11]>  <tibble [48 × 11]> 
##  3 NEO        1 <tibble [112 × 11]> <tibble [47 × 11]>  <tibble [47 × 11]> 
##  4 EDG        1 <tibble [349 × 11]> <tibble [109 × 11]> <tibble [111 × 11]>
##  5 BTG        1 <tibble [327 × 11]> <tibble [105 × 11]> <tibble [108 × 11]>
##  6 VET        1 <tibble [312 × 11]> <tibble [99 × 11]>  <tibble [102 × 11]>
##  7 IHF        1 <tibble [261 × 11]> <tibble [87 × 11]>  <tibble [90 × 11]> 
##  8 DGB        1 <tibble [358 × 11]> <tibble [111 × 11]> <tibble [114 × 11]>
##  9 XUC        1 <tibble [97 × 11]>  <tibble [43 × 11]>  <tibble [43 × 11]> 
## 10 LTC        1 <tibble [353 × 11]> <tibble [111 × 11]> <tibble [115 × 11]>
## # … with 270 more rows
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
##      (Intercept)        symbolARDR         symbolASP         symbolAVA  
##  2055.9031351437      0.0307044034      2.0386398929      0.1318817745  
##        symbolAYA         symbolBAT         symbolBCH         symbolBNT  
##    -2.5337493562     -2.3645010758     -4.6372092881     -2.0585795510  
##        symbolBRD         symbolBSV         symbolBTC         symbolBTG  
##    -1.8294593604      0.2945203146    199.4229593704     -2.0672190149  
##        symbolBTM         symbolCBC         symbolCRO        symbolCRPT  
##    -2.3474028100     -0.8511931897     -1.7760639602      1.7127938225  
##        symbolDCR         symbolDDR         symbolDGB         symbolEDG  
##    -2.2737705146      0.1445286048     -2.3736253890     -2.3973410452  
##        symbolELF         symbolENJ         symbolEOS         symbolETH  
##    -2.5456288800     -2.4084062457     -2.3334321498      5.7404315090  
##        symbolETP         symbolGBX          symbolHT         symbolICX  
##    -0.3822689241      1.8601319978     -2.2953741409     -6.3288375313  
##        symbolIHF         symbolIPX         symbolJST         symbolKMD  
##    -1.7836563736      0.2605996819      0.0300564607      0.0620835601  
##        symbolKNC        symbolLINK         symbolLTC        symbolMANA  
##     0.2496239752      1.5835249629     -1.5749652595     -1.0699113264  
##        symbolMKR         symbolNEO        symbolNEXO         symbolNUT  
##    -5.8174051148     -5.4884391143     -2.5442883783     -1.3463565382  
##        symbolOAX         symbolREP        symbolSOLO         symbolSRN  
##    -0.8566149242     -2.1479421505     -0.0891325735     -2.5403809963  
##      symbolSTORJ         symbolTRX         symbolVET         symbolVIB  
##    -4.2586265700     -0.7999002172     -0.0286849516     -1.1647801402  
##       symbolWAXP         symbolXEM         symbolXMR         symbolXNS  
##     0.0302406756     -2.4091044871     -0.9529895604     -3.2115766110  
##        symbolXRP         symbolXUC         symbolYFI         symbolZAP  
##    -4.9324291322     -5.3793487012    384.5916795486     -0.5975385667  
##        symbolZEC         symbolZRX     date_time_utc              date  
##    -0.1397638322     -0.8160131561     -0.0000009974     -0.0255046193  
##        price_usd   lagged_price_1h   lagged_price_2h   lagged_price_3h  
##     0.9983643621      0.0422104235      0.0597514475     -0.1150485651  
##  lagged_price_6h  lagged_price_12h  lagged_price_24h   lagged_price_3d  
##    -0.0258014033      0.1422470493     -0.1065800222     -0.0057265677  
##     trainingtest     trainingtrain             split  
##    -3.0245858006     -2.0669824801      6.4618547958
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
## # A tibble: 280 x 5
## # Groups:   symbol, split [280]
##    symbol split train_data          test_data           holdout_data       
##    <chr>  <dbl> <list>              <list>              <list>             
##  1 EOS        1 <tibble [351 × 11]> <tibble [110 × 11]> <tibble [111 × 11]>
##  2 BCH        1 <tibble [112 × 11]> <tibble [46 × 11]>  <tibble [48 × 11]> 
##  3 NEO        1 <tibble [112 × 11]> <tibble [47 × 11]>  <tibble [47 × 11]> 
##  4 EDG        1 <tibble [349 × 11]> <tibble [109 × 11]> <tibble [111 × 11]>
##  5 BTG        1 <tibble [327 × 11]> <tibble [105 × 11]> <tibble [108 × 11]>
##  6 VET        1 <tibble [312 × 11]> <tibble [99 × 11]>  <tibble [102 × 11]>
##  7 IHF        1 <tibble [261 × 11]> <tibble [87 × 11]>  <tibble [90 × 11]> 
##  8 DGB        1 <tibble [358 × 11]> <tibble [111 × 11]> <tibble [114 × 11]>
##  9 XUC        1 <tibble [97 × 11]>  <tibble [43 × 11]>  <tibble [43 × 11]> 
## 10 LTC        1 <tibble [353 × 11]> <tibble [111 × 11]> <tibble [115 × 11]>
## # … with 270 more rows
```

Because we are now dealing with a **nested dataframe**, performing operations on the individual nested datasets is not as straightforward. We could extract the individual elements out of the data using [[**indexing**]{style="color: purple;"}](https://rspatial.org/intr/4-indexing.html), for example we can return the first element of the column [**train_data**]{style="color: blue;"} by running this code:

```r
cryptodata_nested$train_data[[1]]
```

```
## # A tibble: 351 x 11
##    date_time_utc       date       price_usd target_price_24h lagged_price_1h
##    <dttm>              <date>         <dbl>            <dbl>           <dbl>
##  1 2020-08-13 04:00:09 2020-08-13      3.03             3.11            3.03
##  2 2020-08-13 05:00:10 2020-08-13      3.03             3.11            3.03
##  3 2020-08-13 06:00:09 2020-08-13      3.02             3.10            3.03
##  4 2020-08-13 07:00:09 2020-08-13      3.02             3.10            3.02
##  5 2020-08-13 08:00:09 2020-08-13      3.00             3.11            3.02
##  6 2020-08-13 09:00:09 2020-08-13      2.97             3.11            3.00
##  7 2020-08-13 10:00:08 2020-08-13      2.97             3.12            2.97
##  8 2020-08-13 11:00:09 2020-08-13      2.99             3.13            2.97
##  9 2020-08-13 12:00:09 2020-08-13      3.04             3.14            2.99
## 10 2020-08-13 13:00:09 2020-08-13      3.00             3.15            3.04
## # … with 341 more rows, and 6 more variables: lagged_price_2h <dbl>,
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
## # A tibble: 280 x 6
## # Groups:   symbol, split [280]
##    symbol split train_data         test_data          holdout_data      lm_model
##    <chr>  <dbl> <list>             <list>             <list>            <list>  
##  1 EOS        1 <tibble [351 × 11… <tibble [110 × 11… <tibble [111 × 1… <lm>    
##  2 BCH        1 <tibble [112 × 11… <tibble [46 × 11]> <tibble [48 × 11… <lm>    
##  3 NEO        1 <tibble [112 × 11… <tibble [47 × 11]> <tibble [47 × 11… <lm>    
##  4 EDG        1 <tibble [349 × 11… <tibble [109 × 11… <tibble [111 × 1… <lm>    
##  5 BTG        1 <tibble [327 × 11… <tibble [105 × 11… <tibble [108 × 1… <lm>    
##  6 VET        1 <tibble [312 × 11… <tibble [99 × 11]> <tibble [102 × 1… <lm>    
##  7 IHF        1 <tibble [261 × 11… <tibble [87 × 11]> <tibble [90 × 11… <lm>    
##  8 DGB        1 <tibble [358 × 11… <tibble [111 × 11… <tibble [114 × 1… <lm>    
##  9 XUC        1 <tibble [97 × 11]> <tibble [43 × 11]> <tibble [43 × 11… <lm>    
## 10 LTC        1 <tibble [353 × 11… <tibble [111 × 11… <tibble [115 × 1… <lm>    
## # … with 270 more rows
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
## # A tibble: 280 x 3
## # Groups:   symbol, split [280]
##    symbol split lm_model
##    <chr>  <dbl> <list>  
##  1 EOS        1 <train> 
##  2 BCH        1 <train> 
##  3 NEO        1 <train> 
##  4 EDG        1 <train> 
##  5 BTG        1 <train> 
##  6 VET        1 <train> 
##  7 IHF        1 <train> 
##  8 DGB        1 <train> 
##  9 XUC        1 <train> 
## 10 LTC        1 <train> 
## # … with 270 more rows
```

And we can view the summarized contents of the first trained model:

```r
cryptodata_nested$lm_model[[1]]
```

```
## Linear Regression 
## 
## 351 samples
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
## 3.360434 3.332827 3.319138 3.327154 3.324699 3.298231 3.291013 3.293427 
##        9       10       11       12       13       14       15       16 
## 3.295412 3.269600 3.249613 3.247438 3.267174 3.274701 3.281317 3.297895 
##       17       18       19       20       21       22       23       24 
## 3.301755 3.348518 3.311811 3.282256 3.316641 3.291105 3.284782 3.295961 
##       25       26       27       28       29       30       31       32 
## 3.292602 3.295538 3.299319 3.296407 3.313451 3.292701 3.283232 3.269168 
##       33       34       35       36       37       38       39       40 
## 3.282780 3.323031 3.328454 3.333030 3.323867 3.321386 3.315272 3.314202 
##       41       42       43       44       45       46       47       48 
## 3.290749 3.285805 3.304675 3.325381       NA 3.361119 3.355483 3.354159 
##       49       50       51       52       53       54       55       56 
## 3.391720 3.391172 3.395545 3.391442 3.385029 3.349740 3.389396 3.410974 
##       57       58       59       60       61       62       63       64 
## 3.389188 3.410256 3.401413 3.385641 3.380524 3.377546 3.379931 3.354804 
##       65       66       67       68       69       70       71       72 
## 3.348137 3.344999 3.354712 3.362361 3.360007 3.330077 3.322583 3.329916 
##       73       74       75       76       77       78       79       80 
## 3.329410 3.331456 3.327107 3.340207 3.332279 3.324526 3.320838 3.296075 
##       81       82       83       84       85       86       87       88 
## 3.275241 3.289658 3.296221 3.301583 3.318984 3.379712 3.388945 3.417108 
##       89       90       91       92       93       94       95       96 
## 3.422109 3.430898 3.443416 3.413433 3.430061 3.429253 3.431768 3.453890 
##       97       98       99      100      101      102      103      104 
## 3.486328 3.472351 3.491772 3.503134 3.547307 3.577302 3.578517 3.582138 
##      105      106      107      108      109      110 
## 3.572054 3.545452 3.540443 3.514091 3.535517 3.501994
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
## # A tibble: 280 x 4
## # Groups:   symbol, split [280]
##    symbol split lm_test_predictions lm_holdout_predictions
##    <chr>  <dbl> <list>              <list>                
##  1 EOS        1 <dbl [110]>         <dbl [111]>           
##  2 BCH        1 <dbl [46]>          <dbl [48]>            
##  3 NEO        1 <dbl [47]>          <dbl [47]>            
##  4 EDG        1 <dbl [109]>         <dbl [111]>           
##  5 BTG        1 <dbl [105]>         <dbl [108]>           
##  6 VET        1 <dbl [99]>          <dbl [102]>           
##  7 IHF        1 <dbl [87]>          <dbl [90]>            
##  8 DGB        1 <dbl [111]>         <dbl [114]>           
##  9 XUC        1 <dbl [43]>          <dbl [43]>            
## 10 LTC        1 <dbl [111]>         <dbl [115]>           
## # … with 270 more rows
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

The first row of the data is for the EOS cryptocurrency for the split number 1. For this row of data (and all others), we made predictions for the [**test_data**]{style="color: blue;"} using a linear regression model and saved the results in the [**lm_test_predictions**]{style="color: blue;"} column. The models were trained on the [**train_data**]{style="color: blue;"} and had not yet seen the results from the [**test_data**]{style="color: blue;"}, so how accurate was the model in its predictions on this data? 

### MAE

Each individual prediction can be compared to the observation of what actually happened, and for each prediction we can calculate the error between the two. We can then take all of the values for the error of the prediction relative to the actual observations, and summarize the performance as a [[**M**ean **A**bsolute **Error**]{style="color: purple;"}](https://en.wikipedia.org/wiki/Mean_absolute_error) (MAE) of those values, which gives us a single value to use as an indicator of the accuracy of the model. The higher the MAE score, the higher the error, meaning the model performs worse when the value is larger.

### RMSE

A common metric to evaluate the performance of a model is the [**R**oot **M**ean **S**quare **E**rror](https://en.wikipedia.org/wiki/Root-mean-square_deviation), which is similar to the MAE but squares and then takes the square root of the values. An interesting implication of this, is that the RMSE will always be larger or equal to the MAE, where a large degree of error on a single observation would get penalized more by the RMSE. The higher the RMSE value, the worse the performance of the model, and can range from 0 to infinity, meaning there is no defined limit on the amount of error you could have (unlike the next metric).

### R Squared

The [**$R^2$**]{style="color: purple;"}, also known as the [**coefficient of determination**]{style="color: purple;"}, is a measure that describes the strength in the correlation between the predictions made and the actual results. A value of 1.0 would mean that the predictions made were exactly identical to the actual results. A perfect score is usually concerning because even a great model shouldn't be exactly 100% accurate and usually indicates a mistake was made that gave away the results to the model and would not perform nearly as good when put into practice in the real world, but in the case of the $R^2$ the higher the score (from 0 to 1) the better.


### Get Metrics

We can return the RMSE and $R^2$ metrics for the EOS cryptocurrency and the split number 1 by using the [**postResample()**]{style="color: green;"} function from the [**caret**]{style="color: #ae7b11;"} package:


```r
postResample(pred = cryptodata_nested$lm_test_predictions[[1]], 
             obs = cryptodata_nested$test_data[[1]]$target_price_24h)
```

```
##      RMSE  Rsquared       MAE 
## 0.2070067 0.1836430 0.1576146
```

We can extract the first element to return the **RMSE** metric, and the second element for the **R Squared (R\^2)** metric. We are using **`[[1]]`** to extract the first element of the [**lm\_test\_predictions**]{style="color: blue;"} and [**test\_data**]{style="color: blue;"} and compare the predictions to the actual value of the [**target\_price24h**]{style="color: blue;"} column.

This model used the earliest subset of the data available for the  cryptocurrency. How does the same model used to predict this older subset of the data perform when applied to the most recent subset of the data from the **holdout**?

We can get the same summary of results comparing the [**lm_holdout_predictions**]{style="color: blue;"} to what actually happened to the [**target_price_24h**]{style="color: blue;"} column of the actual [**holdout_data**]{style="color: blue;"}:


```r
postResample(pred = cryptodata_nested$lm_holdout_predictions[[1]], 
             obs = cryptodata_nested$holdout_data[[1]]$target_price_24h)
```

```
##         RMSE     Rsquared          MAE 
##           NA 0.0003511957           NA
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
## [1] 0.7835633
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
## # A tibble: 280 x 4
## # Groups:   symbol, split [280]
##    symbol split lm_rsq_test lm_rsq_holdout
##    <chr>  <dbl>       <dbl>          <dbl>
##  1 EOS        1    0.622             0.860
##  2 BCH        1    0.0854           NA    
##  3 NEO        1    0.0536           NA    
##  4 EDG        1    0.761             0.367
##  5 BTG        1    0.882             0.477
##  6 VET        1    0.146             1    
##  7 IHF        1    0.000876          0.635
##  8 DGB        1    0.892             0.743
##  9 XUC        1    0.459            NA    
## 10 LTC        1    0.600             0.844
## # … with 270 more rows
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
## # A tibble: 280 x 6
## # Groups:   symbol, split [280]
##     symbol split lm_rmse_test lm_rmse_holdout lm_rsq_test lm_rsq_holdout
##     <chr>  <dbl>        <dbl>           <dbl>       <dbl>          <dbl>
##   1 EOS        1        0.784          0.453     0.622           0.860  
##   2 BCH        1        1.79         NaN         0.0854         NA      
##   3 NEO        1        1.89         NaN         0.0536         NA      
##   4 EDG        1        6.59          12.8       0.761           0.367  
##   5 BTG        1        0.325          1.03      0.882           0.477  
##   6 VET        1        1.28           9.68      0.146           1      
##   7 IHF        1        0.735          1.27      0.000876        0.635  
##   8 DGB        1        0.583          0.670     0.892           0.743  
##   9 XUC        1        1.50         NaN         0.459          NA      
##  10 LTC        1        0.521          0.733     0.600           0.844  
##  11 NUT        1        1.12           0.0379    0.597          NA      
##  12 NEXO       1        1.86           1.07      0.203           0.852  
##  13 XMR        1        0.384          0.537     0.839           0.829  
##  14 SRN        1        1.49           6.42      0.0943          0.217  
##  15 VIB        1        0.749          2.58      0.393           0.405  
##  16 XNS        1        3.95          11.6       0.00201         0.504  
##  17 REP        1        0.831          0.596     0.529           0.757  
##  18 AYA        1        3.84           1.43      0.00625         0.673  
##  19 BAT        1        0.825          0.748     0.891           0.675  
##  20 BTC        1        0.272          0.377     0.586           0.848  
##  21 DCR        1        0.545          1.87      0.843           0.903  
##  22 XRP        1        0.976          1.72      0.338           0.997  
##  23 STORJ      1        3.65           1.54      0.294           0.0384 
##  24 ENJ        1        0.686          1.23      0.727           0.395  
##  25 XEM        1        1.84           0.788     0.873           0.948  
##  26 HT         1        0.433          0.175     0.362           0.956  
##  27 ICX        1        1.28           5.87      0.00917         0.790  
##  28 BTM        1        2.99           0.602     0.202           0.499  
##  29 MKR        1        0.903          2.05      0.435           0.794  
##  30 BRD        1        2.41           2.17      0.893           0.00233
##  31 XUC        2        2.78         NaN         0.574          NA      
##  32 BCH        2        0.623        NaN         0.142          NA      
##  33 NEO        2        2.83         NaN         0.294          NA      
##  34 MKR        2        0.509          2.05      0.313           0.794  
##  35 ICX        2        1.61           5.87      0.0819          0.790  
##  36 XRP        2        0.396          1.72      0.842           0.997  
##  37 ZEC        1        1.65           0.938     0.0129          0.404  
##  38 NUT        2        2.16           0.0379    0.000134       NA      
##  39 IHF        2        0.405          1.27      0.960           0.635  
##  40 VIB        2        2.52           2.58      0.337           0.405  
##  41 MKR        3        4.28           2.05      0.149           0.794  
##  42 BCH        3        1.51         NaN         0.209          NA      
##  43 NEO        3        2.03         NaN         0.00846        NA      
##  44 XUC        3        7.45         NaN         0.00155        NA      
##  45 REP        2        0.455          0.596     0.740           0.757  
##  46 ICX        3        1.63           5.87      0.124           0.790  
##  47 AYA        2        0.960          1.43      0.0959          0.673  
##  48 XRP        3        0.664          1.72      0.311           0.997  
##  49 VET        2        1.33           9.68      0.629           1      
##  50 BTG        2        0.944          1.03      0.417           0.477  
##  51 XEM        2        0.814          0.788     0.816           0.948  
##  52 EDG        2       37.1           12.8       0.0304          0.367  
##  53 HT         2        0.389          0.175     0.813           0.956  
##  54 EOS        2        0.822          0.453     0.161           0.860  
##  55 ENJ        2        3.05           1.23      0.269           0.395  
##  56 DGB        2        1.16           0.670     0.826           0.743  
##  57 NEXO       2        0.691          1.07      0.692           0.852  
##  58 LTC        2        0.807          0.733     0.0139          0.844  
##  59 XMR        2        0.885          0.537     0.182           0.829  
##  60 SRN        2        2.01           6.42      0.775           0.217  
##  61 BAT        2        0.954          0.748     0.253           0.675  
##  62 BTC        2        0.396          0.377     0.404           0.848  
##  63 DCR        2        1.60           1.87      0.0264          0.903  
##  64 STORJ      2        3.20           1.54      0.0629          0.0384 
##  65 XNS        2        1.53          11.6       0.957           0.504  
##  66 BRD        2        2.89           2.17      0.0244          0.00233
##  67 MKR        4        0.812          2.05      0.446           0.794  
##  68 XUC        4        2.25         NaN         0.995          NA      
##  69 BCH        4        1.14         NaN         0.0223         NA      
##  70 NEO        4        1.55         NaN         0.720          NA      
##  71 ICX        4        1.72           5.87      0.0388          0.790  
##  72 CBC        1        5.33           3.40      0.0916          0.228  
##  73 ETH        1        1.32           1.03      0.00149         0.621  
##  74 BNT        1        2.92           0.682     0.000106        0.629  
##  75 MANA       1        1.46           1.04      0.130           0.666  
##  76 OAX        1        3.39           2.47      0.148           0.612  
##  77 ZRX        1        1.11           0.814     0.320           0.692  
##  78 TRX        1        0.707          0.857     0.909           0.763  
##  79 BSV        1        0.584          0.357     0.325           0.969  
##  80 ETP        1        1.95           1.09      0.00637         0.464  
##  81 CRO        1        0.595          0.643     0.283           0.779  
##  82 ELF        1        1.94           1.81      0.0797          0.551  
##  83 BTM        2        1.91           0.602     0.264           0.499  
##  84 NUT        3        0.500          0.0379    0.00547        NA      
##  85 VIB        3        1.07           2.58      0.197           0.405  
##  86 MKR        5       NA              2.05     NA               0.794  
##  87 ICX        5       NA              5.87     NA               0.790  
##  88 BCH        5       NA            NaN        NA              NA      
##  89 NEO        5       NA            NaN        NA              NA      
##  90 XUC        5       NA            NaN        NA              NA      
##  91 VET        3        0.623          9.68      0.853           1      
##  92 ZEC        2        0.782          0.938     0.287           0.404  
##  93 BTG        3        0.255          1.03      0.850           0.477  
##  94 XEM        3        0.839          0.788     0.226           0.948  
##  95 SRN        3       12.4            6.42      0.0411          0.217  
##  96 EDG        3       28.7           12.8       0.203           0.367  
##  97 HT         3        0.588          0.175     0.124           0.956  
##  98 EOS        3        0.363          0.453     0.245           0.860  
##  99 CRO        2        0.205          0.643     1               0.779  
## 100 ETH        2      NaN              1.03     NA               0.621  
## 101 ADA        1        0.664          1.26      0.435           0.168  
## 102 ARDR       1        0.772          0.849     0.344           0.693  
## 103 SOLO       1        1.02           2.26      0.0653          0.180  
## 104 WAXP       1        0.593          0.883     0.0805          0.485  
## 105 ZAP        1        3.68          72.3       0.0901          0.156  
## 106 IPX        1        7.14           7.35      0.0656          0.00388
## 107 KNC        1        1.11           2.63      0.202           0.0227 
## 108 KMD        1        2.35           0.851     0.327           0.390  
## 109 JST        1        4.19           2.31      0.393           0.0362 
## 110 AVA        1        1.76           1.14      0.0644          0.161  
## 111 CRPT       1        3.54           6.12      0.312           0.0431 
## 112 BNT        2        4.14           0.682     0.000481        0.629  
## 113 DDR        1        3.69           2.83      0.924           0.0991 
## 114 ENJ        3        5.10           1.23      0.232           0.395  
## 115 DGB        3        1.16           0.670     0.609           0.743  
## 116 XMR        3        0.676          0.537     0.198           0.829  
## 117 BAT        3        1.19           0.748     0.742           0.675  
## 118 LTC        3        0.413          0.733     0.813           0.844  
## 119 BTC        3        0.158          0.377     0.786           0.848  
## 120 NEXO       3        1.50           1.07      0.603           0.852  
## 121 XRP        4        1.16           1.72      0.353           0.997  
## 122 CBC        2        4.48           3.40      0.235           0.228  
## 123 TRX        2        0.670          0.857     0.151           0.763  
## 124 OAX        2        1.39           2.47      0.000315        0.612  
## 125 BSV        2        0.752          0.357     0.563           0.969  
## 126 ETP        2        1.07           1.09      0.379           0.464  
## 127 DCR        3        0.519          1.87      0.809           0.903  
## 128 MANA       2        0.451          1.04      0.786           0.666  
## 129 ZRX        2        0.711          0.814     0.475           0.692  
## 130 ELF        2        2.17           1.81      0.817           0.551  
## 131 NUT        4        1.31           0.0379    0.832          NA      
## 132 STORJ      3        1.76           1.54      0.505           0.0384 
## 133 BTM        3        0.605          0.602     0.540           0.499  
## 134 IHF        3        0.133          1.27      0.188           0.635  
## 135 REP        3        0.369          0.596     0.653           0.757  
## 136 AYA        3       23.5            1.43      0.897           0.673  
## 137 YFI        1        0.877          2.43      0.794           0.00390
## 138 XRP        5       NA              1.72     NA               0.997  
## 139 ZAP        2        2.31          72.3       0.792           0.156  
## 140 IPX        2        0.925          7.35      0.00111         0.00388
## 141 VIB        4        7.34           2.58      0.000301        0.405  
## 142 DDR        2        4.08           2.83      0.840           0.0991 
## 143 CRPT       2        4.34           6.12     NA               0.0431 
## 144 SOLO       2        0.864          2.26      0.229           0.180  
## 145 KNC        2        0.753          2.63      0.792           0.0227 
## 146 AVA        2        3.19           1.14      0.412           0.161  
## 147 BRD        3        5.40           2.17      0.00655         0.00233
## 148 ARDR       2        1.35           0.849     0.374           0.693  
## 149 WAXP       2        0.883          0.883     0.141           0.485  
## 150 JST        2        0.640          2.31      0.447           0.0362 
## 151 ADA        2        0.884          1.26      0.378           0.168  
## 152 KMD        2        0.811          0.851     0.761           0.390  
## 153 XNS        3        7.06          11.6       0.874           0.504  
## 154 VET        4        1.04           9.68      0.910           1      
## 155 CBC        3       15.4            3.40      0.0739          0.228  
## 156 TRX        3        0.338          0.857     0.760           0.763  
## 157 OAX        3       20.9            2.47      0.0333          0.612  
## 158 MANA       3        0.562          1.04      0.854           0.666  
## 159 ETP        3        0.659          1.09      0.889           0.464  
## 160 ZRX        3        0.949          0.814     0.749           0.692  
## 161 BSV        3        0.572          0.357     0.652           0.969  
## 162 BNT        3        2.08           0.682     0.239           0.629  
## 163 CRO        3        0.943          0.643     0.389           0.779  
## 164 ETH        3        0.782          1.03      0.0808          0.621  
## 165 YFI        2        2.24           2.43      0.288           0.00390
## 166 EDG        4       12.2           12.8       0.207           0.367  
## 167 SRN        4        2.13           6.42      0.146           0.217  
## 168 NUT        5       NA              0.0379   NA              NA      
## 169 ELF        3        0.335          1.81      0.957           0.551  
## 170 DGB        4        1.18           0.670     0.417           0.743  
## 171 BAT        4        0.629          0.748     0.734           0.675  
## 172 LTC        4        0.295          0.733     0.927           0.844  
## 173 ENJ        4        1.19           1.23      0.396           0.395  
## 174 XMR        4        0.651          0.537     0.716           0.829  
## 175 BTC        4        0.263          0.377     0.851           0.848  
## 176 EOS        4        0.252          0.453     0.816           0.860  
## 177 NEXO       4        0.633          1.07      0.745           0.852  
## 178 DCR        4        0.537          1.87      0.816           0.903  
## 179 HT         4        0.433          0.175     0.822           0.956  
## 180 ASP        1       73.3            4.62      0.847           0.245  
## 181 BTG        4        0.388          1.03      0.606           0.477  
## 182 IHF        4        2.19           1.27      0.000115        0.635  
## 183 XEM        4        0.769          0.788     0.760           0.948  
## 184 DDR        3       10.6            2.83      0.0662          0.0991 
## 185 IPX        3        6.16           7.35      0.00105         0.00388
## 186 SOLO       3        5.12           2.26      0.166           0.180  
## 187 CRPT       3        0.339          6.12      0.814           0.0431 
## 188 ARDR       3        0.893          0.849     0.480           0.693  
## 189 WAXP       3        1.45           0.883     0.00280         0.485  
## 190 JST        3        1.74           2.31      0.0558          0.0362 
## 191 ADA        3        1.25           1.26      0.600           0.168  
## 192 KNC        3        1.58           2.63      0.0341          0.0227 
## 193 AVA        3       23.1            1.14      0.277           0.161  
## 194 ZAP        3        4.64          72.3       0.709           0.156  
## 195 KMD        3        1.14           0.851     0.590           0.390  
## 196 REP        4        1.36           0.596     0.00728         0.757  
## 197 ZEC        3        0.847          0.938     0.925           0.404  
## 198 AYA        4        1.79           1.43      0.697           0.673  
## 199 STORJ      4        0.735          1.54      0.895           0.0384 
## 200 XNS        4       10.2           11.6       0.106           0.504  
## 201 BTM        4        0.869          0.602     0.395           0.499  
## 202 BRD        4        1.09           2.17      0.269           0.00233
## 203 YFI        3        9.43           2.43      0.171           0.00390
## 204 ASP        2       38.4            4.62      0.237           0.245  
## 205 CBC        4        3.17           3.40      0.113           0.228  
## 206 ETP        4        1.09           1.09      0.791           0.464  
## 207 ZRX        4        0.516          0.814     0.541           0.692  
## 208 OAX        4        1.90           2.47      0.0308          0.612  
## 209 BSV        4        0.414          0.357     0.409           0.969  
## 210 MANA       4        0.546          1.04      0.935           0.666  
## 211 TRX        4        0.531          0.857     0.656           0.763  
## 212 CRO        4        1.07           0.643     0.182           0.779  
## 213 BNT        4        1.21           0.682     0.916           0.629  
## 214 ETH        4        0.436          1.03      0.850           0.621  
## 215 ELF        4        0.279          1.81      0.880           0.551  
## 216 VIB        5       NA              2.58     NA               0.405  
## 217 DDR        4      192.             2.83      0.000293        0.0991 
## 218 IPX        4        1.72           7.35      0.0113          0.00388
## 219 SOLO       4        0.938          2.26      0.794           0.180  
## 220 CRPT       4        1.60           6.12      0.434           0.0431 
## 221 VET        5       NA              9.68     NA               1      
## 222 ARDR       4        1.02           0.849     0.000489        0.693  
## 223 WAXP       4        0.723          0.883     0.642           0.485  
## 224 JST        4        2.52           2.31      0.181           0.0362 
## 225 ZAP        4        2.97          72.3       0.293           0.156  
## 226 ADA        4        1.15           1.26      0.000164        0.168  
## 227 KNC        4        1.21           2.63      0.137           0.0227 
## 228 KMD        4        1.32           0.851     0.457           0.390  
## 229 AVA        4        2.59           1.14      0.00490         0.161  
## 230 ASP        3        1.85           4.62      0.379           0.245  
## 231 ZEC        4        1.32           0.938     0.0212          0.404  
## 232 EDG        5       NA             12.8      NA               0.367  
## 233 YFI        4        2.38           2.43      0.823           0.00390
## 234 BAT        5       NA              0.748    NA               0.675  
## 235 DGB        5       NA              0.670    NA               0.743  
## 236 LTC        5       NA              0.733    NA               0.844  
## 237 BTC        5       NA              0.377    NA               0.848  
## 238 NEXO       5       NA              1.07     NA               0.852  
## 239 XMR        5       NA              0.537    NA               0.829  
## 240 DCR        5       NA              1.87     NA               0.903  
## 241 ENJ        5       NA              1.23     NA               0.395  
## 242 EOS        5       NA              0.453    NA               0.860  
## 243 HT         5       NA              0.175    NA               0.956  
## 244 XEM        5       NA              0.788    NA               0.948  
## 245 BTG        5       NA              1.03     NA               0.477  
## 246 SRN        5       NA              6.42     NA               0.217  
## 247 REP        5       NA              0.596    NA               0.757  
## 248 AYA        5       NA              1.43     NA               0.673  
## 249 IHF        5       NA              1.27     NA               0.635  
## 250 STORJ      5       NA              1.54     NA               0.0384 
## 251 CBC        5       NA              3.40     NA               0.228  
## 252 BTM        5       NA              0.602    NA               0.499  
## 253 XNS        5       NA             11.6      NA               0.504  
## 254 BRD        5       NA              2.17     NA               0.00233
## 255 ASP        4        1.80           4.62      0.554           0.245  
## 256 ETP        5       NA              1.09     NA               0.464  
## 257 ZRX        5       NA              0.814    NA               0.692  
## 258 OAX        5       NA              2.47     NA               0.612  
## 259 BSV        5       NA              0.357    NA               0.969  
## 260 MANA       5       NA              1.04     NA               0.666  
## 261 TRX        5       NA              0.857    NA               0.763  
## 262 BNT        5       NA              0.682    NA               0.629  
## 263 ETH        5       NA              1.03     NA               0.621  
## 264 CRO        5       NA              0.643    NA               0.779  
## 265 SOLO       5       NA              2.26     NA               0.180  
## 266 ELF        5       NA              1.81     NA               0.551  
## 267 IPX        5       NA              7.35     NA               0.00388
## 268 ZAP        5       NA             72.3      NA               0.156  
## 269 DDR        5       NA              2.83     NA               0.0991 
## 270 CRPT       5       NA              6.12     NA               0.0431 
## 271 KNC        5       NA              2.63     NA               0.0227 
## 272 ARDR       5       NA              0.849    NA               0.693  
## 273 WAXP       5       NA              0.883    NA               0.485  
## 274 JST        5       NA              2.31     NA               0.0362 
## 275 ADA        5       NA              1.26     NA               0.168  
## 276 KMD        5       NA              0.851    NA               0.390  
## 277 AVA        5       NA              1.14     NA               0.161  
## 278 ZEC        5       NA              0.938    NA               0.404  
## 279 YFI        5       NA              2.43     NA               0.00390
## 280 ASP        5       NA              4.62     NA               0.245
```

Out of 280 groups, 94 had an equal or lower RMSE score for the holdout than the test set.


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
## # A tibble: 280 x 6
## # Groups:   symbol, split [280]
##    symbol split lm_rmse_test lm_rsq_test lm_rmse_holdout lm_rsq_holdout
##    <chr>  <dbl>        <dbl>       <dbl>           <dbl>          <dbl>
##  1 EOS        1        0.784    0.622              0.453          0.860
##  2 BCH        1        1.79     0.0854           NaN             NA    
##  3 NEO        1        1.89     0.0536           NaN             NA    
##  4 EDG        1        6.59     0.761             12.8            0.367
##  5 BTG        1        0.325    0.882              1.03           0.477
##  6 VET        1        1.28     0.146              9.68           1    
##  7 IHF        1        0.735    0.000876           1.27           0.635
##  8 DGB        1        0.583    0.892              0.670          0.743
##  9 XUC        1        1.50     0.459            NaN             NA    
## 10 LTC        1        0.521    0.600              0.733          0.844
## # … with 270 more rows
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
## # A tibble: 280 x 3
## # Groups:   symbol [56]
##    symbol model   rmse
##    <chr>  <chr>  <dbl>
##  1 EOS    lm     0.555
##  2 BCH    lm     1.27 
##  3 NEO    lm     2.08 
##  4 EDG    lm    21.2  
##  5 BTG    lm     0.478
##  6 VET    lm     1.07 
##  7 IHF    lm     0.866
##  8 DGB    lm     1.02 
##  9 XUC    lm     3.50 
## 10 LTC    lm     0.509
## # … with 270 more rows
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
## # A tibble: 280 x 3
## # Groups:   symbol [56]
##    symbol model    rmse
##    <chr>  <chr>   <dbl>
##  1 EOS    lm      0.453
##  2 BCH    lm    NaN    
##  3 NEO    lm    NaN    
##  4 EDG    lm     12.8  
##  5 BTG    lm      1.03 
##  6 VET    lm      9.68 
##  7 IHF    lm      1.27 
##  8 DGB    lm      0.670
##  9 XUC    lm    NaN    
## 10 LTC    lm      0.733
## # … with 270 more rows
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
## # A tibble: 280 x 3
## # Groups:   symbol [56]
##    symbol model   rsq
##    <chr>  <chr> <dbl>
##  1 EOS    lm    0.461
##  2 BCH    lm    0.115
##  3 NEO    lm    0.269
##  4 EDG    lm    0.300
##  5 BTG    lm    0.689
##  6 VET    lm    0.634
##  7 IHF    lm    0.287
##  8 DGB    lm    0.686
##  9 XUC    lm    0.507
## 10 LTC    lm    0.588
## # … with 270 more rows
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
## # A tibble: 280 x 3
## # Groups:   symbol [56]
##    symbol model     rsq
##    <chr>  <chr>   <dbl>
##  1 EOS    lm      0.860
##  2 BCH    lm    NaN    
##  3 NEO    lm    NaN    
##  4 EDG    lm      0.367
##  5 BTG    lm      0.477
##  6 VET    lm      1    
##  7 IHF    lm      0.635
##  8 DGB    lm      0.743
##  9 XUC    lm    NaN    
## 10 LTC    lm      0.844
## # … with 270 more rows
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

preserve10ab9011f05888fb

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
##  1 lm    holdout   4.06 0.468 
##  2 lm    test      2.94 0.432 
##  3 nnet  holdout   4.74 0.173 
##  4 nnet  test      3.82 0.199 
##  5 pcr   holdout   2.84 0.282 
##  6 pcr   test      2.35 0.294 
##  7 rf    holdout   4.16 0.134 
##  8 rf    test      3.40 0.140 
##  9 xgb   holdout   5.01 0.0852
## 10 xgb   test      3.84 0.111
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
## # A tibble: 134 x 4
## # Groups:   symbol [67]
##    symbol eval_set  rmse   rsq
##    <chr>  <chr>    <dbl> <dbl>
##  1 RCN    test      2.04 0.473
##  2 SEELE  holdout   3.22 0.465
##  3 VET    holdout   9.83 0.448
##  4 SEELE  test      4.28 0.409
##  5 LTC    holdout   2.16 0.384
##  6 CUR    test      8.05 0.357
##  7 BNT    test      3.67 0.352
##  8 REX    holdout   5.47 0.346
##  9 BTC    holdout   1.11 0.341
## 10 BCH    holdout   2.43 0.340
## # … with 124 more rows
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
   <td style="text-align:right;"> RCN </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #80b486">2.037189</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #71ca97">0.4729582</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> SEELE </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #939972">3.215955</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #77c292">0.4654205</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> VET </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ff0000">9.827385</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #87b186">0.4481851</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> SEELE </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #a48060">4.281731</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #aa8b6d">0.4094555</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> LTC </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #82b184">2.155857</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #c1725c">0.3835304</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> CUR </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #e2291e">8.049671</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #d9584b">0.3572731</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> BNT </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #9a8e6a">3.670174</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #dd5448">0.3523714</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> REX </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #b7654b">5.467049</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #e34d43">0.3458826</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> BTC </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #71ca97">1.107054</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #e74940">0.3410111</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> BCH </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #86ab80">2.426057</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #e84840">0.3400177</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> CRO </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #7cb98a">1.833005</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ef413b">0.3330961</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> CRPT </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #8ca379">2.790639</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f43b37">0.3267278</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> XEM </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #83af83">2.252748</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f63936">0.3253536</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> STORJ </td>
   <td style="text-align:right;"> test </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #a67e5e">4.384258</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #f93634">0.3219479</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> PAXG </td>
   <td style="text-align:right;"> holdout </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #72c895">1.176813</span> </td>
   <td style="text-align:right;"> <span style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ff3030">0.3153962</span> </td>
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
## # A tibble: 20 x 3
##    date_utc    rmse   rsq
##    <chr>      <dbl> <dbl>
##  1 2020-11-15  2.79 0.209
##  2 2020-11-16  3.82 0.217
##  3 2020-11-17  3.85 0.218
##  4 2020-11-18  5.06 0.226
##  5 2020-11-19  4.04 0.226
##  6 2020-11-20  3.48 0.232
##  7 2020-11-21  3.49 0.233
##  8 2020-11-22  3.60 0.240
##  9 2020-11-23  3.77 0.252
## 10 2020-11-24  3.68 0.253
## 11 2020-11-25  3.58 0.259
## 12 2020-11-26  4.25 0.223
## 13 2020-11-27  3.76 0.212
## 14 2020-11-28  4.01 0.233
## 15 2020-11-29  3.59 0.236
## 16 2020-11-30  3.40 0.226
## 17 2020-12-01  3.26 0.242
## 18 2020-12-02  3.50 0.236
## 19 2020-12-03  3.67 0.220
## 20 2020-12-04  3.60 0.220
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

