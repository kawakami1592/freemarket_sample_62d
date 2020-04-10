$(document).on('turbolinks:load',function(){
    $('img.thumb').click(function(){
        var selectedSrc = $(this).attr('src').replace(/^(.+)_thumb(\.gif|\.jpg|\.png+)$/, "$1"+"$2");
        $('img.mainImage').stop().fadeOut(50,
            function(){
                $('img.mainImage').attr('src',selectedSrc);
                $('img.mainImage').stop().fadeIn(200);
            });
        $(this).css({"border":"2px solid #ff5a71"});
    });
    $('img.thumb').mouseout(function(){
        $(this).css({"border":""});
    });
});