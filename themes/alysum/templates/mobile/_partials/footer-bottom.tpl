{*
* 2011-2021 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2021 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{assign var="amppage" value=$page.page_name|replace:'module-pkamp-':''}

{if (isset($amp.config.general.googleanalytics.state) && $amp.config.general.googleanalytics.state == 1) && (isset($amp.config.general.googleanalytics.id) && $amp.config.general.googleanalytics.id != '')}
<amp-analytics type="gtag" data-credentials="include">
  {strip}<script type="application/json">
    {
      "vars": {
        "gtag_id": "{$amp.config.general.googleanalytics.id}",
        "config": {
          "{$amp.config.general.googleanalytics.id}": {
            "groups": "default"
          }
        }
      },
      "triggers": {
        "trackPageview": {
          "on": "visible",
          "request": "pageview",
          "extraUrlParams": {
            "page_name": "{$amppage}"
            ,"currency": "{$currency.iso_code}"
            ,"language": "{$language.iso_code}"
            {if $amppage == 'category'}
            ,"category_id" : "{$category->id}"
            ,"category_name" : "{$category->name}"
            {/if}{if $amppage == 'product'}
            ,"product_name": "{$product.name}"
            ,"product_id": "{$product.id}"
            ,"product_category": "{$product.category_name}"
            ,"value": "{$product.price_amount}"
            {/if}
          }
        },
        "trackAnchorClicks": {
          "on": "click",
          "selector": "#payment-confirm",
          "request": "event",
          "vars": {
            "eventId": "clickOnPaymentConfirmButton"
          }
        },
        "formSubmit": {
          "on": "amp-form-submit",
          "request": "event",
          "selector": "#add-to-cart",
          "vars": {
            "eventId": "form-submit"
          }
        },
        "formSubmitSuccess": {
          "on": "amp-form-submit-success",
          "request": "event",
          "selector": "#add-to-cart",
          "vars": {
            "eventId": "form-submit-success"
          }
        },
        "formSubmitError": {
          "on": "amp-form-submit-error",
          "request": "event",
          "selector": "#add-to-cart",
          "vars": {
            "eventId": "form-submit-error"
          }
        }
      }
    }
  </script>{/strip}
</amp-analytics>
{/if}

{if (isset($amp.config.general.googleadwords.state) && $amp.config.general.googleadwords.state == 1)}
<amp-analytics type="googleadwords">
  <script type="application/json">
  {
    "triggers": {
      "onVisible": {
        "on": "visible",
        "request": "conversion"
      }
    },
    "vars": {
      "googleConversionId": "{if (isset($amp.config.general.googleadwords.conversionid) && $amp.config.general.googleadwords.conversionid != '')}{$amp.config.general.googleadwords.conversionid}{/if}",
      "googleConversionLanguage": "{$language.iso_code}",
      "googleConversionCurrency": "{$currency.iso_code}",
      "googleConversionFormat": "3",
      "googleConversionLabel": "{if (isset($amp.config.general.googleadwords.trackinglabel) && $amp.config.general.googleadwords.trackinglabel != '')}{$amp.config.general.googleadwords.trackinglabel}{/if}",
      "googleRemarketingOnly": "false"
    }
  }
  </script>
</amp-analytics>
{/if}

{if (isset($amp.config.general.googletagmanage.state) && $amp.config.general.googletagmanage.state == 1) && (isset($amp.config.general.googletagmanage.id) && $amp.config.general.googletagmanage.id != '')}
<amp-analytics config="https://www.googletagmanager.com/amp.json?id={$amp.config.general.googletagmanage.id}" data-credentials="include"></amp-analytics>
{/if}

{if (isset($amp.config.general.fbpixel.state) && $amp.config.general.fbpixel.state == 1) && (isset($amp.config.general.fbpixel.id) && $amp.config.general.fbpixel.id != '')}
<amp-analytics type="facebookpixel" id="facebook-pixel">
  {strip}<script type="application/json">
  {
    "vars": {
      "pixelId": "{$amp.config.general.fbpixel.id}"
    },
    "triggers": {
      "trackPageview": {
        "on": "visible",
        "request": "pageview"
      }
      {if $amppage == 'category'}
      ,"trackViewContent": {
        "on": "visible",
        "request": "eventViewContent",
        "vars": {
          "product_catalog_id": "{$category->id}",
          "currency": "{$currency.iso_code}",
          "content_name": "{$amp.global.meta.meta_title}",
          "content_category": "{$category->name}",
          "content_type": "product",
          "content_ids": "[{foreach from=$product_ids item=id name=plist}{$id}{if not $smarty.foreach.plist.last},{/if}{/foreach}]",
          "value": "10"
        }
      }
      {/if}
      {if $amppage == 'product' || $amppage == 'module-pk_amp-product'}
      ,"trackViewContent": {
        "on": "visible",
        "request": "eventViewContent",
        "vars": {
          "content_name": "{$product.name}",
          "content_ids": "[{$product.id}]",
          "content_type": "product",
          "value": "{$product.price_amount}",
          "currency": "{$currency.iso_code}",
          "product_catalog_id": "{$product.id_category_default}"
        }
      },
      "trackAddToCart": {
        "on": "amp-form-submit-success",
        "request": "eventAddToCart",
        "vars": {
          "value": "{$product.price_amount}",
          "content_name": "{$product.name}",
          "content_ids": "[{$product.id}]",
          "currency": "{$currency.iso_code}",
          "content_type": "product"
        }
      }
      {/if}
      {if $amppage == 'search'}
      ,"trackSearch": {
        "on": "visible",
        "request": "eventSearch",
        "vars": {
          "content_ids": "{if isset($products)}[{foreach from=$products item=p name=plist}'{$p.id}'{if not $smarty.foreach.plist.last},{/if}{/foreach}]{/if}",
          "content_category": "Search Page",
          "currency": "{$currency.iso_code}",
          "search_string": "{$searchStr}",
          "content_type": "product",
          "value": "0.1"
        }
      }
      {/if}
      {if $amppage == 'cart'}
      ,"trackInitiateCheckout": {
        "on": "visible",
        "request": "eventInitiateCheckout",
        "vars": {
          "content_type": "product",
          "content_name": "Cart Page",
          "content_category": "Checkout",
          "num_items": "{if isset($ampcart.products_count)}{$ampcart.products_count}{/if}",
          "content_ids": {if isset($ampcart.product_ids)}[{foreach from=$ampcart.product_ids item=id name=plist}{$id}{if not $smarty.foreach.plist.last},{/if}{/foreach}]{/if},
          "value": "{$cart.totals.total.amount}",
          "currency": "{$currency.iso_code}"
        }
      }
      {/if}
      {if $amppage == 'orderconfirmation'}
      ,"trackPurchase": {
        "on": "visible",
        "request": "eventPurchase",
        "vars": {
          "num_items": "{if isset($order.products)}{$order.products|count}{/if}",
          "content_ids": "{if isset($order.products)}[{foreach from=$order.products item=p name=plist}\"{$p.product_id}\"{if not $smarty.foreach.plist.last},{/if}{/foreach}]{/if}",
          "content_name": "Order Confirmation",
          "content_type": "product",
          "value": "{$order.totals.total.amount|round:2}",
          "currency": "{$currency.iso_code}"
        }
      }
      {/if}
    }
  }
  </script>{/strip}
</amp-analytics>
{/if}

{if (isset($amp.config.footer.checkoutbtn) && $amp.config.footer.checkoutbtn == 1 && isset($amp.cart.products_count) && ($amppage != 'order'))}
{assign var="btnlink" value="order"}
{if isset($amp.config.footer.checkoutbtnlink)}
{assign var="btnlink" value="{$amp.config.footer.checkoutbtnlink}"}
{/if}
<div class="c-out-btn"{if $amp.cart.products_count == 0} hidden{/if} [hidden]="cartList.info[0].products_count == 0">
  <a href="{url entity='module' name={$amp.global.name} controller=$btnlink relative_protocol=false}" class="c-out-btn" role="button" tabindex="0">
    <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#checkout"></use></svg>
    <span [text]="cartList.info[0].products_count">{$amp.cart.products_count}</span>
  </a>
</div>
{/if}

{assign var='isWorkingTime' value=1}
{if isset($amp.config.general.showsince) && isset($amp.config.general.showuntil)}
  {if 
    (
      ($smarty.now|date_format:'%H' < $amp.config.general.showsince) || 
      ($smarty.now|date_format:'%H' >= $amp.config.general.showuntil)
    ) &&
    ($amp.config.general.showsince != $amp.config.general.showuntil)
  }
    {assign var='isWorkingTime' value=0}
  {/if}
{/if}
{if $isWorkingTime}
<div class="flex-container flex-column pk-chats">
{if (isset($amp.config.general.facebookchat) && $amp.config.general.facebookchat == 1)}
<a rel="nofollow noreferrer" href="https://m.me/{if (isset($amp.config.general.facebookchatpage))}{$amp.config.general.facebookchatpage}{/if}?ref={$shop.name}" class="amp-chat-item amp-pkfacebook flex-container align-items-center justify-center" target="_blank" title="{l s="Facebook Messenger" d="Shop.Theme.Amp"}"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#messenger"></use></svg></a>
{/if}
{if (isset($amp.config.general.whatsappchat) && $amp.config.general.whatsappchat == 1)}
  {assign var="whatsapplink" value=""}
  {if (isset($amp.config.general.whatsapptype) && isset($amp.config.general.whatsappphone) && $amp.config.general.whatsapptype == 1)}
    {assign var="whatsapplink" value="https://api.whatsapp.com/send?phone={$amp.config.general.whatsappphone}"}
  {else}
    {if (isset($amp.config.general.whatsappid))}
    {assign var="whatsapplink" value="https://chat.whatsapp.com/{$amp.config.general.whatsappid}?ref={$shop.name}"}
    {/if}
  {/if}
<a rel="nofollow noreferrer" href="{$whatsapplink}" class="amp-chat-item amp-whatsapp flex-container align-items-center justify-center" target="_blank" title="{l s="WhatsApp Chat" d="Shop.Theme.Amp"}"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#whatsapp"></use></svg></a>
{/if}
{if (isset($amp.config.general.telegram) && $amp.config.general.telegram == 1 && !empty($amp.config.general.telegramurl))}
<a rel="nofollow noreferrer" href="{$amp.config.general.telegramurl}" class="amp-chat-item amp-pktelegram flex-container align-items-center justify-center" target="_blank" title="Telegram"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#telegram"></use></svg></a>
{/if}
</div>
{/if}