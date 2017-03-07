$(document).ready(function () {

//--------------------------------------
  $("#ListSlider").owlCarousel({
    lazyLoad : false,
    navigation : true
  });
//--------------------------------------
  $("#VideoSlider").owlCarousel({
    items : 4,
    itemsCustom : false,
    itemsDesktop : [1199, 4],
    itemsDesktopSmall : [979, 4],
    itemsTablet : [768, 3],
    itemsTabletSmall : false,
    itemsMobile : [479, 2],
    singleItem : false,
    itemsScaleUp : false,
    lazyLoad : false,
    navigation : false,
    navigationText : false
  });
//--------------------------------------
  $(".SlideToggle").click(function () {
    $(this).parent().children('#firstpane').slideToggle();
    $(this).toggleClass('Up');
  });
//--------------------------------------
  $("#SliderCharitable").owlCarousel({
    items : 5,
    itemsCustom : false,
    itemsDesktop : [1199, 4],
    itemsDesktopSmall : [979, 3],
    itemsTablet : [768, 3],
    itemsTabletSmall : false,
    itemsMobile : [479, 2],
    singleItem : false,
    itemsScaleUp : false,
    slideSpeed : 100
  });
//--------------------------------------
});
//--------------------------------------
//--------------------------------------
//--------------------------------------
//--------------------------------------

//--------------------------------------
//--------------------------------------
//--------------------------------------
//--------------------------------------