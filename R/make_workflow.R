##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param pre_rec
##' @return
##' @author home
##' @export
make_workflow <- function(pre_rec) {

  logistic_mod <- multinom_reg(penalty=0, mixture = 0) %>% 
    set_mode("classification") %>% 
    set_engine("glmnet")
  
  logistic_wfl <- workflows::workflow() %>% 
    add_recipe(pre_rec) %>% 
    add_model(logistic_mod)
  
  logistic_wfl
}
