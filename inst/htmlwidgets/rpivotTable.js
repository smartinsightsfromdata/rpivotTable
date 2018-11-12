HTMLWidgets.widget({
    name: 'rpivotTable',
    type: 'output',
    initialize: function(el, width, height) {
	    return {};
    },
    resize: function(el, width, height, instance) { },

    renderValue: function(el, x, instance) {
	    x.data = HTMLWidgets.dataframeToD3(x.data);

      if (typeof x.params.sorters != "undefined") {
        if (typeof x.params.sorters[0] == "string") {
            x.params.sorters = eval("("+x.params.sorters[0]+")")
          }
      }

      if (typeof x.params.onRefresh != "undefined") {
        x.params.onRefresh = x.params.onRefresh[0];
      }

      var locale = $.pivotUtilities.locales[x.locale];


      if (!x.rendererLibraries.includes("core")) {
        locale.renderers = {};
      }
      if (x.rendererLibraries.includes("subtotals")) {
        locale.renderers = $.extend(locale.renderers, locale.subtotal_renderers || $.pivotUtilities.subtotal_renderers);
        x.params.dataClass = $.pivotUtilities.SubtotalPivotData;
      }
      if (x.rendererLibraries.includes("D3")) {
        locale.renderers = $.extend(locale.renderers, locale.d3_renderers || $.pivotUtilities.d3_renderers);
      }
      if (x.rendererLibraries.includes("C3")) {
        locale.renderers = $.extend(locale.renderers, locale.c3_renderers || $.pivotUtilities.c3_renderers);
      }
      if (x.rendererLibraries.includes("plotly")) {
        locale.renderers = $.extend(locale.renderers, locale.plotly_renderers || $.pivotUtilities.plotly_renderers);
      }
      if (x.rendererLibraries.includes("gchart")) {
        // In theory this should work, however for some reason the google.load request misbehaves
        /* $.ajax({
         *   async: false,
         *   dataType: "script",
         *   url: "https://www.google.com/jsapi"
         * });
         * google.load("visualization", "1", {packages:["corechart", "charteditor"]});
         */

        locale.renderers = $.extend(locale.renderers, locale.gchart_renderers || $.pivotUtilities.gchart_renderers);
      }
      if (x.rendererLibraries.includes("export")) {
        locale.renderers = $.extend(locale.renderers, locale.export_renderers || $.pivotUtilities.export_renderers);
      }


      $('#'+el.id).pivotUI(x.data, x.params, true, x.locale);
    }
});
