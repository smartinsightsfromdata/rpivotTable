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
      locale.renderers = $.extend({}, locale.renderers,
        locale.d3_renderers || $.pivotUtilities.d3_renderers,
        locale.c3_renderers || $.pivotUtilities.c3_renderers);

      // if subtotals then override renderers to add subtotals
      if(x.subtotals) {
        x.params.renderers = $.extend(
          $.pivotUtilities.subtotal_renderers,
          $.pivotUtilities.d3_renderers,
          $.pivotUtilities.c3_renderers
        );
        x.params.dataClass = $.pivotUtilities.SubtotalPivotData;
      }

      if (Array.isArray(x.params.aggregators) && x.params.aggregators.length == 1) {
        x.params.aggregators = Function('"use strict";return (' + x.params.aggregators[0] + ')')()
      }
      if (Array.isArray(x.params.renderers) && x.params.renderers.length == 1) {
        x.params.renderers = Function('"use strict";return (' + x.params.renderers[0] + ')')()
      }

      $('#'+el.id).pivotUI(x.data, x.params, true, x.locale);
    }
});
