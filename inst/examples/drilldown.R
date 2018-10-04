library(rpivotTable)

# This example demonstrates connecting a custom function to the double-click event
# for table cells.

# if not using the subtotals plugin, use the following rendererOptions synax
rpivotTable(Titanic, 
            rows = c("Survived"), 
            cols = c("Sex"),
            rendererOptions = list(
                # these will be the rendering options passed to the "table" renderer
                table = list(
                # popup a list of the observations' genders associated with the cell that you double click on
                clickCallback = htmlwidgets::JS('function(e, value, filters, pivotData) {
                                             var names = [];
                                             pivotData.forEachMatchingRecord(filters,
                                             function(record){ names.push(record.Sex); });
                                             alert(names.join(\"\\n\"));
                                             }')))
        )

# if subtotals is true, then the rendererOptions's syntax should be the following 
rpivotTable(Titanic, 
            rows = c("Survived"), 
            cols = c("Sex"),
            rendererOptions = list(table = list(eventHandlers = list("click" = htmlwidgets::JS('function(e, value, filters, pivotData) {
                                var names = [];
                            pivotData.forEachMatchingRecord(filters,
                                function(record){ names.push(record.Sex); });
                            alert(names.join(\"\\n\"));
                            }')
                            ))),
            subtotals = T)