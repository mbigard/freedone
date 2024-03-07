{* {if !isset($type)}
    {assign var="type" value="home_default"}
{/if} *}
<img
  src="{$image.bySize.$type.url}"
  loading="lazy"
  alt="{if !empty($product.default_image.legend)}{$product.default_image.legend}{else}{$product.name|truncate:30:'...'}{/if}"
  width="{$image.bySize.$type.width}"
  height="{$image.bySize.$type.height}"
  class="smooth05 cover-image db"
  data-full-size-image-url="{$image.large.url}">