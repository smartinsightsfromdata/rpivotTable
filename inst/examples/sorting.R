library(rpivotTable)

rpivotTable(HairEyeColor, 
            rows = c("Eye"), 
            cols = c("Hair"),
            rendererName = "Table Barchart",
            aggregatorName="Sum", vals="Freq",
            sorters = "
            function(attr) { 
            var sortAs = $.pivotUtilities.sortAs;
            if (attr == \"Hair\") { 
            return sortAs([\"Red\", \"Brown\", \"Blond\", \"Black\"]);
            } 
            }")

