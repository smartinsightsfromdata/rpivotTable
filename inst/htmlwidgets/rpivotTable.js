HTMLWidgets.widget({

    name: 'rpivotTable',

    type: 'output',

    initialize: function(el, width, height) {

	    return {}

    },

    renderValue: function(el, x, instance) {
	    x.data = HTMLWidgets.dataframeToD3(x.data);

	    var derivers = $.pivotUtilities.derivers;
      var renderers = $.extend($.pivotUtilities.renderers,
        $.pivotUtilities.d3_renderers);

      $('#'+el.id).pivotUI(
      		x.data,
      		{
      		    renderers: renderers
      		}
      );

    },

    resize: function(el, width, height, instance) {

    }

});
