$(document).on('turbolinks:load', function(){
  
  // const uploadDropBox = '#sell-main__upload-drop-box';

  // 画像アップロード時プレビュー表示
  $('#item_images').on('change', function(e){
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
          if (itemLength == 10) {
            return false;
          } else {
          $('#output-box').children('label').before(`<li class="sell-main__upload-item">
                                                      <figure class="sell-main__upload-figure sell-main__upload-figure--square">
                                                        <img src='${e.target.result}' title='${file.name}'>
                                                      </figure>
                                                      <div class="sell-main__upload-button">
                                                        <a class="sell-main__upload-edit" href="">編集
                                                        </a><a class="sell-main__delete-image">削除
                                                        </a>
                                                      </div>
                                                    </li>`);

        }}
      })(file);
      reader.readAsDataURL(file);
    });
  });
});