<div class="variant-links">
  {foreach from=$variants item=variant}
    {assign var='attrClasses' value=[$variant.type]}
    {if ($variant.html_color_code == '#ffffff')}
      {append var='attrClasses' value='white-color'}
    {/if}
    {if ($variant.id_product_attribute == $product.id_product_attribute)}
      {append var='attrClasses' value='active-attribute'}
    {/if}

    <a href="{$variant.url}"
       class="{' '|implode:$attrClasses}"
       title="{$variant.name}"
       aria-label="{$variant.name}"
      {if $variant.html_color_code} style="background-color: {$variant.html_color_code}" {/if}
      {if $variant.texture} style="background-image: url({$variant.texture})" {/if}
    ><span class="sr-only">{$variant.name}</span>
  </a>
  {/foreach}
  <span class="js-count count"></span>
</div>
