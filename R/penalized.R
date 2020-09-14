##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param imputed
##' @param pre_rec
##' @return
##' @author home
##' @export
penalized <- function(imputed, pre_rec) {
  
  penalized_mod <- multinom_reg(penalty=tune(), mixture = tune()) %>% 
    set_mode("classification") %>% 
    set_engine("glmnet")
  
  penalized_wfl <- workflows::workflow() %>% 
    add_recipe(pre_rec) %>% 
    add_model(penalized_mod)
  
  vm_splits <- vfold_cv(imputed$train, strata = target, v=3)  
  
  grid <-
    parameters(num_comp(c(30, 45)), penalty(),mixture()) %>% 
    grid_regular(levels = c(5,5,5))
  
  all_cores <- parallel::detectCores(logical = FALSE) - 1
  
  library(doParallel)
  all_cores <- parallel::detectCores(logical = FALSE)
  registerDoParallel(cores = all_cores)
  
  tmp <- tune_grid(
    penalized_wfl,
    vm_splits,
    grid = grid,
    metrics = metric_set(mcc, accuracy),
    control = control_grid(verbose = T, save_pred = T)
  )
  
  list(
    wfl = penalized_wfl,
    cv = tmp
  )

}
