---
title: "Cryptocurrency Research"
date: 'Last Updated:<br/> 2020-11-12 14:24:10'
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

In this tutorial we will use the latest data from the cryptocurrency markets to provide a hands-on and complete example that anyone can follow along with.

## What will I learn?

-   You will learn about the value of "reproducible" research.

-   In this tutorial you will primarily learn about tools for the R programming language developed by [RStudio](https://rstudio.com/) and more specifically the [`tidyverse`](https://www.tidyverse.org/). If you are not familiar with these open source products, don't worry. We'll introduce these throughout the tutorial as needed.

-   The focus of the tutorial is on supervised machine learning, a process for building models that can predict future events, such as cryptocurrency prices. You will learn how to use the [`caret`](https://topepo.github.io/caret/index.html) package to make many different predictive models, and tools to evaluate their performance.

-   Before we can make the models themselves, we will need to "clean" the data. You will learn how to perform "group by" operations on your data using the [`dplyr`](https://dplyr.tidyverse.org/) package and to clean and modify grouped data.

<!-- -   You will be exposed to some useful data pre-processing R packages. -->

-   You will learn to visualize data using the [`ggplot2`](https://ggplot2.tidyverse.org/) package, as well as some powerful [tools to extend the functionality of ggplot2](https://exts.ggplot2.tidyverse.org/).

-   You will gain a better understanding of the steps involved in any supervised machine learning process, as well as considerations you might need to keep in mind based on your specific data and the way you plan on acting on the predictions you have made. Each problem comes with a unique set of challenges, but there are steps that are necessary in creating any supervised machine learning model, and questions you should ask yourself regardless of the specific problem at hand.

<!-- - [TODO - Add note on cross validation] -->

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

Reproducibility is all about making the life of anyone who needs to run the analysis as simple as possible, including and especially for the author herself. When creating a one-time analysis, the tool used should be great for the specific task as well as have the side-effect of being able to run again with the click of a button. In our case are using a tool called [**R Markdown**]{style="color: purple;"} [@R-rmarkdown].
<!-- because if important discoveries are made others will want to perform their own experiments and analysis before they start being accepted as fact. -->

Not being transparent about the methodology and data (when possible) used is a quantifiable cost that should be avoided, both in research and in business. A study conducted in 2015 for example approximated that for preclinical research (mostly on pharmaceuticals) alone the economy suffers a cost of $28 Billion a year associated with non-reproducible research in the United States [@freedman_economics_2015]:

<embed src="images/TheEconomicsOfReproducibilityInPreclinicalRe.pdf" width="800px" height="460px" type="application/pdf" />

Reproducibility as discussed in the paper embedded above relates to many aspects of the specific field of preclinical research, but in their work they identified 4 main categories that drove costs associated with irreproducibility as it pertains to preclinical research in the United States: 

![](images/IrreproducibilityCosts.PNG)

The "Data Analysis and Reporting" aspect (circled in red in the screenshot above) of a project is shared across many disciplines. As it related to preclinical research, in their breakdown they attribute roughly $7.19 Billion of the costs of irreproducible preclinical research to data analysis and reporting, which could potentially be avoided through the usage of open source tools that we are utilizing for this tutorial. These costs should pale in comparison to the other three categories, and this example is meant to show that there currently exists a costly lack of awareness around these tools; the tutorial itself is meant as an example to showcase the power of these free tools.

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

Go to the [next section](#setup) for instruction on getting setup to follow along with the code run in the tutorial. You can run every step either in the cloud on your web browser, or in your own R session. You can even make a copy of the GitHub Repository on your computer and run this "book" on the latest data (updated hourly), and make changes wherever you would like. All explained in the next section ➡️

## Disclaimer

\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">This tutorial is made available for learning and educational purposes only and the information to follow does not constitute trading advice in any way shape or form. We avoid giving any advice when it comes to trading strategies, as this is a very complex ecosystem that is out of the scope of this tutorial; we make no attempt in this regard, and if this, rather than data science, is your interest, your time would be better spent following a different tutorial that aims to answer those questions.</div>\EndKnitrBlock{rmdimportant}

It should also be noted that this tutorial has nothing to do with trading itself, and that there is a difference between predicting crypotcurrency prices and creating an effective trading strategy. [See this later section for more details on why the results shown in this document mean nothing in terms of the effectiveness of a trading strategy](#considerations).

In this document we aimed to predict the change in cryptocurrency prices, and **it is very important to recognize that this is not the same as being able to successfully make money trading on the cryptocurrency markets**. 



<!--chapter:end:index.Rmd-->

# Setup and Installation {#setup}

Every part of this document can be run on any computer either through a cloud notebook or locally.

You can also follow along with the tutorial without running the individual steps yourself. In that case, [**you can move on to the next page where the tutorial actually begins**](#overview).

## Option 1 - Run in the Cloud {#run-in-the-cloud}

If you do not currently have R and RStudio installed on your computer, you can run all of the code from your web browser one step at a time here: <a href="https://gesis.mybinder.org/binder/v2/gh/ries9112/Research-Paper-Example/0a23077a85848af214976c87d7d5d2472df700ee?filepath=Jupyter%2FCryptocurrency%20Research.ipynb" target="_blank">**this mobile friendly link**</a>.

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
       'caret', 'doParallel', 'parallel', 'xgboost', 'gbm', 'deepnet', # Predictive Modeling
       'hydroGOF', 'formattable', 'knitr') # Evaluate Model Performance
```
***It is normal for this step to take a long time, as it will install every package you will need to follow along with the rest of the tutorial.*** The next time you run this command it would be much faster because it would skip installing the already installed packages.

Running **p\_load()** is equivalent to running [**install.packages()**]{style="color: green;"} on each of the packages listed **(but only when they are not already installed on your computer)**, and then running [library()]{style="color: green;"} for each package in quotes separated by commas to import the functionality from the package into the current R session. **Both commands are wrapped inside the single function call to** [**p\_load()**]{style="color: green;"}. We could run each command individually using base R and create our own logic to only install packages not currently installed, but we are better off using a package that has already been developed and scrutinized by many expert programmers; the same goes for complex statistical models, we don't need to create things from scratch if we understand how to properly use tools developed by the open source community. Open source tools have become particularly good in recent years and can be used for any kind of work, including commercial work, most large corporations have started using open source tools available through R and Python.

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

## Pull the Data

The first thing we will need to do is download the latest data. We will do this by using the [**pins**]{style="color: #ae7b11;"} package [@R-pins], which has already been loaded into our session [in the previous section](#installing-and-loading-packages).

First, we will need to connect to a public GitHub repository (anyone can post their code to the GitHub website and make a "repository" with code for their project) and ***register*** the ***board*** that the data is ***pinned*** to by using the [**board_register()**]{style="color: green;"} function:


```r
board_register(name = "pins_board", 
               url = "https://raw.githubusercontent.com/predictcrypto/pins/master/", 
               board = "datatxt")
```

By running the [**board_register()**]{style="color: green;"} command on the URL where the data is located, we can now ***"ask"*** for the data we are interested in, which is called [**hitBTC_orderbook**]{style="color: blue;"}, by using the [**pin_get()**]{style="color: green;"} command:


```r
cryptodata <- pin_get(name = "hitBTC_orderbook")
```

<!-- Couldn't hide the progress bar so split it into a hidden code chunk instead -->



The data has been saved to the [**cryptodata**]{style="color: blue;"} object.

## Data Preview {#data-preview}



Below is a preview of the data:

preserve28a1598e51600038

*Only the first 2,000 rows of the data are shown in the table above. There are 241438 rows in the actual full dataset. The latest data is from 2020-11-12 (UTC timezone).*

This is [[***tidy***]{style="color: purple;"} ***data***](https://tidyr.tidyverse.org/articles/tidy-data.html), meaning:

1.  Every column is a variable.

2.  Every row is an observation.

3.  Every cell is a single value relating to a specific variable and observation.

The data is collected once per hour. Each row is an observation of an individual cryptocurrency, and the same cryptocurrency is tracked on an hourly basis, each time presented as a new row in the dataset.

## The definition of a "price" {#the-definition-of-a-price}

When we are talking about the price of a cryptocurrency, there are several different ways to define it and there is a lot more than meets the eye. Most people check cryptocurrency "prices" on websites that aggregate data across thousands of exchanges, and have ways of computing a global average that represents the current "price" of the cryptocurrency. This is what happens on the very popular website coinmarketcap.com, but is this the correct approach for our use case?

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
|Number of rows           |241438     |
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
|pair           |         0|             1|   5|   9|     0|      218|          0|
|symbol         |         0|             1|   2|   6|     0|      218|          0|
|quote_currency |         0|             1|   3|   3|     0|        1|          0|
|pkDummy        |       642|             1|  13|  13|     0|     2261|          0|
|pkey           |       642|             1|  15|  19|     0|   240516|          0|


**Variable type: Date**

|skim_variable | n_missing| complete_rate|min        |max        |median     | n_unique|
|:-------------|---------:|-------------:|:----------|:----------|:----------|--------:|
|date          |       642|             1|2020-08-10 |2020-11-12 |2020-09-28 |       95|


**Variable type: numeric**

|skim_variable  | n_missing| complete_rate|      mean|          sd| p0|   p25|    p50|     p75|         p100|hist  |
|:--------------|---------:|-------------:|---------:|-----------:|--:|-----:|------:|-------:|------------:|:-----|
|ask_1_price    |        43|             1|  29260.43| 14247345.55|  0|  0.01|   0.06|    0.59| 7000000000.0|▇▁▁▁▁ |
|ask_1_quantity |        43|             1| 198129.43|  5130486.04|  0| 19.90| 433.00| 3920.00|  455776000.0|▇▁▁▁▁ |
|ask_2_price    |        85|             1|    245.95|     6927.73|  0|  0.01|   0.06|    0.59|     999999.0|▇▁▁▁▁ |
|ask_2_quantity |        85|             1| 214705.30|  4640443.20|  0| 20.00| 491.00| 5590.00|  459459000.0|▇▁▁▁▁ |
|ask_3_price    |       302|             1|    264.20|     7671.76|  0|  0.01|   0.06|    0.59|     999000.0|▇▁▁▁▁ |
|ask_3_quantity |       302|             1| 262685.13|  5004436.75|  0| 16.00| 428.85| 7200.00|  518082000.0|▇▁▁▁▁ |
|ask_4_price    |       398|             1| 203499.61| 37722206.27|  0|  0.01|   0.06|    0.60| 7000000000.0|▇▁▁▁▁ |
|ask_4_quantity |       398|             1| 277083.58|  4927221.75|  0| 14.00| 452.38| 7777.18|  546546000.0|▇▁▁▁▁ |
|ask_5_price    |       464|             1|    192.93|     1457.28|  0|  0.01|   0.07|    0.61|      24000.0|▇▁▁▁▁ |
|ask_5_quantity |       464|             1| 284043.55|  5245190.19|  0| 12.60| 439.53| 8886.08|  549312000.0|▇▁▁▁▁ |
|bid_1_price    |       480|             1|    189.89|     1445.41|  0|  0.00|   0.05|    0.50|      20298.0|▇▁▁▁▁ |
|bid_1_quantity |       480|             1| 161497.65|  2654470.44|  0| 28.00| 649.80| 7647.00|  296583000.0|▇▁▁▁▁ |
|bid_2_price    |       539|             1|    189.73|     1444.87|  0|  0.00|   0.05|    0.49|      20269.5|▇▁▁▁▁ |
|bid_2_quantity |       539|             1| 164421.53|  3178174.20|  0| 23.00| 508.20| 6229.25|  562697873.0|▇▁▁▁▁ |
|bid_3_price    |       541|             1|    189.44|     1444.05|  0|  0.00|   0.04|    0.48|      20231.5|▇▁▁▁▁ |
|bid_3_quantity |       541|             1| 222891.42|  3248450.86|  0| 13.72| 400.00| 6299.60|  347366000.0|▇▁▁▁▁ |
|bid_4_price    |       541|             1|    189.09|     1443.08|  0|  0.00|   0.04|    0.47|      20227.4|▇▁▁▁▁ |
|bid_4_quantity |       541|             1| 283943.92|  3684537.40|  0| 10.00| 399.67| 7501.00|  331285000.0|▇▁▁▁▁ |
|bid_5_price    |       543|             1|    188.61|     1441.42|  0|  0.00|   0.04|    0.45|      20210.4|▇▁▁▁▁ |
|bid_5_quantity |       543|             1| 332568.10|  4376219.28|  0| 10.00| 390.20| 8537.05|  384159000.0|▇▁▁▁▁ |


**Variable type: POSIXct**

|skim_variable | n_missing| complete_rate|min                 |max                 |median              | n_unique|
|:-------------|---------:|-------------:|:-------------------|:-------------------|:-------------------|--------:|
|date_time_utc |       642|             1|2020-08-10 04:29:09 |2020-11-12 14:03:25 |2020-09-28 06:02:18 |   212784|

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
## [1] "2020-11-12T14:24:26.313Z"
## 
## $batchingTime
## [1] "2020-11-12T14:24:26.327Z"
## 
## $ask
##     price    size
## 1 462.303  5.6250
## 2 462.304  1.0800
## 3 462.306  0.2500
## 4 462.335 30.0000
## 5 462.420  1.3879
## 
## $bid
##     price    size
## 1 461.980  4.8761
## 2 461.979  1.6137
## 3 461.977 30.0000
## 4 461.960  1.0800
## 5 461.954  3.0000
```

The data is collected by a script running on a private server (RStudio) that iterates through all cryptocurrency options one by one at the start of every hour, and writes all of the data to a private database. Once the data is in the database, a different script gets kicked off every hour to publish the latest data from the database to the publicly available data source [discussed at the beginning of this section](#pull-the-data).

***The chart shown below will be outlined digitally very soon (this is a note for Kai and Chandler)***: 
![](images/data_lifecycle.png){width="600"}

<!--chapter:end:02-ExploreData.Rmd-->

# Data Prep {#data-prep}

Next we will do some data cleaning to make sure our data is in the format we need it to be in. For a gentler introduction to data prep using the [**dplyr**]{style="color: #ae7b11;"} package [@R-dplyr] [consult the high-level version](https://cryptocurrencyresearch.org/high-level/#/data-prep).

## Remove Nulls {#remove-nulls}

First off, we aren't able to do anything at all with a row of data if we don't know ***when*** the data was collected. The specific price doesn't matter if we can't tie it to a timestamp, given by the [**date_time_utc**]{style="color: blue;"} field. 

We can exclude all rows where the [**date_time_utc**]{style="color: blue;"} field has a Null (missing) value by using the [**filter()**]{style="color: green;"} function from the [**dplyr**]{style="color: #ae7b11;"} package:




```r
cryptodata <- filter(cryptodata, !is.na(date_time_utc))
```



This step removed 642 rows from the data on the latest run (2020-11-12). The [**is.na()**]{style="color: green;"} function finds all cases where the [**date_time_utc**]{style="color: blue;"} field has a Null value. The function is preceded by the [**!**]{style="color: blue;"} operator, which tells the [**filter()**]{style="color: green;"} function to exclude these rows from the data.

By the same logic, if we don't know what the price was for any of the rows, the whole row of data is useless and should be removed. But how will we define the price of a cryptocurrency?

## Calculate `price_usd` Column

In the [previous section we discussed the intricacies of a cryptocurrency's price](#the-definition-of-a-price). We could complicate our definition of a price by considering both the [**bid**]{style="color: blue;"} and [**ask**]{style="color: blue;"} prices from the perspective of someone who wants to perform trades, but [**this is not a trading tutorial**](#considerations). Instead, we will define the price of a cryptocurrency as the price we could purchase it for. We will calculate the [**price_usd**]{style="color: blue;"} field using the cheapest price available from the [**ask**]{style="color: blue;"} side where at least \$15 worth of the cryptocurrency are being sold.

Therefore, let's figure out the lowest price from the order book data that would allow us to purchase at least \$15 worth of the cryptocurrency. To do this, for each [**ask**]{style="color: blue;"} price and quantity, let's figure out the value of the trade in US Dollars. We can create each of the new [**trade_usd**]{style="color: blue;"} columns using the [**mutate()**]{style="color: green;"} function. The [**trade_usd_1**]{style="color: blue;"} should be calculated as the [**ask_1_price**]{style="color: blue;"} multiplied by the [**ask_1_quantity**]{style="color: blue;"}. The next one [**trade_usd_1**]{style="color: blue;"} should consider the [**ask_2_price**]{style="color: blue;"}, but be multiplied by the sum of [**ask_1_quantity**]{style="color: blue;"} and [**ask_2_quantity**]{style="color: blue;"} because at the [**ask_2_price**]{style="color: blue;"} pricepoint we can also purchase the quantity available at the [**ask_1_price**]{style="color: blue;"} pricepoint:


```r
cryptodata <- mutate(cryptodata, 
                     trade_usd_1 = ask_1_price * ask_1_quantity,
                     trade_usd_2 = ask_2_price * (ask_1_quantity + ask_2_quantity),
                     trade_usd_3 = ask_3_price * (ask_1_quantity + ask_2_quantity + ask_3_quantity),
                     trade_usd_4 = ask_4_price * (ask_1_quantity + ask_2_quantity + ask_3_quantity + ask_4_quantity),
                     trade_usd_5 = ask_5_price * (ask_1_quantity + ask_2_quantity + ask_3_quantity + ask_4_quantity + ask_5_quantity))
```
<!-- *For a more in-depth explanation of how [**mutate()**]{style="color: green;"} works, [see the high-level version of the tutorial](https://cryptocurrencyresearch.org/high-level/#/mutate-function---dplyr)* -->

We can confirm that the [**trade_usd_1**]{style="color: blue;"} field is calculating the $ value of the lowest ask price ans quantity:

```r
head(select(cryptodata, symbol, date_time_utc, ask_1_price, ask_1_quantity, trade_usd_1))
```

```
## [90m# A tibble: 6 x 5[39m
##   symbol date_time_utc       ask_1_price ask_1_quantity trade_usd_1
##   [3m[90m<chr>[39m[23m  [3m[90m<dttm>[39m[23m                    [3m[90m<dbl>[39m[23m          [3m[90m<dbl>[39m[23m       [3m[90m<dbl>[39m[23m
## [90m1[39m BTC    2020-11-12 [90m00:00:00[39m   [4m1[24m[4m5[24m685.              2        [4m3[24m[4m1[24m371. 
## [90m2[39m ETH    2020-11-12 [90m00:00:01[39m     463.              0.4        185. 
## [90m3[39m EOS    2020-11-12 [90m00:00:01[39m       2.50           60          150. 
## [90m4[39m LTC    2020-11-12 [90m00:00:02[39m      59.3             3.75       222. 
## [90m5[39m BSV    2020-11-12 [90m00:00:04[39m     159.              0.6         95.4
## [90m6[39m ADA    2020-11-12 [90m00:00:04[39m       0.106         775           82.1
```

Now we can use the [**mutate()**]{style="color: green;"} function to create the new field [**price_usd**]{style="color: blue;"} and find the lowest price at which we could have purchased at least \$15 worth of the cryptocurrency. We can use the [**case_when()**]{style="color: green;"} function to find the first [**trade_usd**]{style="color: blue;"} value that is greater or equal to 15, and assign the correct [**ask_price**]{style="color: blue;"} for the new column [**price_usd**]{style="color: blue;"}:


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



This step removed 14753 rows on the latest run.


## Clean Data by Group {#clean-data-by-group}

In the [high-level version of this tutorial](https://cryptocurrencyresearch.org/high-level/) we only dealt with one cryptocurrency. In this version however, we will be creating independent models for each cryptocurrency. Because of this, **we need to ensure data quality not only for the data as a whole, but also for the data associated with each individual cryptocurrency**. Instead of considering all rows when applying a transformation, we can [**group**]{style="color: purple;"} the data by the individual cryptocurrency and apply the transformation to each group. This will only work with compatible functions from [**dplyr**]{style="color: #ae7b11;"} and the [**tidyverse**]{style="color: #ae7b11;"}.

For example, we could count the number of observations by running the [**count()**]{style="color: green;"} function on the data:

```r
count(cryptodata)
```

```
## [90m# A tibble: 1 x 1[39m
##        n
##    [3m[90m<int>[39m[23m
## [90m1[39m [4m2[24m[4m2[24m[4m6[24m043
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
## [90m# A tibble: 216 x 2[39m
## [90m# Groups:   symbol [216][39m
##    symbol     n
##    [3m[90m<chr>[39m[23m  [3m[90m<int>[39m[23m
## [90m 1[39m AAB     [4m1[24m094
## [90m 2[39m ACAT    [4m1[24m868
## [90m 3[39m ACT     [4m1[24m625
## [90m 4[39m ADA     [4m1[24m151
## [90m 5[39m ADX      393
## [90m 6[39m ADXN     665
## [90m 7[39m ALGO       1
## [90m 8[39m AMB      557
## [90m 9[39m AMM     [4m1[24m014
## [90m10[39m APL      701
## [90m# … with 206 more rows[39m
```

We can remove the grouping at any point by running the [**ungroup()**]{style="color: green;"} function:

```r
count(ungroup(cryptodata))
```

```
## [90m# A tibble: 1 x 1[39m
##        n
##    [3m[90m<int>[39m[23m
## [90m1[39m [4m2[24m[4m2[24m[4m6[24m043
```


### Remove symbols without enough rows

Because this dataset evolves over time, we will need to be proactive about issues that may arise even if they aren't currently a problem. 

What happens if a new cryptocurrency gets added to the cryptocurrency exchange? If we only had a couple days of data for an asset, not only would that not be enough information to build effective predictive models, but we may run into actual errors since the data will be further split into more groups to validate the results of the models against several datasets using [**cross validation**]{style="color: purple;"}, more to come on that later.

To ensure we have a reasonable amount of data for each individual cryptocurrency, let's filter out any cryptocurrencies that don't have at least 1,000 observations using the [**filter()**]{style="color: green;"} function:




```r
cryptodata <- filter(cryptodata, n() >= 1000)
```



The number of rows for the `cryptodata` dataset before the filtering step was 226043 and is now 181262. This step removed 96 cryptocurrencies from the analysis that did not have enough observations associated with them.

### Remove symbols without data from the last 3 days

If there was no data collected for a cryptocurrency over the last 3 day period, let's exclude that asset from the dataset since we are only looking to model data that is currently flowing through the process. If an asset is removed from the exchange (if a project is a scam for example) or is no longer being actively captured by the data collection process, we can't make new predictions for it, so might as well exclude these ahead of time as well.




```r
cryptodata <- filter(cryptodata, max(date) > Sys.Date()-3)
```



The number of rows for the `cryptodata` dataset before this filtering step was 152914 and is now 181262.

## Calculate Target

Our goal is to be able to make predictions on the price of each cryptocurrency 24 hours into the future from when the data was collected. Therefore, the [**target variable**]{style="color: purple;"} that we will be using as *what we want to predict* for the predictive models, is the price 24 hours into the future relative to when the data was collected. 

To do this we can create a new column in the data that is the [**price_usd**]{style="color: blue;"} offset by 24 rows (one for each hour), but before we can do that we need to make sure there are no gaps anywhere in the data.

### Convert to tsibble {#convert-to-tsibble}

We can fill any gaps in the data using the [**tsibble**]{style="color: #ae7b11;"} package [@R-tsibble], which was covered in more detail in the [high level version of the tutorial](https://cryptocurrencyresearch.org/high-level/#/timeseries-data-prep).

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
## [90m# A tsibble: 152,694 x 34 [1h] <UTC>[39m
## [90m# Key:       symbol [96][39m
## [90m# Groups:    symbol [96][39m
##    pair  symbol quote_currency ask_1_price ask_1_quantity ask_2_price
##    [3m[90m<chr>[39m[23m [3m[90m<chr>[39m[23m  [3m[90m<chr>[39m[23m                [3m[90m<dbl>[39m[23m          [3m[90m<dbl>[39m[23m       [3m[90m<dbl>[39m[23m
## [90m 1[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 2[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 3[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 4[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 5[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 6[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 7[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 8[39m AABU… AAB    USD                  0.390           104.       0.390
## [90m 9[39m AABU… AAB    USD                  0.390           104.       0.390
## [90m10[39m AABU… AAB    USD                  0.390           104.       0.390
## [90m# … with 152,684 more rows, and 28 more variables: ask_2_quantity [3m[90m<dbl>[90m[23m,[39m
## [90m#   ask_3_price [3m[90m<dbl>[90m[23m, ask_3_quantity [3m[90m<dbl>[90m[23m, ask_4_price [3m[90m<dbl>[90m[23m,[39m
## [90m#   ask_4_quantity [3m[90m<dbl>[90m[23m, ask_5_price [3m[90m<dbl>[90m[23m, ask_5_quantity [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_1_price [3m[90m<dbl>[90m[23m, bid_1_quantity [3m[90m<dbl>[90m[23m, bid_2_price [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_2_quantity [3m[90m<dbl>[90m[23m, bid_3_price [3m[90m<dbl>[90m[23m, bid_3_quantity [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_4_price [3m[90m<dbl>[90m[23m, bid_4_quantity [3m[90m<dbl>[90m[23m, bid_5_price [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_5_quantity [3m[90m<dbl>[90m[23m, date_time_utc [3m[90m<dttm>[90m[23m, date [3m[90m<date>[90m[23m, pkDummy [3m[90m<chr>[90m[23m,[39m
## [90m#   pkey [3m[90m<chr>[90m[23m, trade_usd_1 [3m[90m<dbl>[90m[23m, trade_usd_2 [3m[90m<dbl>[90m[23m, trade_usd_3 [3m[90m<dbl>[90m[23m,[39m
## [90m#   trade_usd_4 [3m[90m<dbl>[90m[23m, trade_usd_5 [3m[90m<dbl>[90m[23m, price_usd [3m[90m<dbl>[90m[23m, ts_index [3m[90m<dttm>[90m[23m[39m
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



Now looking at the data again, there are 20354 additional rows that were added as implicitly missing in the data:


```r
cryptodata
```

```
## [90m# A tsibble: 173,048 x 34 [1h] <UTC>[39m
## [90m# Key:       symbol [96][39m
## [90m# Groups:    symbol [96][39m
##    pair  symbol quote_currency ask_1_price ask_1_quantity ask_2_price
##    [3m[90m<chr>[39m[23m [3m[90m<chr>[39m[23m  [3m[90m<chr>[39m[23m                [3m[90m<dbl>[39m[23m          [3m[90m<dbl>[39m[23m       [3m[90m<dbl>[39m[23m
## [90m 1[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 2[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 3[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 4[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 5[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 6[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 7[39m AABU… AAB    USD                  0.390           104.       0.39 
## [90m 8[39m AABU… AAB    USD                  0.390           104.       0.390
## [90m 9[39m AABU… AAB    USD                  0.390           104.       0.390
## [90m10[39m AABU… AAB    USD                  0.390           104.       0.390
## [90m# … with 173,038 more rows, and 28 more variables: ask_2_quantity [3m[90m<dbl>[90m[23m,[39m
## [90m#   ask_3_price [3m[90m<dbl>[90m[23m, ask_3_quantity [3m[90m<dbl>[90m[23m, ask_4_price [3m[90m<dbl>[90m[23m,[39m
## [90m#   ask_4_quantity [3m[90m<dbl>[90m[23m, ask_5_price [3m[90m<dbl>[90m[23m, ask_5_quantity [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_1_price [3m[90m<dbl>[90m[23m, bid_1_quantity [3m[90m<dbl>[90m[23m, bid_2_price [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_2_quantity [3m[90m<dbl>[90m[23m, bid_3_price [3m[90m<dbl>[90m[23m, bid_3_quantity [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_4_price [3m[90m<dbl>[90m[23m, bid_4_quantity [3m[90m<dbl>[90m[23m, bid_5_price [3m[90m<dbl>[90m[23m,[39m
## [90m#   bid_5_quantity [3m[90m<dbl>[90m[23m, date_time_utc [3m[90m<dttm>[90m[23m, date [3m[90m<date>[90m[23m, pkDummy [3m[90m<chr>[90m[23m,[39m
## [90m#   pkey [3m[90m<chr>[90m[23m, trade_usd_1 [3m[90m<dbl>[90m[23m, trade_usd_2 [3m[90m<dbl>[90m[23m, trade_usd_3 [3m[90m<dbl>[90m[23m,[39m
## [90m#   trade_usd_4 [3m[90m<dbl>[90m[23m, trade_usd_5 [3m[90m<dbl>[90m[23m, price_usd [3m[90m<dbl>[90m[23m, ts_index [3m[90m<dttm>[90m[23m[39m
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
## [90m# A tibble: 2,267 x 6[39m
## [90m# Groups:   symbol [1][39m
##    symbol ts_index            price_usd lagged_price_1h lagged_price_24h
##    [3m[90m<chr>[39m[23m  [3m[90m<dttm>[39m[23m                  [3m[90m<dbl>[39m[23m           [3m[90m<dbl>[39m[23m            [3m[90m<dbl>[39m[23m
## [90m 1[39m BTC    2020-08-10 [90m04:00:00[39m    [4m1[24m[4m1[24m997.             [31mNA[39m               [31mNA[39m 
## [90m 2[39m BTC    2020-08-10 [90m05:00:00[39m    [4m1[24m[4m1[24m986.          [4m1[24m[4m1[24m997.              [31mNA[39m 
## [90m 3[39m BTC    2020-08-10 [90m06:00:00[39m    [4m1[24m[4m1[24m973.          [4m1[24m[4m1[24m986.              [31mNA[39m 
## [90m 4[39m BTC    2020-08-10 [90m07:00:00[39m    [4m1[24m[4m1[24m994.          [4m1[24m[4m1[24m973.              [31mNA[39m 
## [90m 5[39m BTC    2020-08-10 [90m08:00:00[39m    [4m1[24m[4m1[24m984.          [4m1[24m[4m1[24m994.              [31mNA[39m 
## [90m 6[39m BTC    2020-08-10 [90m09:00:00[39m    [4m1[24m[4m1[24m962.          [4m1[24m[4m1[24m984.              [31mNA[39m 
## [90m 7[39m BTC    2020-08-10 [90m10:00:00[39m    [4m1[24m[4m1[24m989.          [4m1[24m[4m1[24m962.              [31mNA[39m 
## [90m 8[39m BTC    2020-08-10 [90m11:00:00[39m    [4m1[24m[4m1[24m709.          [4m1[24m[4m1[24m989.              [31mNA[39m 
## [90m 9[39m BTC    2020-08-10 [90m12:00:00[39m    [4m1[24m[4m1[24m721.          [4m1[24m[4m1[24m709.              [31mNA[39m 
## [90m10[39m BTC    2020-08-10 [90m13:00:00[39m    [4m1[24m[4m1[24m890.          [4m1[24m[4m1[24m721.              [31mNA[39m 
## [90m11[39m BTC    2020-08-10 [90m14:00:00[39m    [4m1[24m[4m1[24m908.          [4m1[24m[4m1[24m890.              [31mNA[39m 
## [90m12[39m BTC    2020-08-10 [90m15:00:00[39m    [4m1[24m[4m1[24m889.          [4m1[24m[4m1[24m908.              [31mNA[39m 
## [90m13[39m BTC    2020-08-10 [90m16:00:00[39m    [4m1[24m[4m1[24m918.          [4m1[24m[4m1[24m889.              [31mNA[39m 
## [90m14[39m BTC    2020-08-10 [90m17:00:00[39m    [4m1[24m[4m1[24m855.          [4m1[24m[4m1[24m918.              [31mNA[39m 
## [90m15[39m BTC    2020-08-10 [90m18:00:00[39m    [4m1[24m[4m1[24m887.          [4m1[24m[4m1[24m855.              [31mNA[39m 
## [90m16[39m BTC    2020-08-10 [90m19:00:00[39m    [4m1[24m[4m1[24m878.          [4m1[24m[4m1[24m887.              [31mNA[39m 
## [90m17[39m BTC    2020-08-10 [90m20:00:00[39m    [4m1[24m[4m1[24m855.          [4m1[24m[4m1[24m878.              [31mNA[39m 
## [90m18[39m BTC    2020-08-10 [90m21:00:00[39m    [4m1[24m[4m1[24m847.          [4m1[24m[4m1[24m855.              [31mNA[39m 
## [90m19[39m BTC    2020-08-10 [90m22:00:00[39m    [4m1[24m[4m1[24m820.          [4m1[24m[4m1[24m847.              [31mNA[39m 
## [90m20[39m BTC    2020-08-10 [90m23:00:00[39m    [4m1[24m[4m1[24m805.          [4m1[24m[4m1[24m820.              [31mNA[39m 
## [90m21[39m BTC    2020-08-11 [90m00:00:00[39m    [4m1[24m[4m1[24m906.          [4m1[24m[4m1[24m805.              [31mNA[39m 
## [90m22[39m BTC    2020-08-11 [90m01:00:00[39m    [4m1[24m[4m1[24m863.          [4m1[24m[4m1[24m906.              [31mNA[39m 
## [90m23[39m BTC    2020-08-11 [90m02:00:00[39m    [4m1[24m[4m1[24m901.          [4m1[24m[4m1[24m863.              [31mNA[39m 
## [90m24[39m BTC    2020-08-11 [90m03:00:00[39m    [4m1[24m[4m1[24m868.          [4m1[24m[4m1[24m901.              [31mNA[39m 
## [90m25[39m BTC    2020-08-11 [90m04:00:00[39m    [4m1[24m[4m1[24m840.          [4m1[24m[4m1[24m868.           [4m1[24m[4m1[24m997.
## [90m26[39m BTC    2020-08-11 [90m05:00:00[39m    [4m1[24m[4m1[24m820.          [4m1[24m[4m1[24m840.           [4m1[24m[4m1[24m986.
## [90m27[39m BTC    2020-08-11 [90m06:00:00[39m    [4m1[24m[4m1[24m847.          [4m1[24m[4m1[24m820.           [4m1[24m[4m1[24m973.
## [90m28[39m BTC    2020-08-11 [90m07:00:00[39m    [4m1[24m[4m1[24m774.          [4m1[24m[4m1[24m847.           [4m1[24m[4m1[24m994.
## [90m29[39m BTC    2020-08-11 [90m08:00:00[39m    [4m1[24m[4m1[24m761.          [4m1[24m[4m1[24m774.           [4m1[24m[4m1[24m984.
## [90m30[39m BTC    2020-08-11 [90m09:00:00[39m    [4m1[24m[4m1[24m753.          [4m1[24m[4m1[24m761.           [4m1[24m[4m1[24m962.
## [90m# … with 2,237 more rows, and 1 more variable: target_price_24h [3m[90m<dbl>[90m[23m[39m
```

We can wrap the code used above in the [**tail()**]{style="color: green;"} function to show the most recent data and see the opposite dynamic with the new fields we created:


```r
print(tail(select(filter(cryptodata, symbol == 'BTC'), 
                  ts_index, price_usd, lagged_price_1h, 
                  lagged_price_24h, target_price_24h),30), n=30)
```

```
## [90m# A tibble: 30 x 6[39m
## [90m# Groups:   symbol [1][39m
##    symbol ts_index            price_usd lagged_price_1h lagged_price_24h
##    [3m[90m<chr>[39m[23m  [3m[90m<dttm>[39m[23m                  [3m[90m<dbl>[39m[23m           [3m[90m<dbl>[39m[23m            [3m[90m<dbl>[39m[23m
## [90m 1[39m BTC    2020-11-11 [90m09:00:00[39m    [4m1[24m[4m5[24m398.          [4m1[24m[4m5[24m402.           [4m1[24m[4m5[24m370.
## [90m 2[39m BTC    2020-11-11 [90m10:00:00[39m    [4m1[24m[4m5[24m430.          [4m1[24m[4m5[24m398.           [4m1[24m[4m5[24m385.
## [90m 3[39m BTC    2020-11-11 [90m11:00:00[39m    [4m1[24m[4m5[24m589.          [4m1[24m[4m5[24m430.           [4m1[24m[4m5[24m309.
## [90m 4[39m BTC    2020-11-11 [90m12:00:00[39m    [4m1[24m[4m5[24m570.          [4m1[24m[4m5[24m589.           [4m1[24m[4m5[24m274.
## [90m 5[39m BTC    2020-11-11 [90m13:00:00[39m    [4m1[24m[4m5[24m624           [4m1[24m[4m5[24m570.           [4m1[24m[4m5[24m283.
## [90m 6[39m BTC    2020-11-11 [90m14:00:00[39m    [4m1[24m[4m5[24m552.          [4m1[24m[4m5[24m624            [4m1[24m[4m5[24m305.
## [90m 7[39m BTC    2020-11-11 [90m15:00:00[39m    [4m1[24m[4m5[24m634.          [4m1[24m[4m5[24m552.           [4m1[24m[4m5[24m220.
## [90m 8[39m BTC    2020-11-11 [90m16:00:00[39m    [4m1[24m[4m5[24m666.          [4m1[24m[4m5[24m634.           [4m1[24m[4m5[24m162.
## [90m 9[39m BTC    2020-11-11 [90m17:00:00[39m    [4m1[24m[4m5[24m752.          [4m1[24m[4m5[24m666.           [4m1[24m[4m5[24m243.
## [90m10[39m BTC    2020-11-11 [90m18:00:00[39m    [4m1[24m[4m5[24m869.          [4m1[24m[4m5[24m752.           [4m1[24m[4m5[24m312.
## [90m11[39m BTC    2020-11-11 [90m19:00:00[39m    [4m1[24m[4m5[24m802.          [4m1[24m[4m5[24m869.           [4m1[24m[4m5[24m266.
## [90m12[39m BTC    2020-11-11 [90m20:00:00[39m    [4m1[24m[4m5[24m805.          [4m1[24m[4m5[24m802.           [4m1[24m[4m5[24m299.
## [90m13[39m BTC    2020-11-11 [90m21:00:00[39m    [4m1[24m[4m5[24m712.          [4m1[24m[4m5[24m805.           [4m1[24m[4m5[24m285.
## [90m14[39m BTC    2020-11-11 [90m22:00:00[39m    [4m1[24m[4m5[24m814.          [4m1[24m[4m5[24m712.           [4m1[24m[4m5[24m376.
## [90m15[39m BTC    2020-11-11 [90m23:00:00[39m    [4m1[24m[4m5[24m783.          [4m1[24m[4m5[24m814.           [4m1[24m[4m5[24m365.
## [90m16[39m BTC    2020-11-12 [90m00:00:00[39m    [4m1[24m[4m5[24m685.          [4m1[24m[4m5[24m783.           [4m1[24m[4m5[24m295.
## [90m17[39m BTC    2020-11-12 [90m01:00:00[39m    [4m1[24m[4m5[24m610.          [4m1[24m[4m5[24m685.           [4m1[24m[4m5[24m473.
## [90m18[39m BTC    2020-11-12 [90m02:00:00[39m    [4m1[24m[4m5[24m640.          [4m1[24m[4m5[24m610.           [4m1[24m[4m5[24m433.
## [90m19[39m BTC    2020-11-12 [90m03:00:00[39m    [4m1[24m[4m5[24m618.          [4m1[24m[4m5[24m640.           [4m1[24m[4m5[24m393.
## [90m20[39m BTC    2020-11-12 [90m04:00:00[39m    [4m1[24m[4m5[24m628.          [4m1[24m[4m5[24m618.           [4m1[24m[4m5[24m405.
## [90m21[39m BTC    2020-11-12 [90m05:00:00[39m    [4m1[24m[4m5[24m658.          [4m1[24m[4m5[24m628.           [4m1[24m[4m5[24m370.
## [90m22[39m BTC    2020-11-12 [90m06:00:00[39m    [4m1[24m[4m5[24m747.          [4m1[24m[4m5[24m658.           [4m1[24m[4m5[24m369.
## [90m23[39m BTC    2020-11-12 [90m07:00:00[39m    [4m1[24m[4m5[24m793.          [4m1[24m[4m5[24m747.           [4m1[24m[4m5[24m357.
## [90m24[39m BTC    2020-11-12 [90m08:00:00[39m    [4m1[24m[4m5[24m856.          [4m1[24m[4m5[24m793.           [4m1[24m[4m5[24m402.
## [90m25[39m BTC    2020-11-12 [90m09:00:00[39m    [4m1[24m[4m5[24m786.          [4m1[24m[4m5[24m856.           [4m1[24m[4m5[24m398.
## [90m26[39m BTC    2020-11-12 [90m10:00:00[39m    [4m1[24m[4m6[24m043.          [4m1[24m[4m5[24m786.           [4m1[24m[4m5[24m430.
## [90m27[39m BTC    2020-11-12 [90m11:00:00[39m    [4m1[24m[4m5[24m704.          [4m1[24m[4m6[24m043.           [4m1[24m[4m5[24m589.
## [90m28[39m BTC    2020-11-12 [90m12:00:00[39m    [4m1[24m[4m5[24m770.          [4m1[24m[4m5[24m704.           [4m1[24m[4m5[24m570.
## [90m29[39m BTC    2020-11-12 [90m13:00:00[39m    [4m1[24m[4m5[24m888.          [4m1[24m[4m5[24m770.           [4m1[24m[4m5[24m624 
## [90m30[39m BTC    2020-11-12 [90m14:00:00[39m    [4m1[24m[4m5[24m995.          [4m1[24m[4m5[24m888.           [4m1[24m[4m5[24m552.
## [90m# … with 1 more variable: target_price_24h [3m[90m<dbl>[90m[23m[39m
```

Reading the code shown above is less than ideal. One of the more popular tools introduced by the [tidyverse](https://www.tidyverse.org/) is the [**%>%**]{style="color: purple;"} operator, which works by starting with the object/data you want to make changes to first, and then apply each transformation step by step. It's simply a way of re-writing the same code in a way that is easier to read by splitting the way the function is called rather than adding functions onto each other into a single line that becomes really hard to read. In the example above it becomes difficult to keep track of where things begin, the order of operations, and the parameters associated with the specific functions. Compare that to the code below:


```r
# Start with the object/data to manipulate
cryptodata %>% 
  # Filter the data to only the BTC symbol
  filter(symbol == 'BTC') %>% 
  # Select columns to display
  select(ts_index, price_usd, lagged_price_1h, lagged_price_24h, target_price_24h) %>% 
  # Show the last 30 elements of the data
  tail(30) %>% 
  # Show all 30 elements instead of the default 10 for a tibble dataframe
  print(n = 30)
```

```
## [90m# A tibble: 30 x 6[39m
## [90m# Groups:   symbol [1][39m
##    symbol ts_index            price_usd lagged_price_1h lagged_price_24h
##    [3m[90m<chr>[39m[23m  [3m[90m<dttm>[39m[23m                  [3m[90m<dbl>[39m[23m           [3m[90m<dbl>[39m[23m            [3m[90m<dbl>[39m[23m
## [90m 1[39m BTC    2020-11-11 [90m09:00:00[39m    [4m1[24m[4m5[24m398.          [4m1[24m[4m5[24m402.           [4m1[24m[4m5[24m370.
## [90m 2[39m BTC    2020-11-11 [90m10:00:00[39m    [4m1[24m[4m5[24m430.          [4m1[24m[4m5[24m398.           [4m1[24m[4m5[24m385.
## [90m 3[39m BTC    2020-11-11 [90m11:00:00[39m    [4m1[24m[4m5[24m589.          [4m1[24m[4m5[24m430.           [4m1[24m[4m5[24m309.
## [90m 4[39m BTC    2020-11-11 [90m12:00:00[39m    [4m1[24m[4m5[24m570.          [4m1[24m[4m5[24m589.           [4m1[24m[4m5[24m274.
## [90m 5[39m BTC    2020-11-11 [90m13:00:00[39m    [4m1[24m[4m5[24m624           [4m1[24m[4m5[24m570.           [4m1[24m[4m5[24m283.
## [90m 6[39m BTC    2020-11-11 [90m14:00:00[39m    [4m1[24m[4m5[24m552.          [4m1[24m[4m5[24m624            [4m1[24m[4m5[24m305.
## [90m 7[39m BTC    2020-11-11 [90m15:00:00[39m    [4m1[24m[4m5[24m634.          [4m1[24m[4m5[24m552.           [4m1[24m[4m5[24m220.
## [90m 8[39m BTC    2020-11-11 [90m16:00:00[39m    [4m1[24m[4m5[24m666.          [4m1[24m[4m5[24m634.           [4m1[24m[4m5[24m162.
## [90m 9[39m BTC    2020-11-11 [90m17:00:00[39m    [4m1[24m[4m5[24m752.          [4m1[24m[4m5[24m666.           [4m1[24m[4m5[24m243.
## [90m10[39m BTC    2020-11-11 [90m18:00:00[39m    [4m1[24m[4m5[24m869.          [4m1[24m[4m5[24m752.           [4m1[24m[4m5[24m312.
## [90m11[39m BTC    2020-11-11 [90m19:00:00[39m    [4m1[24m[4m5[24m802.          [4m1[24m[4m5[24m869.           [4m1[24m[4m5[24m266.
## [90m12[39m BTC    2020-11-11 [90m20:00:00[39m    [4m1[24m[4m5[24m805.          [4m1[24m[4m5[24m802.           [4m1[24m[4m5[24m299.
## [90m13[39m BTC    2020-11-11 [90m21:00:00[39m    [4m1[24m[4m5[24m712.          [4m1[24m[4m5[24m805.           [4m1[24m[4m5[24m285.
## [90m14[39m BTC    2020-11-11 [90m22:00:00[39m    [4m1[24m[4m5[24m814.          [4m1[24m[4m5[24m712.           [4m1[24m[4m5[24m376.
## [90m15[39m BTC    2020-11-11 [90m23:00:00[39m    [4m1[24m[4m5[24m783.          [4m1[24m[4m5[24m814.           [4m1[24m[4m5[24m365.
## [90m16[39m BTC    2020-11-12 [90m00:00:00[39m    [4m1[24m[4m5[24m685.          [4m1[24m[4m5[24m783.           [4m1[24m[4m5[24m295.
## [90m17[39m BTC    2020-11-12 [90m01:00:00[39m    [4m1[24m[4m5[24m610.          [4m1[24m[4m5[24m685.           [4m1[24m[4m5[24m473.
## [90m18[39m BTC    2020-11-12 [90m02:00:00[39m    [4m1[24m[4m5[24m640.          [4m1[24m[4m5[24m610.           [4m1[24m[4m5[24m433.
## [90m19[39m BTC    2020-11-12 [90m03:00:00[39m    [4m1[24m[4m5[24m618.          [4m1[24m[4m5[24m640.           [4m1[24m[4m5[24m393.
## [90m20[39m BTC    2020-11-12 [90m04:00:00[39m    [4m1[24m[4m5[24m628.          [4m1[24m[4m5[24m618.           [4m1[24m[4m5[24m405.
## [90m21[39m BTC    2020-11-12 [90m05:00:00[39m    [4m1[24m[4m5[24m658.          [4m1[24m[4m5[24m628.           [4m1[24m[4m5[24m370.
## [90m22[39m BTC    2020-11-12 [90m06:00:00[39m    [4m1[24m[4m5[24m747.          [4m1[24m[4m5[24m658.           [4m1[24m[4m5[24m369.
## [90m23[39m BTC    2020-11-12 [90m07:00:00[39m    [4m1[24m[4m5[24m793.          [4m1[24m[4m5[24m747.           [4m1[24m[4m5[24m357.
## [90m24[39m BTC    2020-11-12 [90m08:00:00[39m    [4m1[24m[4m5[24m856.          [4m1[24m[4m5[24m793.           [4m1[24m[4m5[24m402.
## [90m25[39m BTC    2020-11-12 [90m09:00:00[39m    [4m1[24m[4m5[24m786.          [4m1[24m[4m5[24m856.           [4m1[24m[4m5[24m398.
## [90m26[39m BTC    2020-11-12 [90m10:00:00[39m    [4m1[24m[4m6[24m043.          [4m1[24m[4m5[24m786.           [4m1[24m[4m5[24m430.
## [90m27[39m BTC    2020-11-12 [90m11:00:00[39m    [4m1[24m[4m5[24m704.          [4m1[24m[4m6[24m043.           [4m1[24m[4m5[24m589.
## [90m28[39m BTC    2020-11-12 [90m12:00:00[39m    [4m1[24m[4m5[24m770.          [4m1[24m[4m5[24m704.           [4m1[24m[4m5[24m570.
## [90m29[39m BTC    2020-11-12 [90m13:00:00[39m    [4m1[24m[4m5[24m888.          [4m1[24m[4m5[24m770.           [4m1[24m[4m5[24m624 
## [90m30[39m BTC    2020-11-12 [90m14:00:00[39m    [4m1[24m[4m5[24m995.          [4m1[24m[4m5[24m888.           [4m1[24m[4m5[24m552.
## [90m# … with 1 more variable: target_price_24h [3m[90m<dbl>[90m[23m[39m
```

There are several advantages to writing code *the* ***tidy*** *way*, but while some love it others hate it, so we won't force anyone to have to understand how the **%>%** operator works and we have stayed away from its use for the rest of the code shown, but we do encourage the use of this tool: https://magrittr.tidyverse.org/reference/pipe.html

</br>

Move on to the [next section](#visualization) ➡️ to learn some amazing tools to visualize data.

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

The most expensive cryptocurrency being shown, "" in this case, makes it difficult to take a look at any of the other ones. Let's try *zooming-in* on a single one by using the same code but making an adjustment to the [**data**]{style="color: blue;"} parameter to only show data for the cryptocurrency with the symbol **ETH**.

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

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-22-1.png" width="672" />

One particularly nice aspect of using the ggplot framework, is that we can keep adding as many elements and transformations to the chart as we would like with no limitations.

We will not save the result shown below this time, but to illustrate this point, we can add a new line showing a linear regression fit going through the data using **`stat_smooth(method = 'lm')`**. And let's also show the individual points in green. We could keep layering things on as much as we want:


```r
crypto_chart + 
        # Add linear regression line
        stat_smooth(method = 'lm', color='red') + 
        # Add points
        geom_point(color='dark green', size=0.8)
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-23-1.png" width="672" />

By not providing any [**method**]{style="color: blue;"} option, the [**stat_smooth()**]{style="color: green;"} function defaults to use the [**method**]{style="color: blue;"} called [**`loess`**, which shows the local trends](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/loess), while the **`lm`** model fits the best fitting linear regression line for the data as a whole. The results shown above were not used to overwrite the [**crypto_chart**]{style="color: blue;"} object.

Before doing some additional formatting to the [**crypto_chart**]{style="color: blue;"} object, let's show one more example adding a new [red]{style="color: red;"} line for the [**target_price_24h**]{style="color: blue;"} column which we will aim to [predict in the predictive modeling section](#predictive-modeling), as well as an [orange]{style="color: orange;"} line showing the price 3 days in the past using the column [**lagged_price_3d**]{style="color: blue;"}. Again, we are **not overwriting** the results for the [**crypto_chart**]{style="color: blue;"} object:

```r
crypto_chart + 
        # red line showing target
        geom_line(aes(x=date_time_utc, y = target_price_24h), color = 'red') + 
        # orange line showing price 3 days before
        geom_line(aes(x=date_time_utc, y = lagged_price_3d), color = 'orange')
```

<img src="CryptoResearchPaper_files/figure-html/chart_target_and_lagged-1.png" width="672" />

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

preserve4a23e4d338f52fea

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
crypto_chart +
        geom_mark_ellipse(aes(filter = price_usd == max(price_usd),
                              label = date_time_utc,
                              description = paste0('Price spike to $', price_usd))) +
        # Now the same to circle the minimum price:
        geom_mark_ellipse(aes(filter = price_usd == min(price_usd),
                              label = date_time_utc,
                              description = paste0('Price drop to $', price_usd)))
```

```
## Error: `scale_id` must not be `NA`
```

<img src="CryptoResearchPaper_files/figure-html/add_ggforce_annotations-1.png" width="672" />

When using the [**geom_mark_ellipse()**]{style="color: green;"} function we are passing the [**data**]{style="color: blue;"} argument, the [**label**]{style="color: blue;"} and the [**description**]{style="color: blue;"} through the [**aes()**]{style="color: green;"} function. We are marking two points, one for the minimum price during the time period, and one for the maximum price. For the first point we filter the data to only the point where the [**price_usd**]{style="color: blue;"} was equal to the **`max(price_usd)`** and add the labels accordingly. The same is done for the second point, but showing the lowest price point for the given date range.

Now view the new chart:


```r
crypto_chart
```

<img src="CryptoResearchPaper_files/figure-html/unnamed-chunk-24-1.png" width="672" />

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
```

```
## Error in seq.int(0, to0 - from, by): 'to' must be a finite number
```

```r
calendar_heatmap
```

```
## Error in eval(expr, envir, enclos): object 'calendar_heatmap' not found
```

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

