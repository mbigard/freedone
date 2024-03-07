/* global $ */
$(document).ready(function () {

    var $searchWidget = $('#search_widget');
    var $searchBox    = $searchWidget.find('input[type=text]');
    var searchURL     = $searchWidget.attr('data-search-controller-url');
    var marker_class  = 'pk_search_result';
    var noproducts    = 'search-no-result';
    var fadeContent   = 'fadeContent';

    var $searchWidget_mobile = $('#search_widget_mobile');
    var $searchBox_mobile    = $searchWidget_mobile.find('input[type=text]');

    $.widget('prestashop.psBlockSearchAutocomplete', $.ui.autocomplete, {
        _renderItem: function (ul, product) {
            ul.addClass(marker_class).css({'width': $searchBox.width()+'px'});

            const pPrice = prestashop.configuration.is_catalog ? '' : product.price;

            pimg = '';
            if (typeof product.cover === 'object' && product.cover !== null) {
              pimg = "<img src='"+product.cover.medium.url+"' width='"+product.cover.medium.width+"' height='"+product.cover.medium.height+"'>";
            } else {
              $.each( product.images, function( key, image ) {
                if (image.cover == 1) {
                  pimg = "<img src='"+image.bySize.medium_default.url+"' width='"+image.bySize.medium_default.width+"' height='"+image.bySize.medium_default.height+"'>";
                }
              });
            }

            return $("<li>")
                .append($(
                    '<div class="mini-product"><div class="thumbnail-container relative"><div class="thumbnail product-thumbnail"><a href="'+product.link+'" class="relative">'+pimg+'</a></div><div class="product-description"><h3 class="product-title"><a href="'+product.link+'">'+product.name+'</a></h3><div class="product-price-and-shipping"><span class="price">'+pPrice+'</span></div></div></div>')
                ).appendTo(ul);

        }
    });

    $searchBox.psBlockSearchAutocomplete({
        source: function (query, response) {
            $.get(searchURL, {
                s: query.term,
                resultsPerPage: 10
            }, null, 'json')
            .then(function (resp) {
                $searchWidget.addClass('shown');
                $searchWidget.find('.search_list').remove();
                $('.ui-autocomplete-input').removeClass('ui-autocomplete-loading');
                if (resp.products.length > 0 && query.term.length > 2)
                {
                  if ($('body').hasClass('gs-popup-search'))
                  {
                    $searchWidget.css({'top':'10%'});
                    $searchWidget.append('<div class="view_list search_list">'+ resp.rendered_products+'</div>');
                  } else {
                    if ($('.mobileHeader')[0])
                    {
                      $('.mobileHeader #search_widget').append( $('.ui-autocomplete') );
                    }
                    $searchWidget.css({'top':'10%'});
                    response(resp.products);
                    $('.'+noproducts).remove();
                    // move search results into search block
                    if ($('.pk_search')[0]) {
                      $('.pk_search .opt-list .indent').append( $('.ui-autocomplete') );
                      $('.pk_search .opt-list').css({'height': 'auto'});
                    }
                  }
                  //
                } else {
                  $searchWidget.removeAttr('style');
                  $('.ui-autocomplete').hide();
                  $('.'+noproducts).remove();
                  if (query.term.length <= 2) {
                    var txt = $searchWidget.data('less');
                    $searchWidget.append('<div class="'+noproducts+' '+marker_class+'">'+txt+'</div>');
                  } else {
                    var txt = $searchWidget.data('null');
                    $searchWidget.append('<div class="'+noproducts+' '+marker_class+'">'+txt+'</div>');
                  }
                }
            })
            .fail(response);
        },
        select: function (event, ui) {
            var url = ui.item.url;
            window.location.href = url;
        },
    });

    $searchBox_mobile.psBlockSearchAutocomplete({
        source: function (query, response) {
            $.get(searchURL, {
                s: query.term,
                resultsPerPage: 10
            }, null, 'json')
            .then(function (resp) {
                $searchWidget_mobile.addClass('shown');
                $('.ui-autocomplete-input').removeClass('ui-autocomplete-loading');
                if (resp.products.length > 0 && query.term.length > 2)
                {
                  if ($('body').hasClass('gs-popup-search'))
                  {
                    $searchWidget_mobile.css({'top':'10%'});
                    $searchWidget_mobile.append('<div class="view_list search_list">'+ resp.rendered_products+'</div>');
                  } else {
                    if ($('.mobileHeader')[0])
                    {
                      $('.mobileHeader #search_widget_mobile').append( $('.ui-autocomplete') );
                    }
                    $searchWidget_mobile.css({'top':'10%'});
                    response(resp.products);
                    $('.'+noproducts).remove();
                    // move search results into search block
                    if ($('.pk_search')[0]) {
                      $('.pk_search .opt-list .indent').append( $('.ui-autocomplete') );
                      $('.pk_search .opt-list').css({'height': 'auto'});
                    }
                  }
                  //
                } else {
                  $searchWidget_mobile.removeAttr('style');
                  $('.ui-autocomplete').hide();
                  $('.'+noproducts).remove();
                  if (query.term.length <= 2) {
                    var txt = $searchWidget_mobile.data('less');
                    $searchWidget_mobile.append('<div class="'+noproducts+' '+marker_class+'">'+txt+'</div>');
                  } else {
                    var txt = $searchWidget_mobile.data('null');
                    $searchWidget_mobile.append('<div class="'+noproducts+' '+marker_class+'">'+txt+'</div>');
                  }
                }
            })
            .fail(response);
        },
        select: function (event, ui) {
            var url = ui.item.url;
            window.location.href = url;
        },
    });


    var target = document.getElementById('ui-id-1');
    var observer = new MutationObserver(function(mutations) {
      mutations.forEach(function(mutation)
      {
        if ( $(target).css('display') == 'none' ){
            $searchWidget.removeClass('shown');
        }
      });
    });

    var config = { attributes: true, childList: false, characterData: false };
    if (target) {
      observer.observe(target, config);
    }

    $('body').on('click', '.searchToggler', function(e){
      e.preventDefault();
      $searchWidget.toggleClass('hidden').css({'top':'50%'});
      $('body').append('<div class="'+fadeContent+'"></div>');
      $('body').addClass('active-popup-search');
      $('.ui-autocomplete-input').focus();
    });
    $('body').on('click', '.'+fadeContent, function(){
      $('.'+fadeContent).remove();
      $('body').removeClass('active-popup-search');
      $searchWidget.toggleClass('hidden');
    });
});