HTMLWidgets.widget({

    name: 'rpivotTable',

    type: 'output',

    initialize: function(el, width, height) {

	    return {}

    },

    renderValue: function(el, x, instance) {
	    x.data = HTMLWidgets.dataframeToD3(x.data);

	    var derivers = $.pivotUtilities.derivers;
      var tpl = $.pivotUtilities.aggregatorTemplates;
      /* remove d3 for now to simplify for testing
           will add it back once the widget if fleshed out and tested
      x.params.renderers = $.extend($.pivotUtilities.renderers),
        $.pivotUtilities.d3_renderers);
      */

      $('#'+el.id).pivotUI(
      		x.data, x.params
      );

    },

    resize: function(el, width, height, instance) {

    }

});
