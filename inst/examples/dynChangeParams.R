library(shiny)
library(magrittr)
library(rpivotTable)

# based on radio button selection selects the list with specific parameter types
pivot_switch_fn <- function(l_in, type) {
  switch(type,
         choice1 = l_in$l1,
         choice2 = l_in$l2)
}


d_in = data.frame(grp_var1 = rep(letters[1:5], times = 6),
                  grp_var2 = rep(letters[6:8], times = 10),
                  grp_var3 = rep(letters[9:10], times = 15),
                  metric1 = sample.int(n = 100, size = 30),
                  metric2 = sample.int(n = 100, size = 30),
                  metric3 = sample.int(n = 100, size = 30))

l1 = list(l_rows = "grp_var1", 
          l_cols = "grp_var2", 
          l_val = "metric1",
          l_aggregatorName = "Sum",
          l_rendererName = "Table")

l2 = list(l_rows = "grp_var2", 
          l_cols = "grp_var1", 
          l_val = "metric2",
          l_aggregatorName = "Count",
          l_rendererName = "Table Barchart")

l_in = list(l1 = l1, 
            l2 = l2)

rb_levels = list(`Choice 1` = "choice1",
                 `Choice 2` = "choice2")

server = function(input, output) {
  
  output$pivot_setting_rb = renderUI({
    radioButtons(inputId = "pivot_setting", label = "Shortcuts", 
                 choices  = rb_levels)
  })
  
  output$test <- rpivotTable::renderRpivotTable({
    if(length(input$pivot_setting) == 0) return()
    ls = pivot_switch_fn(l_in, input$pivot_setting)
    # print(ls)
    
    ls %$%
      rpivotTable(data = d_in, 
                  rows = l_rows,
                  cols = l_cols,
                  val = l_val,
                  aggregatorName = l_aggregatorName,
                  rendererName = l_rendererName)
    
  })
}

ui =  fluidPage(
  uiOutput("pivot_setting_rb"), br(),br(),br(),
  rpivotTableOutput("test")
) 


shinyApp(ui = ui, server = server, options = list(height = '3000px', width = '100%'))
