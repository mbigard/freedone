/**
 * Copyright ETS Software Technology Co., Ltd
 *
 * NOTICE OF LICENSE
 *
 * This file is not open source! Each license that you purchased is only available for 1 website only.
 * If you want to use this file on more websites (or projects), you need to purchase additional licenses.
 * You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future.
 *
 * @author ETS Software Technology Co., Ltd
 * @copyright  ETS Software Technology Co., Ltd
 * @license    Valid for 1 website (or project) for each purchase of license
 */
$(document).ready(function(){
    if($('.ets_marketplace_product_list_wrapper.slide:not(.slick-slider)').length >0)
    {
       $('.ets_marketplace_product_list_wrapper.slide:not(.slick-slider)').slick({
          slidesToShow: 4,
          slidesToScroll: 1,
          arrows: true,
          responsive: [
              {
                  breakpoint: 1199,
                  settings: {
                      slidesToShow: 4
                  }
              },
              {
                  breakpoint: 992,
                  settings: {
                      slidesToShow: 3
                  }
              },
              {
                  breakpoint: 768,
                  settings: {
                      slidesToShow: 2
                  }
              },
              {
                  breakpoint: 480,
                  settings: {
                    slidesToShow: 1
                  }
              }
           ]
       });
    }
    if($('.ets_marketpllce_product_list_wrapper:not(.slick-slider)').length >0)
    {
       $('.ets_marketpllce_product_list_wrapper:not(.slick-slider)').slick({
          slidesToShow: 4,
          slidesToScroll: 1,
          arrows: true,
          responsive: [
              {
                  breakpoint: 1199,
                  settings: {
                      slidesToShow: 4
                  }
              },
              {
                  breakpoint: 992,
                  settings: {
                      slidesToShow: 3
                  }
              },
              {
                  breakpoint: 768,
                  settings: {
                      slidesToShow: 2
                  }
              },
              {
                  breakpoint: 480,
                  settings: {
                    slidesToShow: 1
                  }
              }
           ]
       });
    }
});