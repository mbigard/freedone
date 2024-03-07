{*
* 2007-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<a href="{$amp.global.urls.identity}">
  <svg class="svgic smooth05"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#info"></use></svg>
  <span>{l s='Customer Information' d='Shop.Theme.Amp'}</span>
</a>

{if $customer.addresses|count}
  <a href="{$amp.global.urls.addresses}">
    <svg class="svgic smooth05"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#address"></use></svg>
    <span>{l s='Addresses' d='Shop.Theme.Amp'}</span>
  </a>
{else}
  <a href="{$amp.global.urls.address}">
    <svg class="svgic smooth05"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#address"></use></svg>
    <span>{l s='Add first address' d='Shop.Theme.Amp'}</span>
  </a>
{/if}

{if !$configuration.is_catalog}
  <a href="{$amp.global.urls.history}">
    <svg class="svgic smooth05"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#file3"></use></svg>
    <span>{l s='Order history and details' d='Shop.Theme.Amp'}</span>
  </a>
{/if}

{if !$configuration.is_catalog}
  <a href="{$amp.global.urls.order_slip}">
    <svg class="svgic smooth05"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#file2"></use></svg>
    <span>{l s='Credit slips' d='Shop.Theme.Amp'}</span>
  </a>
{/if}

{if $configuration.voucher_enabled && !$configuration.is_catalog}
  <a href="{$amp.global.urls.discount}">
    <svg class="svgic smooth05"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#voucher"></use></svg>
    <span>{l s='Vouchers' d='Shop.Theme.Amp'}</span>
  </a>
{/if}

{if $configuration.return_enabled && !$configuration.is_catalog}
  <a href="{$amp.global.urls.order_follow}">
    <svg class="svgic smooth05"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#info"></use></svg>
    <span>{l s='Merchandise returns' d='Shop.Theme.Amp'}</span>
  </a>
{/if}