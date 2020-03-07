$(function() {
  $('.top-header__nav__left__list').hover(
    function() {
      $('.top-header__nav__left__list__categories__category').addClass('open');
    }, function() {
      $('.top-header__nav__left__list__categories__category').removeClass('open');
    }
  );
});

