##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param imputed
##' @return
##' @author home
##' @export
logistics <- function(imputed, pre_rec) {

  logistic_rec <- pre_rec
  
  logistic_wfl <- make_workflow(pre_rec)
  
  vm_splits <- vfold_cv(imputed$train, strata = target, v=3)  
  
  grid <-
    parameters(num_comp(c(30, 45))) %>% 
    grid_regular(levels = c(5))
  
  all_cores <- parallel::detectCores(logical = FALSE) - 1
  
  library(doParallel)
  all_cores <- parallel::detectCores(logical = FALSE)
  registerDoParallel(cores = all_cores)

  tune_grid(
    logistic_wfl,
    vm_splits,
    grid = grid,
    metrics = metric_set(mcc, accuracy),
    control = control_grid(verbose = T, save_pred = T)
  )
}
