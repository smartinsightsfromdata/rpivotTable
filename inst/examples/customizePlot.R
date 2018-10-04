library(rpivotTable)

MyColors <- c(rgb(186,150,155, maxColorValue=255), rgb(238,221,130, maxColorValue=255),
                      rgb(205,150,205, maxColorValue=255))

c3RenderOptions <- list(size = list(height=525, width=900),# change the size of the barchart
                  zoom = list(enabled=T), # add zooming
                  # use a custom color scheme
                  color = list(pattern=as.list(MyColors)))

rpivotTable(Titanic,
            rows = "Survived",
            cols = c("Sex"),
            rendererName = "Bar Chart",
            # pass options to the c3 renderer to customize the barchart
            rendererOptions = list(c3 = c3RenderOptions)
            )
