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

  logistic_mod <- logistic_reg() %>% 
    set_mode("classification") %>% 
    set_engine("glm")
  
  logistic_wfl <- workflows::workflow() %>% 
    add_recipe(pre_rec) %>% 
    add_model(logistic_mod)
  
  logistic_wfl
}
