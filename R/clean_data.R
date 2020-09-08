##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param train
##' @param test
clean_data <- function(train, test) {

  init_steps <- . %>% 
    select(-X1, -indices) %>% 
    janitor::clean_names() %>% 
    mutate(target = target %>% as.factor()) %>% 
    mutate_if(is.character, ~ replace(.x, is.na(.x),"Missing"))
  
  train_cleaned <- train %>% 
    init_steps()
  
  missing_vars <- train_cleaned %>% 
    DataExplorer::profile_missing() %>% 
    arrange(desc(pct_missing)) %>% 
    filter(pct_missing>0.3) %>% 
    .$feature %>% 
    as.character()
  
  remove_missing <- . %>% 
    select(-tidyselect::all_of(missing_vars))
  
  list(
    train = train_cleaned %>% remove_missing,
    test = test %>% init_steps() %>% remove_missing()
  )

}
