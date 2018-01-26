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

      if(typeof(x.locale) === "undefined") x.locale = "en";

      var locale = $.pivotUtilities.locales[x.locale];
      locale.renderers = $.extend({}, locale.renderers,
        locale.d3_renderers || $.pivotUtilities.d3_renderers,
        locale.c3_renderers || $.pivotUtilities.c3_renderers);

      $('#'+el.id).pivotUI(x.data, x.params, true, x.locale);
    }
});
