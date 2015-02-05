HTMLWidgets.widget({

    name: 'rpivotTable',

    type: 'output',

    initialize: function(el, width, height) {

	    return {}

    },

    renderValue: function(el, x, instance) {
	    x.data = HTMLWidgets.dataframeToD3(x.data);

	    var derivers = $.pivotUtilities.derivers;
      x.params.renderers = $.extend($.pivotUtilities.renderers)//, remove d3 for now
        //$.pivotUtilities.d3_renderers);

      $('#'+el.id).pivotUI(
      		x.data, x.params
      );

    },

    resize: function(el, width, height, instance) {

    }

});
