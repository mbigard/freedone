<div class="simpleblog__featuredProducts">
    <h3 class="h2">{l s='Related products' d='Modules.Phsimpleblog.Shop'}</h3>
    <div class="products glide" data-desktopnum="4" data-tabletnum="3" data-phonenum="2" data-loop="0" data-autoplay="0" data-navwrap="0">
        <div class="glide__track" data-glide-el="track">
            <div class="glide__slides slider-mode">
                {foreach from=$related_products item="product"}
                  {include file='catalog/_partials/miniatures/product.tpl' product=$product}
                {/foreach}
            </div>
        </div>
    </div>
</div>