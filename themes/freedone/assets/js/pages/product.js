/*
 * jQuery Vertical Carousel
 * https://github.com/haripaddu/jQuery-Vertical-Carousel
 * Version: 1.0
 */
// prettier-ignore
!function(t){t.fn.verticalCarousel=function(e){e=t.extend({currentItem:1,showItems:1},e);var n,r,s,c,o,u=function(){var s,c=0;if(1==e.showItems)c=t("> :nth-child("+e.currentItem+")",r).outerHeight(!0);else for(i=1;i<=e.showItems;i++)c+=t("> :nth-child("+i+")",r).outerHeight(!0);var o=e.showItems+e.currentItem;s=t("> :nth-child("+o+")",r).css("marginTop"),c-=parseInt(s),t(n).css("height",c)},a=function(){var n=t("> :nth-child("+e.currentItem+")",r).offset(),s=t(r).offset().top-n.top;t(r).css({"-ms-transform":"translateY("+s+"px)","-webkit-transform":"translateY("+s+"px)",transform:"translateY("+s+"px)"})},l=function(n){1==e.currentItem?t(s).addClass("isDisabled"):e.currentItem>1&&t(s).removeClass("isDisabled"),e.currentItem==o||e.currentItem+e.showItems>o?t(c).addClass("isDisabled"):e.currentItem<o&&t(c).removeClass("isDisabled")},m=function(t){"up"==t&&(e.currentItem=e.currentItem-1),"down"==t&&(e.currentItem=e.currentItem+1),l(),u(),a()};return this.each((function(){t(this).find(".js-vCarousel-list").wrap('<div class="vc_container"></div>'),n=t(this).find(".vc_container"),r=t(this).find(".js-vCarousel-list"),s=t(this).find(".up"),c=t(this).find(".down"),o=t(r).children().length,l(),u(),a(),t("body").on("click",".up",(function(t){e.currentItem>1&&m("up"),t.preventDefault()})),t("body").on("click",".down",(function(t){e.currentItem+e.showItems<=o&&m("down"),t.preventDefault()}))}))}}(jQuery);

$(document).ready(function () {
    const vertImagesNum = 4;

    const addPrestashopEvents = () => {
        prestashop.on('clickQuickView', () => {
            initVertCarousel($('.quickview-modal .js-vCarousel'));
        });

        prestashop.on('updatedProduct', () => {
            initMainVertCarousel();
            initZoomper();
            setTimeout(() => updateReferenceCode(), 1000);
        });
    };

    const updateReferenceCode = () => {
        // update reference code
        const container = $('.product-reference').find('span');
        const refreshedData = container.text();
        if (typeof refreshedData !== '') {
            container.text(refreshedData);
        }
    };

    const initPopupObserver = () => {
        const targetNode = document.getElementById('product-modal');

        if (!targetNode) {
            return false;
        }

        const callback = (mutationList) =>
            mutationList.forEach(({ type }) => {
                if (type === 'attributes') {
                    setTimeout(() => initVertCarousel($('.js-vCarousel-popup')), 0);
                }
            });

        const observer = new MutationObserver(callback);
        observer.observe(targetNode, { attributes: true });
    };

    const initVertCarousel = (elem) => {
        const config = {
            currentItem: 1,
            showItems: vertImagesNum,
        };

        elem.imagesLoaded(
            setTimeout(() => {
                elem.verticalCarousel(config).addClass('scroll').removeClass('hidden');
            }, 500)
        );
    };

    const initMainVertCarousel = () => {
        const imagesNum = $('.images-container .product-images li').length;
        imagesNum > vertImagesNum ? initVertCarousel($('.js-vCarousel')) : $('.js-qv-mask').find('i').hide();
    };

    const initZoomper = () => {
        const disableMobileInnnerZoom = false;

        if (disableMobileInnnerZoom && prestashop.responsive.mobile) {
            return false;
        }

        const initZoomElement = () => {
            const url = document.querySelector('.js-qv-product-cover').getAttribute('src');
            $('.prod-image-zoom').trigger('zoom.destroy').zoom({ url });
        };

        // init zoom on load
        initZoomElement();

        // init zoom on click
        document
            .querySelectorAll('.js-qv-product-images img')
            .forEach((thumb) => thumb.addEventListener('click', initZoomElement));
    };

    const addEventListeners = () => {
        $('body').on('change', '.product-variants select, .product-variants input', () => {
            // const loading = 'combination-loading';
            // document.body.classList.add(loading);

            setTimeout(() => {
                // force removing product loader
                // document.body.classList.remove(loading);
                initMainVertCarousel();
            }, 1000);
        });

        $('body').on('click', '.product-cover .layer', () =>
            initVertCarousel($('.js-product-images-modal .scroll-box-arrows'))
        );
    };

    addEventListeners();
    addPrestashopEvents();
    initMainVertCarousel();

    pktheme.pp_innnerzoom ? initZoomper() : initPopupObserver();
});
