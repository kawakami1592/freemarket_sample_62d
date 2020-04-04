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














// カテゴリーボックスにデータがある場合の記述
  $(function(){
   
    // カテゴリーセレクトボックスのオプションを作成
  function categoryOption(category){
    var optionHtml = `<option value="${category.id}">${category.name}</option>`;
    return optionHtml;
  }

    //カテゴリ欄の親子孫の現在のvカテゴリー名を取得
    let parentCategoryName = $(".edit_parent_sell-collection_select__input").children("a").attr("id");
    console.log(parentCategoryName);
    let childrenCategoryName = $(".edit_child_sell-collection_select__input").children("a").attr("id");
    console.log(childrenCategoryName);
    let grandchildrenCategoryName = $(".edit_grandchild_sell-collection_select__input").children("a").attr("id");
    console.log(grandchildrenCategoryName);

    //Ajax用の変数準備(初期値はとりあえず１とするがあとで上書きとなります)
    let parentCategoryId = 1
    let childrenCategoryId  = 1
    let grandchildrenCategoryId  = 1

  //子カテゴリーボックス作成
    //ansestryより全子要素の呼び出し
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
                                          <option value="">${childrenCategoryName}</option>
                                          ${optionHtml}
                                        </select>
                                        <i class="fas fa-chevron-down"></i>
                                      </label>
                                    </div>`
      );
    })


    
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
                                          <option value="">${grandchildrenCategoryName}</option>
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
  });

});
















//     //選択された親カテゴリーのIDを取得
//     if (parentCategoryId == ''){
//       //親カテゴリーが空（初期値）の時
//       $('#edit_select-children-box').remove();
//       $('#editselect-grandchildren-box').remove();
//       //子と孫を削除するする
//     }else{
//       $.ajax({
//         url: '/items/category_children',
//         type: 'GET',
//         data: { parent_id: parentCategoryId },
//         dataType: 'json'
//       })
//       .done(function(category_children){
//         $('#edit_select-children-box').hide();
//         $('#edit_select-grandchildren-box').hide();
//         親が変更された時、子と孫を削除する
//         let optionHtml = '';
//         category_children.forEach(function(child){
//           optionHtml += categoryOption(child);
//           //option要素(プルダウンの要素)を作成する
//         });
//         $('#error-category').before(`<div class="sell-collection_select " id="select-children-box">
//                                         <label class="sell-collection_select__label" for="item_category_id">
//                                           <select class="sell-collection_select__input" id="category-select-children" required="required" name="item[category_id]">
//                                             <option value="">選択して下さい</option>
//                                             ${optionHtml}
//                                           </select>
//                                           <i class="fas fa-chevron-down"></i>
//                                         </label>
//                                       </div>`
//         );
      
//     })
    
//       .fail(function(){
//         alert('カテゴリー取得に失敗しました');
//       });
//     }
//     });
//   // });
//   // 子カテゴリー選択後のイベント
//   // $('#edit_select-children_box').on('load', '#category-select-children', function(){
   
//   $(function(){
//     // e.preventDefault();
//     // let childrenCategoryId = $('.edit_child_sell-collection_select__input').children('value');
//     let childrenCategoryId = $(".edit_child_sell-collection_select__input").children("a").attr("id");
//     console.log(childrenCategoryId);
//     //選択された子カテゴリーのIDを取得
//     if (childrenCategoryId == ''){
//       //子カテゴリーが空（初期値）の時
//       // $('#select-grandchildren-box').remove(); 
//       //孫以下を削除する
//     }else{
//       $.ajax({
//         url: '/items/category_grandchildren',
//         type: 'GET',
//         data: { child_id: childrenCategoryId },
//         dataType: 'json'
//       })
//       .done(function(category_grandchildren){
//         $('#select-grandchildren-box').remove();
//         //子が変更された時、孫を削除するする
//         let optionHtml = '';
//         category_grandchildren.forEach(function(grandchildren){
//           optionHtml += categoryOption(grandchildren);
//           //option要素を作成する
//         });
//         $('#error-category').before(`<div class="sell-collection_select " id="select-grandchildren-box">
//                                         <label class="sell-collection_select__label" for="item_category_id">
//                                           <select class="sell-collection_select__input" id="category-select-grandchildren" required="required" name="item[category_id]">
//                                             <option value="">選択して下さい</option>
//                                             ${optionHtml}
//                                           </select>
//                                           <i class="fas fa-chevron-down"></i>
//                                         </label>
//                                       </div>`
//         );
//       })
//       .fail(function(){
//         alert('カテゴリー取得に失敗しました');
//       });
//     }
//   });
// });



// // });