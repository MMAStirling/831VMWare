##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param cleaned
pre_data <- function(cleaned) {

  train_df <- cleaned$train
  
  rec <- recipe(target ~ ., train_df ) %>%
    
    # These step deals with characters
    ## convert to factors
    step_string2factor(all_nominal(), -all_outcomes()) %>% 
    ## Lump together minority levels
    step_other(all_nominal(), -all_outcomes(), threshold = .1, other = "others") %>%
    ## create novel factor levels
    step_novel(all_nominal(), -all_outcomes()) %>% 
    ## convert strings to dummies
    step_dummy(all_nominal(), -all_outcomes()) %>% 
    prep
  
  list(
    train = rec %>%  juice,
    test = cleaned$test %>% bake(rec, new_data = .)
  )

}
