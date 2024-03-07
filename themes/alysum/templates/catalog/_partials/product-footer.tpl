{block name='product_footer'}
  <div class="page-width product-footer" data-hook="displayFooterProduct">

    {if isset($category) && isset($product)}
    {hook h='displayFooterProduct' product=$product category=$category}
    {/if}

    {if (isset($pkconf.pp_accessories) && ($pkconf.pp_accessories == 1))}
    {block name='product_accessories'}
      {if (isset($accessories) && !empty($accessories))}
        <section class="product-accessories products-carousel page-width wide oh relative" data-num="{$accessories|count}" data-prefix="accessories">
          <h4 class="module-title">
            <span>{l s='You might also like' d='Shop.Theme.Catalog'}</span>
          </h4>
          <div class="products glide view_grid products-block" data-desktopnum="4" data-tabletnum="2" data-phonenum="1" data-loop="0" data-autoplay="0" data-navwrap="0" data-align-arrows="1" data-name="accessories">
            <div class="glide__track" data-glide-el="track">
              <div class="glide__slides slider-mode">
                {foreach from=$accessories item="product_accessory"}
                  {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory image_size='medium_default'}
                {/foreach}
              </div>
            </div>
          </div>
        </section>
      {/if}
    {/block}
    {/if}

  </div>
{/block}