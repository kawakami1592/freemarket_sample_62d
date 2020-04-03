$(document).on('turbolinks:load', function(){
 
// 画像保存データがある場合の処理（商品編集画面で新規登録と同じ使用感での画像表示する処理）
$(function() {

  // 表示用のクラスの子要素のimgオブジェクトの中のsrcを取得(.attr('img')だとsrcとカスタムデータの２属性をもつオブジェクトになってしまい取得後の再表示が上手くいかない)
  let img = $('.editimage').children('img').attr('src');

  // imgオブジェクトの個数をimageLengthに指定
    let imageLength = $(".editimage").find("img").length;
    console.log(imageLength);

    // 以下で全ての既存画像に保存順にlabelLengthに名前をつけながらプレビュー表示する（.eachだと一括表示されているものは同じ番号としてlabelLengthに変化をつけられないのでfor文を使用）
    for (let i = 0; i < $(".editimage").find("img").length; i++) {
    let labelLength = $(".editimage").eq(i).data('index');
    console.log(labelLength);

  // プレビュー表示（最初に定義した変数imgでsrcを再表示させます）
  $('#image-input').before(`<li class="preview-image" id="upload-image${labelLength}" data-image-id="${labelLength}">
                              <figure class="preview-image__figure">
                              <img src='${img}' >
                              </figure>
                              <div class="preview-image__button">
                                <a class="preview-image__button__edit" href="">編集</a>
                                <a class="preview-image__button__delete" data-image-id="${labelLength}">削除</a>
                              </div>
                            </li>`);
                            $("#image-input>label").eq(-1).css('display','none');
                
  if (imageLength < 9) {
    // 表示されているプレビューが９以下なら、新たにinputを生成する
    $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
                                <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
                                <i class="fas fa-camera fa-lg"></i>
                              </label>`);
    };
  };
})
});