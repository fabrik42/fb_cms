$(document).ready(function(){

  $("ul[data-collection='photos'] a").fancybox({
   'transitionIn'  : 'elastic',
   'transitionOut' : 'elastic',
   'titlePosition': 'over',
   'speedIn'   : 400,
   'speedOut'    : 200,
   'overlayShow' : false,
   cyclic: true
  });

});