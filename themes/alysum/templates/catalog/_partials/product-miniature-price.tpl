{if $pkconf.pm_price && Configuration::showPrices() == true}
    {block name='product_price_and_shipping'}
        {if $product.show_price}
            <div class="product-price-and-shipping">
                {if $product.has_discount}
                    {hook h='displayProductPriceBlock' product=$product type="old_price"}
                    <span class="regular-price">{$product.regular_price}</span>
                {/if}

                {hook h='displayProductPriceBlock' product=$product type="before_price"}
                <span class="price" content="{$product.price_amount}">{$product.price}</span>
                {hook h='displayProductPriceBlock' product=$product type='unit_price'}
                {hook h='displayProductPriceBlock' product=$product type='weight'}
            </div>

            {if $pkconf.pm_countdown && (isset($isHorizontal) && $isHorizontal == 10)}
                {include file='catalog/_partials/product-countdown.tpl'}
            {/if}
        {/if}
    {/block}
{/if}