{extends file='mobile/layouts/layout-main.tpl'}

{block name='head_styles' append}
{literal}
.product_list {display:flex;justify-content:space-between;flex-wrap:wrap}
.product_list .list-item {width:48%}
.product-like-remove svg {fill:currentColor}
.product-like-remove {padding:10px;border-radius:50%}
.remove-button {position: absolute;top: 15px;left: 10px;}
{/literal}
{/block}
{block name='content'}
  <h2 class="page-title">{l s='My favorite products' d='Shop.Theme.Amp'}</h2>
  {if $haveToLogin}
    <p class="warning">{l s='You have to login to see Favorite products' d='Shop.Theme.Amp'}</p>
  {else}
    {if $favoriteProducts}
      <div class="product_list">
        {foreach from=$favoriteProducts item=favoriteProduct}
        <div id="favProduct{$favoriteProduct.id_product}" class="relative list-item">
          <div class="m20">
          {include file="mobile/catalog/_partials/miniatures/product.tpl" product=$favoriteProduct}
          </div>
          <form method="POST" class="remove-button" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false params=['favorite' => true, 'id_product' => {$favoriteProduct.id_product}]}" target="_top" class="flex-container" on="submit-success:favProduct{$favoriteProduct.id_product}.hide">

            <button type="submit" class="product-like-remove" aria-label="{l s='Remove from Favorites' d='Shop.Theme.Amp'}">
              <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg>
            </button>

            <div submit-error>{l s='Unable to remove' d='Shop.Theme.Amp'}</div>
          </form>
        </div>
        {/foreach}
      </div>
    {else}
      <p class="warning">{l s='No favorite products have been determined just yet' d='Shop.Theme.Amp'}</p>
    {/if}
  {/if}
{/block}