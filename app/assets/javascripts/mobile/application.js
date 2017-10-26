// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-validate/jquery.validate.min
//= require jquery-validate/messages_zh
//= require jquery-validate/extend
//= require turbolinks
//= require bootstrap-sprockets
//= require underscore.min
//= require swiper.jquery.min
//= require ckeditor/init
//= require jquery.sidr.min
//= require cityselect
//= require layer.mobile
// other custom js file
//= require common
//= require map
//= require users


$(function(){

  $('#gugnnModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var title = button.data('title'); // Extract info from data-* attributes
    var ajax_url = button.data('ajax_url'); // Extract info from data-* attributes
    var ajax_callback = button.data('ajax_callback'); // Extract info from data-* attributes
    var modal = $(this);
    modal.find('.modal-title').text(title);
    modal.find('.modal-body').load(ajax_url, function(){eval(ajax_callback);});
  });

  if( $('.gg-slider .swiper-container').is('*'))
  {
    var swiper = new Swiper('.gg-slider .swiper-container', {
      autoplay : 5000
    });
  }
  if( $('.gg-categories .swiper-container').is('*'))
  {
    $('.gg-categories .swiper-container').each(function(){
      var swiper = new Swiper(this, {
        slidesPerView: 2,
      });
    });
  }

  if( $('.show-category .swiper-container').is('*'))
  {
    $('.show-category .swiper-container').each(function(){
      var swiper = new Swiper(this, {
        slidesPerView: 2,
      });
    });
  }

  $('.gg-menu-toggle').sidr(
    { name: 'gg-menu',
      displace: false,
      onOpen: function(){ $('.gg-overlay').show();},
      onCloseEnd: function(){ $('.gg-overlay').hide();}
    }
  );
  $("body").on( 'click','.gg-overlay',function(){
    $.sidr( 'close', 'gg-menu');
  })
  //为了页面加载时美观，页面加载时，隐藏gg-menu，sidr初始化成功后，去除 class: hide
  $('#gg-menu').removeClass('gg-hide');

  $('.selectCategoryBtn').click(function(){
    var selectCategory = layer.open({
      type: 1,
      content: $('.select-category').html(),
      style: 'position:fixed; left:0; top:0; width:100%; height:100%; border: none; overflow-y:auto;-webkit-animation-duration: .5s; animation-duration: .5s;'
    });
    //layer.full(selectCategory);

    $('.layui-m-layer').on('click', '.category .name', function(e){
      e.preventDefault();
      var title = $(this).data('title');
      var id =  $(this).data('id');
      $('.selectCategoryBtn .title').text( title);
      $('#gg-search-form').prop('action', Gugnn.routes.build_category_path( id));
      layer.close(selectCategory);
    })
    $('.layui-m-layer').on('click', '.layui-close-btn', function(e){
      layer.closeAll();
    })
  })
  $('.selectCityBtn').click(function(){
    var selectCategory = layer.open({
      type: 1,
      content: $('.select-city').html(),
      style: 'position:fixed; left:0; top:0; width:100%; height:100%; border: none; -webkit-animation-duration: .5s; animation-duration: .5s;'
    });
    //layer.full(selectCategory);
    $('.layui-m-layer').on('click', '.city .name', function(e){
      e.preventDefault();
      var title = $(this).data('title');
      var id =  $(this).data('id');
      $('.selectCityBtn .title').text( title);
      $('#city').val(title);
      layer.close(selectCategory);

    })
    $('.layui-m-layer').on('click', '.layui-close-btn', function(e){
      layer.closeAll();
    })
  })

  // base on bootstrap dropdown,
  $('.toggle-dropdown').on('click', function(e){
    e.preventDefault();
    $(this).parent('.dropdown').toggleClass('open');

  })
  //验证是否选择了分类
  //$('#gg-search-form').on('submit',function(){
  //  alert('before submit');
  //  return false;
  //})
});

function verification_code_time(code_id, wait) {
  var code_button = $("#"+code_id);
  if (wait == 0) {
    code_button.removeAttr("disabled");
    code_button.val("获取验证码");
  } else {
    code_button.attr("disabled", true);
    code_button.html("重新发送(" + wait + ")");
    wait = wait-1;
    setTimeout(function() {
      verification_code_time(code_id, wait)
    },
    1000)
  }
}
