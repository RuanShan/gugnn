// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  if($('.product-images-wrapper').is('*'))
  {

    var viewSwiper = new Swiper('.gallery-large.swiper-container', {
    	onSlideChangeStart: function() {
    		updateNavPosition()
    	}
    })

    $('.gallery-large .arrow-left,.gallery-thumb .arrow-left').on('click', function(e) {
    	e.preventDefault()
    	if (viewSwiper.activeIndex == 0) {
    		viewSwiper.slideTo(viewSwiper.slides.length - 1, 1000);
    		return
    	}
    	viewSwiper.slidePrev()
    })
    $('.gallery-large .arrow-right,.gallery-thumb .arrow-right').on('click', function(e) {
    	e.preventDefault()
    	if (viewSwiper.activeIndex == viewSwiper.slides.length - 1) {
    		viewSwiper.slideTo(0, 1000);
    		return
    	}
    	viewSwiper.slideNext()
    })

    var previewSwiper = new Swiper('.gallery-thumb.swiper-container', {
    	visibilityFullFit: true,
    	slidesPerView: 'auto',
    	onlyExternal: true,
    	onClick: function() {
    		viewSwiper.slideTo(previewSwiper.clickedIndex)
    	}
    })

    function updateNavPosition() {
    		$('.gallery-thumb .active-nav').removeClass('active-nav')
    		var activeNav = $('.gallery-thumb .swiper-slide').eq(viewSwiper.activeIndex).addClass('active-nav')
    		if (!activeNav.hasClass('swiper-slide-visible')) {
    			if (activeNav.index() > previewSwiper.activeIndex) {
    				var thumbsPerNav = Math.floor(previewSwiper.width / activeNav.width()) - 1
    				previewSwiper.slideTo(activeNav.index() - thumbsPerNav)
    			} else {
    				previewSwiper.slideTo(activeNav.index())
    			}
    		}
    	}

  }
})
