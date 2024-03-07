{block name='product_description_short'}
    <div class="short-desc product-description-short{if !$pkconf.pm_desc} pm_desk_false{/if}{if $pkconf.pm_desc || $pkconf.cp_listing_view == 'list'} shown{else} hidden{/if}">
        {$product.description_short nofilter}
    </div>
{/block}