$(function() {
  $('.header__nav__left__list').hover(
    function() {
      $('.header__nav__left__list__categories__category').addClass('open');
    }, function() {
      $('.header__nav__left__list__categories__category').removeClass('open');
    }
  );
});