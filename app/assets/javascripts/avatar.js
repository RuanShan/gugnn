$(document).ready( function(){

  //编辑头像
  $('#edit-user-avatar-btnx').on('click', function(){
    //弹出即全屏
    var index = layer.open({
      type: 1,
      content: $('#edit-avatar-container'),
      area: ['320px', '195px'],
      maxmin: true
    });
    layer.full(index);
  });
  // 点击头像上传提示
  $('.upload-avatar [data-toggle="tooltip"]').tooltip()
  // 点击头像弹出对话框
  $(".upload-avatar").click(function(){
        $("#edit-avatar-container").modal({ show: true});
  });

  // 初始化
  var $image = $('.avatar-image');
  $image.cropper({
      aspectRatio: '1',
      autoCropArea:0.8,
      preview: '.up-pre-after',

  });

  // 上传图片
  var $inputImage = $('.user-avatar');
  var URL = window.URL || window.webkitURL;
  var blobURL;
  // https://developer.mozilla.org/zh-CN/docs/Web/API/Window/URL
  if (URL) {
      $inputImage.change(function () {
          var files = this.files;
          var file;

          if (files && files.length) {
             file = files[0];

             if (/^image\/\w+$/.test(file.type)) {
                  blobURL = URL.createObjectURL(file);
                  $image.one('built.cropper', function () {
                      // Revoke when load complete
                     URL.revokeObjectURL(blobURL);
                  }).cropper('reset').cropper('replace', blobURL);
                  $inputImage.val('');
              } else {
                  window.alert('Please choose an image file.');
              }
          }

          // Amazi UI 上传文件显示代码
          var fileNames = '';
          $.each(this.files, function() {
              fileNames += '<span class="am-badge">' + this.name + '</span> ';
          });
          $('#file-list').html(fileNames);
      });
  } else {
      $inputImage.prop('disabled', true).parent().addClass('disabled');
  }
});


Gugnn.fn.rotateimgright= function( selector ) {
  $( selector ).cropper('rotate', 90);
}


Gugnn.fn.rotateimgleft= function( selector ) {
  $( selector ).cropper('rotate', -90);
}
