{if $pkconf.pm_colors}
    {block name='product_variants'}
        <div class="highlighted-informations{if !$product.main_variants} no-variants{/if}">
            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
        </div>
    {/block}
{/if}