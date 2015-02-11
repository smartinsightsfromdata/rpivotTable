library(rpivotTable)
library(data.table)

# canEldt <- fread(paste0("./inst/examples/", "canadaFctElections.csv"),header=T)
# save(canEldt,file="./inst/examples/canEldt.RData")
load(file="data/canEldt.RData")

canEldt$votes <- round(runif(nrow(canEldt), min=500, max=15000))

rpivotTable(data =   canEldt   ,  rows = c( "Party",    "Province"),
            vals = "votes", aggregatorName = "Sum", rendererName = "Treemap")
