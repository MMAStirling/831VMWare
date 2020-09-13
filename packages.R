## library() calls go here
library(conflicted)
library(dotenv)
library(drake)
library(tidyverse)
library(rmarkdown)
library(tidymodels)
library(themis)
library(skimr)

conflict_prefer("filter", "dplyr")

all_cores <- parallel::detectCores(logical = FALSE) - 1

library(doParallel)
all_cores <- parallel::detectCores(logical = FALSE)
registerDoParallel(cores = all_cores)

