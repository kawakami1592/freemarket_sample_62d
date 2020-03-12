$(document).on('turbolinks:load', function(){
  
  // 画像が選択された時、プレビュー表示
  $('#output-box').on('change', function(e){
  
    //ファイルオブジェクトを取得する
    let files = e.target.files;
    $.each(files, function(index, file) {
      let reader = new FileReader();
      //画像でない場合は処理終了
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
      //アップロードした画像を設定する
      reader.onload = (function(file){
        return function(e){
          let itemLength = $('#output-box').children('li').length;
          // 選択されたファイルのプレビューの数を数える

          if (itemLength == 9) {
            $('[for=item_images9]').css('display','none');
            //10枚選択されたら終わり
            return false;
          } else {
          // プレビュー表示
          $('#output-box').children('#image-input').before(`<li class="upload-image${itemLength} id="asdf" data-image-id="${itemLength}">
                                                              <figure class="upload-image__figure">
                                                                <img src='${e.target.result}' title='${file.name}' width="100px" height="100px">
                                                              </figure>
                                                              <div class="upload-image__button">
                                                                <a class="upload-image__button__edit$" href="">編集</a>
                                                                <a class="upload-image__button__delete" data-image-id="${itemLength}">削除</a>
                                                              </div>
                                                            </li>`);
                                                            
          // 入力されたlabelを見えなくする or 表示されているlabelを見えなくする
          $(`[for=item_images${itemLength}]`).css('display','none');

          // 新たにinputを生成する
          $("#output-box").append(`<label for="item_images${itemLength+1}" class="sell-container__content__upload__items__box__label">
                                    <div class="sell-container__content__upload__items__box--have-item">
                                      <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${itemLength+1}" style="display: none;" type="file" name="item[images][]">
                                      <class="sell-container__content__upload__items__box__input__drop-box">
                                        <i class="fas fa-camera"></i>
                                        <pre class="sell-container__content__upload__items__box__input__drop-box__text">ドラッグアンドドロップ
                                        またはクリックしてファイルをアップロード</pre>
                                      </pre>
                                    </div>
                                  </label>`);
        }}
      })(file);
      reader.readAsDataURL(file);
    });
  });

  //削除ボタンが押された時
  $(document).on('click', '.upload-image__button__delete', function(){
    let targetImageId = $(this).data('image-id');
    // イベント元のカスタムデータ属性の値を取得
    
    $(`.upload-image${targetImageId}`).remove();
    //プレビューを削除

    $(`[for=item_images${targetImageId}]`).remove();
    //削除したプレビューに関連したinputを削除
    
    $('#output-box').children('li').length;
    // 表示されているプレビューの数を数える

    $(`[for=item_images${itemsLength+1}]`).attr('for', `item_images${targetImageId}`);
    $(`#item_images${itemsLength+1}`).attr('id', `item_images${targetImageId}`);
    //可視状態のフォームを取得し、forとidを削除したフォームのものにする


  });

  // f.text_areaの文字数カウント
  $(function () {
    $("textarea").keyup(function(){
      let txtcount = $(this).val().length;
      $("#word-count").text(txtcount);
    })
  });

});

