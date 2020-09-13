##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param preprocessed
##' @return
##' @author home
##' @export
impute <- function(preprocessed) {

  imp_rec <- recipe(target ~ . , data = preprocessed$train) %>% 
    # step_bagimpute(all_predictors()) # my computer is too weak for this so for minimal working product
    # Model is already set, also dataset is too large otherwise should do all below in cross validation
    step_meanimpute(all_predictors()) %>% 
    # step_zv(all_predictors()) %>% due to computation resources I ran near zero variance instead
    step_nzv(all_predictors()) %>%

    step_BoxCox(all_numeric()) %>%
    step_center(all_numeric()) %>%
    step_scale(all_numeric())
  
  list(
  train = imp_rec %>% prep %>% juice,
  test  = imp_rec %>% 
    prep %>%
    bake(new_data = preprocessed$test)
  )
}
