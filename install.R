install.packages('pacman')
pacman::p_load('pins', 'skimr', 'DT', 'httr', 'jsonlite', # Data Exploration 
               'tidyverse', 'tsibble', 'anytime', # Data Prep
               'ggTimeSeries', 'gifski', 'av', 'magick', 'ggthemes', 'plotly', # Visualization
               'ggpubr', 'ggforce', 'gganimate', 'transformr', # Visualization continued
               'caret', 'doParallel', 'parallel', 'xgboost', # Predictive Modeling
               'gbm', 'deepnet', 'elasticnet', 'pls',  # Predictive Modeling continued
               'hydroGOF', 'formattable', 'knitr') # Evaluate Model Performance