{assign var="type" value='home_default'}
{assign var="hover_num" value=3}
{if isset($image_size)}
    {assign var="type" value=$image_size}
{else}
    {if isset($pkconf.pm_image_type)}
        {assign var="type" value=$pkconf.pm_image_type}
    {/if}
{/if}
{if isset($pkconf.pm_hover_image) && isset($pkconf.pm_hover_image_number)}
    {assign var="hover_num" value=$pkconf.pm_hover_image_number}
{/if}

{assign var='imgClasses' value=['relative', 'oh', 'db']}
{if $pkconf.pm_hover_image}
    {foreach from=$product.images item=image}
        {if (($image.cover != 1) && ($product.cover.id_image != $image.id_image))}
            {append var='imgClasses' value='subimage-true'}
            {break}
        {/if}
    {/foreach}
{/if}

{function name="showSwitcher"}
<span class="pmimage-switcher flex-container">
    <span></span>
    {assign var=counter value=1}
    {foreach from=$product.images item=image name=images}
        {if ($image.cover != 1) && ($counter < $hover_num)}
            <span></span>
            {assign var=counter value=$counter+1}
        {/if}
    {/foreach}
</span>
{/function}

{function name="showSubImages"}
{assign var=counter value=1}
{foreach from=$product.images item=image name=images}
    {if ($image.cover != 1) && ($counter < $hover_num)}
        {include file='catalog/_partials/product-image.tpl' image=$image type=$type}
        {assign var=counter value=$counter+1}
    {/if}
{/foreach}
{/function}

{block name='product_thumbnail'}
<a href="{$product.url}" class="{' '|implode:$imgClasses}">
    {if $product.cover}
        {include file='catalog/_partials/product-image.tpl' image=$product.cover type=$type}
        {if $pkconf.pm_hover_image}
            {showSubImages}
            {showSwitcher}
        {/if}
    {else}
        {if isset($urls)}
            {include file='catalog/_partials/product-image.tpl' image=$urls.no_picture_image type=$type}
        {/if}
    {/if}
</a>
{/block}