$(document).on('turbolinks:load', function() {
  $(function(){
    $('.top-header__nav__left__list').on({
      'mouseenter' : function(){
        $('.top-header__nav__left__list__categories__category').addClass('open');
      },
      'mouseleave' : function(){
        $('.top-header__nav__left__list__categories__category').removeClass('open');
      }
    });
  })
})