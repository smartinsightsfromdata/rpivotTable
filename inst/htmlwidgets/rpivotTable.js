
HTMLWidgets.widget({

  name: 'rpivotTable',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required

   }

  },

  renderValue: function(el, x, instance) {
    console.log('el = '+el.id);
 //   console.log('x = '+JSON.stringify(x));

$(function () {
    $('#'+el.id).pivotUI(
x );
});


},

  resize: function(el, width, height, instance) {

  }

});
