$(document).on('turbolinks:load', function(){
 
// 他のfuncでも使用するのでグローバル変数を定義
  // 登録済画像と新規追加画像を全て格納する配列（ビュー用）
  images = [];
  // 登録済画像データだけの配列（DB用）
  registered_images_ids = [];
  // 新規追加画像データだけの配列（DB用）
  new_image_files = [];
  // テーブルに既存でdeleteされた画像データに関する情報
  clickdelete_images = [];
  clickdelete_registered_images_ids = [];

  // 画像が選択された時プレビュー表示、inputの親要素のdivをイベント元に指定
  $('#image-input').on('change', function(e){

    //ファイルオブジェクトを取得する
    let files = e.target.files;
    new_image_files.push(files)
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
          let imageLength = $('#output-box').children('li').length;
          
          // 表示されているプレビューの数を数える
          
          let labelLength = $("#image-input>label").eq(-1).data('label-id');
          // #image-inputの子要素labelの中から最後の要素のカスタムデータidを取得

          // プレビュー表示
          $('#image-input').before(`<li class="preview-image" id="upload-image${labelLength}" data-image-id="${labelLength}">
                                      <figure class="preview-image__figure">
                                        <img src='${e.target.result}' title='${file.name}' >
                                      </figure>
                                      <div class="preview-image__button">
                                        <a class="preview-image__button__edit" href="">編集</a>
                                        <a class="preview-image__button__delete" data-image-id="${labelLength}">削除</a>
                                      </div>
                                    </li>`);
          $("#image-input>label").eq(-1).css('display','none');
          // 入力されたlabelを見えなくする
          if (imageLength < 9) {
            // 表示されているプレビューが９以下なら、新たにinputを生成する
            $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
                                        <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
                                        <i class="fas fa-camera fa-lg"></i>
                                      </label>`);
          };
        };
      })(file);
      reader.readAsDataURL(file);
    });
    console.log(new_image_files);

    // filter_registered_images_ids = registered_images_ids.filter(function(value) {
    //   return value !== clickdelete_registered_images_ids;
    // });
  });

  
  



// 画像保存データがある場合の処理（商品編集画面で新規登録と同じ使用感での画像表示する処理）
  // imgオブジェクトの個数をimageLengthに指定
  let imageLength = $(".editimage").find("img").length;

  // 以下で全ての既存画像に保存順にlabelLengthに名前をつけながらプレビュー表示する（.eachだと一括表示されているものは同じ番号としてlabelLengthに変化をつけられないのでfor文を使用）
  for (let i = 0; i < $(".editimage").find("img").length; i++) {
  let labelLength = $(".editimage").eq(i).data('index');

  // 表示用のクラスの子要素のimgオブジェクトの中のsrcを取得(.attr('img')だとsrcとカスタムデータの２属性をもつオブジェクトになってしまい取得後の再表示が上手くいかない)
  let img = $('#img-'+i).children('img').attr('src');

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




  // 配列にテーブル内の画像とインデックスを格納
  images.push(img)
  registered_images_ids.push(labelLength) 

// console.log(images);
console.log(registered_images_ids);

};








//削除ボタンが押された時
$(document).on('click', '.preview-image__button__delete', function(){
  

// イベント元のカスタムデータ属性の値を取得
let targetImageId = $(this).data('image-id');
 // 削除ボタンを押した画像を取得
let target_image = $(".preview-image__figure").children('img').attr('src');

// target_image_numが登録済画像の数以下の場合は登録済画像データの配列から削除、それより大きい場合は新たに追加した画像データの配列から削除
if(targetImageId < registered_images_ids.length) {
clickdelete_registered_images_ids.push(targetImageId) 
clickdelete_images.push(target_image)
}

$(`#upload-image${targetImageId}`).remove();
//プレビューを削除
$(`[for=item_images${targetImageId}]`).remove();
//削除したプレビューに関連したinputを削除

let imageLength = $('#output-box').children('li').length;
// 表示されているプレビューの数を数える

if (imageLength ==9) {
  let labelLength = $("#image-input>label").eq(-1).data('label-id');
  // 表示されているプレビューが９なら,#image-inputの子要素labelの中から最後の要素のカスタムデータidを取得
  $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
                              <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
                              <i class="fas fa-camera fa-lg"></i>
                            </label>`);
};

console.log(clickdelete_registered_images_ids);
console.log(clickdelete_images);



});





  
$('#edit_item').on('submit', function(e){
// console.log(registered_images_ids);
// console.log(files);
  filter_registered_images_ids = registered_images_ids.filter(i => clickdelete_registered_images_ids.indexOf(i) == -1)
  console.log(filter_registered_images_ids);
  // 通常のsubmitイベントを止める
  e.preventDefault();
  // images以外のform情報をformDataに追加
  var formData = new FormData($(this).get(0));

  // 登録済画像が残っていない場合は便宜的に0を入れる
  if (registered_images_ids.length == 0) {
    formData.append("registered_images_ids[ids][]", 0)
  // 登録済画像で、まだ残っている画像があればidをformDataに追加していく
  } else {
    registered_images_ids.forEach(function(registered_image){
      formData.append("registered_images_ids[ids][]", registered_image)
    });
  }

  // console.log(registered_images_ids);

  // 新しく追加したimagesがない場合は便宜的に空の文字列を入れる
  if (new_image_files.length == 0) {
    formData.append("new_images[images][]", " ")
  // 新しく追加したimagesがある場合はformDataに追加する
  } else {
    new_image_files.forEach(function(file){
      formData.append("new_images[images][]", file)
    });
  }

  $.ajax({
    url:         '/items/' + gon.item.id,
    type:        "PATCH",
    data:        formData,
    contentType: false,
    processData: false,
  })
});









// カテゴリーボックスにデータがある場合の記述
// カテゴリーセレクトボックスのオプション(親要素の選択肢)を作成
function categoryOption(category){
  var optionHtml = `<option value="${category.id}">${category.name}</option>`;
  return optionHtml;
}

  //カテゴリ欄の親子孫の現在のカテゴリー名を取得
  let parentid = $(".edit_parent_sell-collection_select__input").children("a").attr("id");
  let parentCategoryName = $(".edit_parent_sell-collection_select__input").children("a").attr("data-parentname");
  let childid = $(".edit_child_sell-collection_select__input").children("a").attr("id");
  let childrenCategoryName = $(".edit_child_sell-collection_select__input").children("a").attr("data-childname");
  let grandchildid = $(".edit_grandchild_sell-collection_select__input").children("a").attr("id");
  let grandchildrenCategoryName = $(".edit_grandchild_sell-collection_select__input").children("a").attr("data-grandchildname");

  //Ajax用の変数準備
  let parentCategoryId = parentid;
  let childrenCategoryId = childid;
  let grandchildrenCategoryId = grandchildid ;
  
  //親要素で選択されているものを表示
  $('#category-select-parent').val(parentid);

//子カテゴリーボックス作成
  //ansestryより全親要素の呼び出ししたものをitems#newと連結
  $.ajax({
    url: '/items/category_children',
    type: 'GET',
    data: { parent_id: parentCategoryId },
    dataType: 'json'
  })
  
  //呼び出したデータを使ってoption要素(プルダウンの要素)を作成する
  .done(function(category_children){ 
    let optionHtml = '';
    category_children.forEach(function(child){
      optionHtml += categoryOption(child);
    });
    $('#error-category').before(`<div class="sell-collection_select " id="select-children-box">
                                    <label class="sell-collection_select__label" for="item_category_id">
                                      <select class="sell-collection_select__input" id="category-select-children" required="required" name="item[category_id]">
                                        <option value="${childid}">${childrenCategoryName}</option>
                                        ${optionHtml}
                                      </select>
                                      <i class="fas fa-chevron-down"></i>
                                    </label>
                                  </div>`
    );

//孫カテゴリーボックス作成
  //ansestryより全孫要素の呼び出し
  $.ajax({
      url: '/items/category_grandchildren',
      type: 'GET',
      data: { child_id: childrenCategoryId },
      dataType: 'json'
    })

  //呼び出したデータを使ってoption要素(プルダウンの要素)を作成する
  .done(function(category_grandchildren){
      let optionHtml = '';
      category_grandchildren.forEach(function(grandchildren){
        optionHtml += categoryOption(grandchildren);
    });
    $('#error-category').before(`<div class="sell-collection_select " id="select-grandchildren-box">
                                    <label class="sell-collection_select__label" for="item_category_id">
                                      <select class="sell-collection_select__input" id="category-select-grandchildren" required="required" name="item[category_id]">
                                        <option value="${grandchildid}">${grandchildrenCategoryName}</option>
                                        ${optionHtml}
                                      </select>
                                      <i class="fas fa-chevron-down"></i>
                                    </label>
                                  </div>`
                                );
                              })

//エラーハンドリング
.fail(function(){
    alert('カテゴリー取得に失敗しました');
  });
});


//販売価格
  var price = $('.sell-container__content__price__form__label').children('a').attr('id');
  $("#item_price").val(price);
  //文字列にしないようにvalのなかをクォーテーションで囲まない


  //消費税計算
  if (price >= 300 && price <= 9999999){
    let fee = Math.floor(price * 0.1);
    // 小数点以下切り捨て
    let profit = (price - fee);
    $('.sell-container__content__commission__right').text('¥'+fee.toLocaleString());
    // 対象要素の文字列書き換える
    $('.sell-container__content__profit__right').text('¥'+profit.toLocaleString());
  } else{
    $('.sell-container__content__commission__right').html('ー');
    $('.sell-container__content__profit__right').html('ー');
  }


// f.text_areaの文字数カウント
let txtcount = $("textarea").val().length;
$("#word-count").text(txtcount);




































































  // //削除ボタンが押された時
  // $(document).on('click', '.preview-image__button__delete', function(images,registered_images_ids){
    

  //   // イベント元のカスタムデータ属性の値を取得
  //   let targetImageId = $(this).data('image-id');
  //    // 削除ボタンを押した画像を取得
  //   let target_image = $(".preview-image__figure").children('img').attr('src');   
  //   console.log(target_image);
  //   console.log(targetImageId);
  //       let images = [images]
  //   console.log(images);
  //   // 対象の画像を削除した新たな配列を生成
  //   images.splice(targetImageId, 1);
  //   // target_image_numが登録済画像の数以下の場合は登録済画像データの配列から削除、それより大きい場合は新たに追加した画像データの配列から削除
  //   if (targetImageId < registered_images_ids.length) {
  //   registered_images_ids.splice(targetImageId, 1);}
  //   console.log(registered_images_ids);


  //   $(`#upload-image${targetImageId}`).remove();
  //   //プレビューを削除
  //   $(`[for=item_images${targetImageId}]`).remove();
  //   //削除したプレビューに関連したinputを削除

  //   let imageLength = $('#output-box').children('li').length;
  //   // 表示されているプレビューの数を数える

  //   if (imageLength ==9) {
  //     let labelLength = $("#image-input>label").eq(-1).data('label-id');
  //     // 表示されているプレビューが９なら,#image-inputの子要素labelの中から最後の要素のカスタムデータidを取得
  //     $("#image-input").append(`<label for="item_images${labelLength+1}" class="sell-container__content__upload__items__box__label" data-label-id="${labelLength+1}">
  //                                 <input multiple="multiple" class="sell-container__content__upload__items__box__input" id="item_images${labelLength+1}" style="display: none;" type="file" name="item[images][]">
  //                                 <i class="fas fa-camera fa-lg"></i>
  //                               </label>`);
  //   };
  // });

  // f.text_areaの文字数カウント
  $("textarea").keyup(function(){
    let txtcount = $(this).val().length;
    $("#word-count").text(txtcount);
  });

  //販売価格入力時の手数料計算
  $('#item_price').keyup(function(){
    let price= $(this).val();
    if (price >= 300 && price <= 9999999){
      let fee = Math.floor(price * 0.1);
      // 小数点以下切り捨て
      let profit = (price - fee);
      $('.sell-container__content__commission__right').text('¥'+fee.toLocaleString());
      // 対象要素の文字列書き換える
      $('.sell-container__content__profit__right').text('¥'+profit.toLocaleString());
    } else{
      $('.sell-container__content__commission__right').html('ー');
      $('.sell-container__content__profit__right').html('ー');
    }
  });

  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function categoryOption(category){
      var optionHtml = `<option value="${category.id}">${category.name}</option>`;
      return optionHtml;
    }
    // 親カテゴリー選択後のイベント
    $('#category-select-parent').on('change', function(){
      let parentCategoryId = $(this).val();
      //選択された親カテゴリーのIDを取得
      if (parentCategoryId == ''){
        //親カテゴリーが空（初期値）の時
        $('#select-children-box').remove();
        $('#select-grandchildren-box').remove();
        //子と孫を削除するする
      }else{
        $.ajax({
          url: '/items/category_children',
          type: 'GET',
          data: { parent_id: parentCategoryId },
          dataType: 'json'
        })
        .done(function(category_children){
          $('#select-children-box').remove();
          $('#select-grandchildren-box').remove();
          //親が変更された時、子と孫を削除するする
          let optionHtml = '';
          category_children.forEach(function(child){
            optionHtml += categoryOption(child);
            //option要素を作成する
          });
          $('#error-category').before(`<div class="sell-collection_select " id="select-children-box">
                                          <label class="sell-collection_select__label" for="item_category_id">
                                            <select class="sell-collection_select__input" id="category-select-children" required="required" name="item[category_id]">
                                              <option value="">選択して下さい</option>
                                              ${optionHtml}
                                            </select>
                                            <i class="fas fa-chevron-down"></i>
                                          </label>
                                        </div>`
          );
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        });
      }
    });
    // 子カテゴリー選択後のイベント
    $('.sell-container__content__details').on('change', '#category-select-children', function(){
      let childrenCategoryId = $(this).val();
      //選択された子カテゴリーのIDを取得
      if (childrenCategoryId == ''){
        //子カテゴリーが空（初期値）の時
        $('#select-grandchildren-box').remove(); 
        //孫以下を削除する
      }else{
        $.ajax({
          url: '/items/category_grandchildren',
          type: 'GET',
          data: { child_id: childrenCategoryId },
          dataType: 'json'
        })
        .done(function(category_grandchildren){
          $('#select-grandchildren-box').remove();
          //子が変更された時、孫を削除するする
          let optionHtml = '';
          category_grandchildren.forEach(function(grandchildren){
            optionHtml += categoryOption(grandchildren);
            //option要素を作成する
          });
          $('#error-category').before(`<div class="sell-collection_select " id="select-grandchildren-box">
                                          <label class="sell-collection_select__label" for="item_category_id">
                                            <select class="sell-collection_select__input" id="category-select-grandchildren" required="required" name="item[category_id]">
                                              <option value="">選択して下さい</option>
                                              ${optionHtml}
                                            </select>
                                            <i class="fas fa-chevron-down"></i>
                                          </label>
                                        </div>`
          );
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        });
      }
    });
  });


  // 各フォームの入力チェック
  $(function(){
    //画像
    $('#image-input').on('focus',function(){
      $('#error-image').text('');
      $('#image-input').on('blur',function(){
        $('#error-image').text('');
        let imageLength = $('#output-box').children('li').length;
        if(imageLength ==''){
          $('#error-image').text('画像がありません');
        }else if(imageLength >10){
          $('#error-image').text('画像を10枚以下にして下さい');
        }else{
          $('#error-image').text('');
        }
      });
    });

    //送信しようとした時
    $('form').on('submit',function(){
      let imageLength = $('#output-box').children('li').length;
      if(imageLength ==''){
        $('body, html').animate({ scrollTop: 0 }, 500);
        $('#error-image').text('画像がありません');
      }else if(imageLength >10){
        $('body, html').animate({ scrollTop: 0 }, 500);
        $('#error-image').text('画像を10枚以下にして下さい');
      }else{
        return true;
      }
    });

     //画像を削除した時
    $(document).on('click','.preview-image__button__delete',function(){
      let imageLength = $('#output-box').children('li').length;
      if(imageLength ==''){
        $('#error-image').text('画像がありません');
      }else if(imageLength >10){
        $('#error-image').text('画像を10枚以下にして下さい');
      }else{
        $('#error-image').text('');
      }
    });

    //商品名
    $('.sell-container__content__name').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-name').text('入力してください');
        $(this).css('border-color','red');
      }else{
        $('#error-name').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //商品説明
    $('.sell-container__content__description').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-text').text('入力してください');
        $(this).css('border-color','red');
      }else{
        $('#error-text').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //カテゴリーのエラーハンドリング
    function categoryError(categorySelect){
      let value = $(categorySelect).val();
      if(value == ""){
        $('#error-category').text('選択して下さい');
        $(categorySelect).css('border-color','red');
      }else{
        $('#error-category').text('');
        $(categorySelect).css('border-color','rgb(204, 204, 204)');
      }
    };
    //親カテゴリー
    $('#category-select-parent').on('blur',function(){
      categoryError('#category-select-parent')
    });
    //子カテゴリー
    $('.sell-container__content__details').on('blur', '#category-select-children', function(){
      categoryError('#category-select-children')
    });
    //孫カテゴリー
    $('.sell-container__content__details').on('blur', '#category-select-grandchildren', function(){
      categoryError('#category-select-grandchildren')
    });

    //状態
    $('#condition-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-condition').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-condition').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //送料負担
    $('#deliverycost-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-deliverycost').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-deliverycost').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //発送元
    $('#pref-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-pref').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-pref').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //発送までの日数
    $('#delivery_days-select').on('blur',function(){
      let value = $(this).val();
      if(value == ""){
        $('#error-delivery_days').text('選択して下さい');
        $(this).css('border-color','red');
      }else{
        $('#error-delivery_days').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });

    //価格
    $('.sell-container__content__price__form__box').on('blur',function(){
      let value = $(this).val();
      if(value < 300 || value > 9999999){
        $('#error-price').text('300以上9999999以下で入力してください');
        $(this).css('border-color','red');
      }else{
        $('#error-price').text('');
        $(this).css('border-color','rgb(204, 204, 204)');
      }
    });
  });  
});