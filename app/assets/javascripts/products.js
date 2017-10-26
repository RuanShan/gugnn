// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){

  if($('.product-details').is('*'))
  {
    $('body').scrollspy({ target: '#navbar-product-details' })
    BindSwiperEvent();

  }
})

/*由于使用turbolinks, 事件绑定需要放在外面*/
function BindSwiperEvent()
{
    // 1. user move a slide. 2. user click a thumb, 3. user click nav
    var viewSwiper = new Swiper('.gallery-large.swiper-container', {
      onSlideChangeStart: function() {
        updateNavPosition()
      }
    })

    $('.gallery-large .arrow-left,.gallery-thumb .arrow-left').on('click', function(e) {
      e.stopPropagation();
      if (viewSwiper.activeIndex == 0) {
        viewSwiper.slideTo(viewSwiper.slides.length - 1, 1000);
        return false;
      }
      viewSwiper.slidePrev();

    })
    $('.gallery-large .arrow-right,.gallery-thumb .arrow-right').on('click', function(e) {
      e.stopPropagation();
      if (viewSwiper.activeIndex == viewSwiper.slides.length - 1) {
        viewSwiper.slideTo(0, 1000);
        return false;
      }
      viewSwiper.slideNext();

    })

    var previewSwiper = new Swiper('.gallery-thumb.swiper-container', {
      touchRatio: 0.2,
      visibilityFullFit: true,
      slidesPerView: 'auto',
      onlyExternal: true,
      onClick: function() {
      }
    })

    $('.gallery-thumb .swiper-slide').on('click',function(e){
      viewSwiper.slideTo(previewSwiper.clickedIndex);
    })
    function updateNavPosition() {
        $('.gallery-thumb .active-nav').removeClass('active-nav')
        var activeNav = $('.gallery-thumb .swiper-slide').eq(viewSwiper.activeIndex).addClass('active-nav')
        if (!activeNav.hasClass('swiper-slide-visible')) {
          if (activeNav.index() > previewSwiper.activeIndex) {
            var thumbsPerNav = Math.floor(previewSwiper.width / activeNav.width()) - 1;
            previewSwiper.slideTo(activeNav.index() - thumbsPerNav);
          } else {
            previewSwiper.slideTo(activeNav.index());
          }
        }
    }
}
