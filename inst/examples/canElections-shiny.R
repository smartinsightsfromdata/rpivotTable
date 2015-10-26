library(rpivotTable)
library(shiny)
library(ggvis)
library(dplyr)

canData <- '
Candidate,Party,Province,Age,Gender
"Liu, Laurin",NDP,Quebec,22,Female
"Mourani, Maria",Bloc Quebecois,Quebec,43,Female
"Mars, Silvia",Bloc Quebecois,Quebec,34,Female
"Sellah, Djaouida",NDP,Quebec,,Female
"St-Denis, Lise",NDP,Quebec,72,Female
"Fry, Hedy",Liberal,British Columbia,71,Female
"Turmel, Nycole",NDP,Quebec,70,Female
"Sgro, Judy",Liberal,Ontario,68,Female
"Raynault, Francine",NDP,Quebec,67,Female
"Davidson, Patricia",Conservative,Ontario,66,Female
"Smith, Joy",Conservative,Manitoba,65,Female
"Wong, Alice",Conservative,British Columbia,64,Female
"ONeill Gordon, Tilly",Conservative,New Brunswick,63,Female
"Ablonczy, Diane",Conservative,Alberta,63,Female
"Duncan, Linda Francis",NDP,Alberta,63,Female
"Bennett, Carolyn",Liberal,Ontario,62,Female
"Nash, Peggy",NDP,Ontario,61,Female
"Mathyssen, Irene",NDP,Ontario,61,Female
"Sims, Jinny Jogindera",NDP,British Columbia,60,Female
"Foote, Judy",Liberal,Newfoundland,60,Female
"Crowder, Jean",NDP,British Columbia,60,Female
"Davies, Libby",NDP,British Columbia,59,Female
"Yelich, Lynne",Conservative,Saskatchewan,59,Female
"Day, Anne-Marie",NDP,Quebec,58,Female
"May, Elizabeth",Green,British Columbia,58,Female
"Murray, Joyce",Liberal,British Columbia,58,Female
"Findlay, Kerry-Lynne D.",Conservative,British Columbia,57,Female
"Brown, Lois",Conservative,Ontario,57,Female
"Boutin-Sweet, Marjolaine",NDP,Quebec,57,Female
"Crockatt, Joan",Conservative,Alberta,56,Female
"Chow, Olivia",NDP,Ontario,55,Female
"McLeod, Cathy",Conservative,British Columbia,55,Female
"Finley, Diane",Conservative,Ontario,55,Female
"LeBlanc, Helene",NDP,Quebec,54,Female
"Grewal, Nina",Conservative,British Columbia,54,Female
"Hughes, Carol",NDP,Ontario,54,Female
"Shea, Gail",Conservative,Prince Edward Island,53,Female
"Truppe, Susan",Conservative,Ontario,53,Female
"Young, Wai",Conservative,British Columbia,52,Female'
con <- textConnection(canData)
canadianElections <- read.csv(con, header=TRUE, stringsAsFactors = FALSE)
canadianElections$votes <- round(runif(nrow(canadianElections), min=500, max=15000))

# save(file="./data/canadianElections.rda",canadianElections )

ui = shinyUI(fluidPage(
  fluidRow( rpivotTableOutput("pivot")
  # , fluidRow( ggvisOutput("lgraph") )
)))

server = function(input, output, session) {
reactive({
  canadianElections %>% select(Province,Party,votes) %>% group_by(Party, Province) %>% summarise(votes=sum(votes)) -> candf
    ggvis(canadianElections, ~Province, ~votes, fill = ~ Party) %>%
      layer_bars(width=0.4) %>%  scale_nominal("fill")
}) %>%  bind_shiny("lgraph") 

  output$pivot <- renderRpivotTable({
    rpivotTable(data =   canadianElections   ,  rows = c( "Province"),cols="Party",
                vals = "votes", aggregatorName = "Sum", rendererName = "Table"
                , width="50%", height="550px")
  })
 
}

shinyApp(ui = ui, server = server)
