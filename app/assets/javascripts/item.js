$(function() {
  $('#category').hover(
    function() {
      //カーソルが重なった時
      console.log("aa");
      $('.header__nav__left__list__categories__category').addClass('open');
    }, function() {
      //カーソルが離れた時
      $('.header__nav__left__list__categories__category').removeClass('open');
    }
  );
});