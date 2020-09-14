the_plan <-
  drake_plan(

   train = read_csv(file_in("data/Training.csv")),
   test = read_csv(file_in("data/Validation.csv")),
   
   cleaned = clean_data(train, test),
   
   preprocessed = pre_data(cleaned),
   
   EDA = target(
     command = {
       rmarkdown::render(knitr_in("doc/EDA.Rmd"))
       file_out("doc/EDA.html")
     }
   ),
   
   imputed = impute(preprocessed),
   
   pre_rec = make_rec(imputed),
   
   logistic_wfl = make_workflow(pre_rec),
   
   fit_logistics = logistics(imputed, pre_rec),
   
   fit_penalized = penalized(imputed, pre_rec),
   
   model_vm = target(
      command = {
         rmarkdown::render(knitr_in("doc/model.Rmd"))
         file_out("doc/model.html")
      }
   )
   

)
