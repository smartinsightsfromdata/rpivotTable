
HTMLWidgets.widget({

  name: 'rpivotTable',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required

   }

  },

  renderValue: function(el, x, instance) {
  //  console.log('el = '+el.id);

  //  console.log('x.data = '+JSON.stringify(x.data));
//    console.log('x.param = '+JSON.stringify(x.param));
x.data = HTMLWidgets.dataframeToD3(x.data) ;
//console.log('new x1 conv = '+x1);


$(function () {
    $('#'+el.id).pivotUI(

x.data, x.param );

});


},

  resize: function(el, width, height, instance) {

  }

});
