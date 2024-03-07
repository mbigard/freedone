<div id="desktop_cart">
    <div class="blockcart cart-preview{if $cart.products_count > 0} active{else} inactive{/if}" {if isset($refresh_url)}
        data-refresh-url="{$refresh_url}" {/if}>
        <div class="header relative">
            <a rel="nofollow" href="{$cart_url}"
                class="flex-container align-items-center relative cart-icon pk-item-content"
                aria-label="{l s='Shopping cart link containing %nbProducts% product(s)' sprintf=['%nbProducts%' => $cart.products_count] d='Shop.Theme.Checkout'}">
                <svg class="svgic svgic-button-cart">
                    <use href="{_THEME_IMG_DIR_}lib.svg#cart"></use>
                </svg>
                <span class="cart-title pkhi-item-title">{l s='Cart' d='Modules.Shoppingcart.Shop'}</span>
                {if ($cart.products_count > 0)}
                    <span class="cart-products-count header-item-counter" data-productsnum="{$cart.products_count}">
                        {$cart.products_count}
                    </span>
                {/if}
            </a>
            {if $cart.products_count > 0}
                <div class="shopping_cart">
                    <div class="indent">
                        {foreach from=$cart.products item=product name=cartProduct}
                            {block name='product_miniature'}
                                {include file='catalog/_partials/miniatures/mini-product.tpl' product=$product}
                            {/block}
                        {/foreach}
                        <div class="flex-container flex-column">
                            <div class="cart-total">
                                <div class="flex-container">
                                    <span class="flex-grow1">{l s='Shipping' d='Modules.Shoppingcart.Shop'}</span>
                                    <span class="ptsans">{$cart.subtotals.shipping.value}</span>
                                </div>
                                {if $cart.subtotals.tax}
                                    <div class="flex-container">
                                        <span class="flex-grow1">{$cart.subtotals.tax.label}</span>
                                        <span class="ptsans">{$cart.subtotals.tax.value}</span>
                                    </div>
                                {/if}
                                {if Configuration::get('PS_TAX_DISPLAY')}
                                    <div class="flex-container">
                                        <span class="flex-grow1">{$cart.totals.total_excluding_tax.label}</span>
                                        <span class="ptsans">{$cart.totals.total_excluding_tax.value}</span>
                                    </div>
                                    <div class="flex-container">
                                        <span class="flex-grow1">{$cart.totals.total_including_tax.label}</span>
                                        <span class="ptsans">{$cart.totals.total_including_tax.value}</span>
                                    </div>
                                {else}
                                    <div class="flex-container cart-total-value">
                                        <span class="flex-grow1">{$cart.totals.total.label}</span>
                                        <span class="ptsans">{$cart.totals.total.value}</span>
                                    </div>
                                {/if}
                            </div>
                            <div class="cart-button">
                                <a href="{$cart_url}" class="btn ellipsis reverse-btn">
                                    {l s='View Cart' d='Shop.Theme.Actions'}
                                </a>
                                <a href="{$urls.pages.order}" class="btn ellipsis">
                                    {l s='Checkout' d='Shop.Theme.Actions'}
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            {else}
                <div class="empty_shopping_cart elementor-alert elementor-alert-info">
                    {l s='Your Cart is empty' d='Modules.Shoppingcart.Shop'}
                </div>
            {/if}
        </div>
    </div>
</div>