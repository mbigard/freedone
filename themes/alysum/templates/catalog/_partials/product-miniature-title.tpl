{if $pkconf.pm_title}
    {block name='product_name'}
    <h2 class="product-title text-left{if !$pkconf.pm_title_multiline} ellipsis{/if}">
        <a href="{$product.url}">{$product.name}</a>
    </h2>
    {/block}
{/if}