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
   )

)
