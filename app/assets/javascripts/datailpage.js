$(document).on('turbolinks:load',function() {
    $('img.thumb').click(function(){
    // "_thumb"を削った画像ファイル名を取得
    var selectedSrc = $(this).attr('src').replace(/^(.+)_thumb(\.gif|\.jpg|\.png+)$/, "$1"+"$2");
    
    // 画像入れ替え
    $('img.mainImage').stop().fadeOut(50,
    function(){
    $('img.mainImage').attr('src', selectedSrc);
    $('img.mainImage').stop().fadeIn(200);
    }
    );
    // サムネイルの枠を変更
    $(this).css({"border":"2px solid #ff5a71"});
    });
    
    // マウスアウトでサムネイル枠もとに戻す
    $('img.thumb').mouseout(function(){
    $(this).css({"border":""});
    });
   });
// $(document).on('turbolinks:load',function(){
//     $('button').click(function(){
//         $("button").text("お気に入り１");
//     });
// });