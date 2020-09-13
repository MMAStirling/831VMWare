##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param imputed
##' @return
##' @author home
##' @export
make_rec <- function(imputed) {

  resample_rec <- recipe(target ~ . , data = imputed$train) %>% 
    step_smote(target)
  
  logistic_rec <- resample_rec %>% 
    step_pca(all_predictors(), num_comp = tune())

  logistic_rec
}
