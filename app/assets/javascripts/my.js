//= require application
//= require fileupload_custom
//= require cropper
//= require avatar.js
//= require util/ajax_spinner.js

var CurrentMap=null;
$(function(){
  $(".dropdown-toggle").dropdown();
  if( $('#product_city').is('*'))
  {
    new Vcity.CitySelector({input:'product_city'});
  }
  $(document).on('show.bs.modal', '#gugnnModal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var title = button.data('title'); // Extract info from data-* attributes
    var ajax_url = button.data('ajax_url'); // Extract info from data-* attributes
    var ajax_callback = button.data('ajax_callback'); // Extract info from data-* attributes
    var modal = $(this);
    modal.find('.modal-title').text(title);
    modal.find('.modal-body').load(ajax_url, function(){eval(ajax_callback);});
  });

  // 用户选择系统头像
  $("#systemImgBox img").click(function(){
    var image_url = $(this).attr('src');
    $("#defaultImgLiBorder img").attr("src", image_url);
    $("#user_avatar_remote_url").val(image_url);
  });

  // change password form validate
  $("#change_password_form").validate({
    rules: {
      'user[current_password]': {
        required: true,
        isPassword: true,
        rangelength:[6,15]
      },
      'user[password]': {
        required: true,
        isPassword: true,
        rangelength:[6,15]
      },
      'user[password_confirmation]': {
        required: true,
        equalTo: '#change_password_form #user_password'
      },
    },
    errorPlacement:function(error,element) {
      var position = element.position();
      error.css({
        "position" : "absolute",
        "line-height" : "15px",
        "font-weight" : "normal",
        "top" : position.top+34,
        "left": position.left,
        "color": "red"
      })
      error.appendTo(element.parent());
    }

  });

  // change profile form validate
  $("#change_profile_form").validate({
    rules: {
      'user[nickname]': {
        required: true,
        stringCheck: true,
        byteRangeLength:[2,16]
      },
      'user[cellphone]': {
        required: true,
        isMobile: true
      },
      'user[verification_code]': {
        //required: true,
        rangelength:[5,6]
      },
    },
    errorPlacement:function(error,element) {
      var position = element.position();
      error.css({
        "position" : "absolute",
        "line-height" : "15px",
        "font-weight" : "normal",
        "top" : position.top+34,
        "left": position.left,
        "color": "red"
      })
      error.appendTo(element.parent());
    }

  });

  // authentication form validate
  $("#authentication_form").validate({
    rules: {
      'user[shop_name]': {
        required: true,
        stringCheck: true,
        rangelength:[6,50]
      },
      'user[id_number]': {
        required: true,
        isIdCardNo: true
      },
      //'user[id_photo]': {
      //  required: true,
      //},
      //'user[licence_photo]': {
      //  required: true,
      //},
      'user[city]': {
        required: true,
        rangelength:[2,10]
      },
      'user[shop_address]': {
        required: true,
        rangelength:[6,20]
      },
      'user[contact_person]': {
        required: true,
        rangelength:[2,10]
      },
      'user[contact_phone]': {
        required: true,
        //isTel: true
      },
    },
    errorPlacement:function(error,element) {
      var position = element.position();
      error.css({
        "position" : "absolute",
        "line-height" : "15px",
        "font-weight" : "normal",
        "top" : position.top+34,
        "left": position.left,
        "color": "red"
      })
      error.appendTo(element.parent());
    }

  });

//product_form validate
  $("#new_product").validate({
    rules: {
      'product[title]': {
        required: true,
        rangelength:[6,50]
      },
      'product[desc]': {
        rangelength:[10,2000]
      },
      'product[price]': {
        required: true,
        digits:true,
        min:0
      },
      'product[address]': {
        rangelength:[6,20]
      },
    },
    errorPlacement:function(error,element) {
      var position = element.position();
      error.css({
        "position" : "absolute",
        "line-height" : "15px",
        "font-weight" : "normal",
        "top" : position.top+34,
        "left": position.left,
        "color": "red"
      })
      error.appendTo(element.parent());
    }
  });


});

function toggle_category(category_id){
  $(".cat").removeClass("active");
  $("#cat_"+category_id).addClass("active");
  $(".sub_cat").hide();
  $("#sub_cat_"+category_id).show();
}

function cancel_file(index){
  var input_num = $("#selected_files").children().length+$(".files").children(".existed_image").length;
  $("#product_images_attributes_"+index+"_photo").remove();
  $("#product_images_attributes_"+index+"_photo_img").remove();
  for(var i=index+1; i<=input_num; i++){
    $("#product_images_attributes_"+i+"_photo").prop('name',"product[images_attributes]["+(i-1)+"][photo]").prop('id',"product_images_attributes_"+(i-1)+"_photo")
    document.getElementById("product_images_attributes_"+(i-1)+"_photo").setAttribute("onchange","load_image(this.files[0], 'product_images_attributes_"+(i-1)+"_photo');");
    $("#product_images_attributes_"+i+"_photo_img").prop('id',"product_images_attributes_"+(i-1)+"_photo_img");
  }
}

function delete_file(index, image_id){
  $("#product_images_attributes_"+index+"__destroy").val("true");
  $("#image_"+image_id).hide();
}

function build_formdata_ajax(form_id, formdata){
  $.ajax({type:$("#"+form_id).attr("method"), data:formdata, url:$("#"+form_id).attr("action"), dataType:'script', processData: false, contentType:false});
}

function resize_image(form_id, imgtag_name, image_id){
  var formElement = document.getElementById(form_id);
  var formData = new FormData(formElement);
  if($("#"+image_id).length > 0){

    var file_tag_name = imgtag_name;
    var $file = $("[name='"+file_tag_name+"']");
    formData.set(file_tag_name, $file.data('blob'), $file.val());
    build_formdata_ajax(form_id, formData)

  }else{
    build_formdata_ajax(form_id, formData)
  }

}

function load_image(file, image_id){
  //loadImage(
  //    file,
  //    function (img) {
  //      if($("#"+image_id+"_img")){
  //        $("#"+image_id+"_img").remove();
  //      }
  //      img.setAttribute("id",image_id+"_img");
  //      //img.setAttribute("style","display:none");
  //      document.body.appendChild(img);
  //    },
  //    {maxWidth: 800} // Options
  //);

}

$(function () {
  //https://stackoverflow.com/questions/21128634/jquery-file-upload-preview-image
  //https://github.com/blueimp/jQuery-File-Upload/wiki/Client-side-Image-Resizing
  // Enable image resizing, except for Android and Opera,
  // which actually support image resizing, but fail to
  // send Blob objects via XHR requests:
  // 上传出租信息图片
  $('.fileupload').fileupload({
    downloadTemplateId: null,
    uploadTemplateId: 'template-upload',
    replaceFileInput: false,
    previewMaxWidth:270,
    previewMaxHeight: 160,
    //imageCrop: false,
    dropZone: null, //enable it later
    disableImageResize: false,
    processQueuex: [
        {
            action: 'loadImage',
            fileTypes: /^image\/(gif|jpeg|png)$/,
            maxFileSize: 1000000 // 1MB
        },
        {
            action: 'resizeImage',
            maxWidth: 1280,
            maxHeight: 1024
        },
        {action: 'saveImage'},
    ]
  }).bind('fileuploadprocessdone', function (e, data) {
    var i = data.index, blob = data.files[i];
    $(data.fileInput[i]).data('blob', blob);
  });

  //上传头像
  //$('.upload-avatar').fileupload({
  //    downloadTemplateId: false,
  //    replaceFileInput: false,
  //    previewMaxWidth:140,
  //    previewMaxHeight:140,
  //    //imageCrop: false,
  //    //previewCanvas: false,
  //    dropZone: $(this), //enable it later
  //    disableImageResize: false,
  //    processQueuex: [
  //        {
  //            action: 'loadImage',
  //            fileTypes: /^image\/(gif|jpeg|png)$/,
  //            maxFileSize: 1000000 // 1MB
  //        },
  //        {
  //            action: 'resizeImage',
  //            maxWidth: 1280,
  //            maxHeight: 1024
  //        },
  //        {action: 'saveImage'},
  //    ]
  //}).bind('fileuploadprocessdone', function (e, data) {
  //  var i = data.index, blob = data.files[i];
  //  $(data.fileInput[i]).data('blob', blob);
  //});

  if($("#user_avatar").length>0){
    document.getElementById('user_avatar').onchange = function (e) {
        load_image(e.target.files[0], 'user_avatar');
    };
  }
  if($("#user_id_photo").length>0){
    document.getElementById('user_id_photo').onchange = function (e) {
        load_image(e.target.files[0], 'user_id_photo');
    };
  }
  if($("#user_licence_photo").length>0){
    document.getElementById('user_licence_photo').onchange = function (e) {
        load_image(e.target.files[0], 'user_licence_photo');
    };
  }


  $('#change_profile_button').click(
    function (e) { resize_image("change_profile_form", "user[avatar]", "user_avatar_img");  }
  );

  $('#authentication_button').click(
    function (e) {
      if($("#user_licence_photo").length > 0){
        resize_image("authentication_form", "user[licence_photo]","user_licence_photo_img");
      }else{
        resize_image("authentication_form", "user[id_photo]","user_id_photo_img");
      }
    }
  );
  // 创建租赁信息
  $('#publish_product_button').click(
    function (e) {
      var form_id = "publish_product_form";
      if (! $("#publish_product_form").valid()) {
        return;
      }
      var formElement = document.getElementById(form_id);
      var formData = new FormData(formElement);
      var blobs =[];

      $("#selected_files input").each(function(i, element){
        var file_tag_name = "product[images_attributes]["+i+"][photo]";
        var $file = $("[name='"+file_tag_name+"']");
        formData.set(file_tag_name, $file.data('blob'), $file.val());
      });

      build_formdata_ajax(form_id, formData);

    }
  );

});
