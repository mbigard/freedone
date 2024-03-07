{if isset($product.id_manufacturer)}
{assign var="brandName" value=Manufacturer::getNameById($product.id_manufacturer)}
{if $pkconf.pm_brand && $brandName}
    {block name='product_manufacturer'}
        <span class="product-brand ellipsis text-left">
            <a href="{if (isset($link))}{$link->getManufacturerLink($product.id_manufacturer)}{else}#{/if}">
                {$brandName}
            </a>
        </span>
    {/block}
{/if}
{else}
    <p class="elementor-alert elementor-alert-danger">Brand ID is missing</p>
{/if}