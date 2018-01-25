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

      $('#'+el.id).pivotUI(x.data, x.params, true, x.locale);
    }
});
