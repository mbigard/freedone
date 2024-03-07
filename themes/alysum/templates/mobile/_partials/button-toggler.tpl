{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{if $togglerId == 'selector-cart'}
{if !$configuration.is_catalog}
<form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" class="flex-container align-items-center" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info, count: event.response.info.products_count } });{/literal}">
    <button type="button" on="{if (isset($page.page_name ) && ($page.page_name == 'module-pkamp-order') || (isset($page) && $page == 'order'))}tap:AMP.navigateTo(url='{url entity='module' name={$amp.global.name} controller='cart' relative_protocol=false}'){else}tap:{$togglerId}.toggle{/if}" class="ampstart-btn relative flex-container align-items-center{if isset($togglerClass)} {$togglerClass}{/if}" aria-label="{l s='Close' d='Shop.Theme.Amp'}">
      {if isset($togglerIcon) && !empty($togglerIcon)}
        <svg class="svgic svgic-{$togglerIcon}"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#{$togglerIcon}"></use></svg>
      {/if}
      {if isset($togglerTitle)}
        <span class="flex-grow1">{$togglerTitle}</span>
      {/if}
      {if (isset($amp.config.header.cartnumber) && ($amp.config.header.cartnumber == 1))}
      <div class="cart-indicator-numb{if $amp.cart.products_count == 0} hidden{/if}" [text]="cartList.info[0].products_count" [class]="cartList.info[0].products_count > 0 ? 'cart-indicator-numb' : 'hidden'">{$amp.cart.products_count}</div>
      {/if}
    </button>
  </form>
{/if}
{else}
<button on="tap:{$togglerId}.toggle" class="ampstart-btn flex-container align-items-center{if isset($togglerClass)} {$togglerClass}{/if}" aria-label="{l s='Close' d='Shop.Theme.Amp'}">
  {if isset($togglerIcon) && !empty($togglerIcon)}
    <svg class="svgic svgic-{$togglerIcon}"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#{$togglerIcon}"></use></svg>
  {/if}
  {if isset($togglerTitle)}
    <span class="flex-grow1">{$togglerTitle}</span>
  {/if}
</button>
{/if}