{extends file='mobile/layouts/layout-main.tpl'}

{block name='content'}
<div class="page-content-amp">
  <header class="page-header">
    <h2 class="m20">{$post->title}</h1>
  </header>
  <div class="simpleblog__post">
    {if (isset($post->featured_path) && ($post->featured_path != ''))}
    <div class="m20">
      <a href="{$post->url}" title="{$post->title}">
        <amp-img layout="responsive" src="{$post->featured_path}" alt="{$post->title}" width="{$post->image_size.featured_image.width}" height="{$post->image_size.featured_image.height}" /></a>
      </a>
    </div>
    {else}
      {if (isset($post->banner_thumb) && ($post->banner_thumb != ''))}
      <div class="m20">
        <a href="{$post->url}" title="{$post->title}">
          <amp-img layout="responsive"  src="{$post->banner_thumb}" alt="{$post->title}" width="{$post->image_size.banner_thumb.width}" height="{$post->image_size.banner_thumb.height}"></amp-img>
        </a>
      </div>
      {/if}
    {/if}

    <div class="m10 blog-post-info flex-container">
      {if Configuration::get('PH_BLOG_DISPLAY_DATE')}
        <div class="slpwfb">
          <time>{$post->date_add|date_format:Configuration::get('PH_BLOG_DATEFORMAT')}</time>
        </div>
        {/if}
        {if isset($post->author) && !empty($post->author) && Configuration::get('PH_BLOG_DISPLAY_AUTHOR')}
        <div class="slpwfb">{$post->author}</div>
        {/if}
        {if Configuration::get('PH_BLOG_DISPLAY_CATEGORY')}
        <div class="slpwfb">
          <a href="{$post->category_url}" title="{$post->category}">
            {$post->category}
          </a>
        </div>
        {/if}
        {if Configuration::get('PH_BLOG_DISPLAY_LIKES')}
        <div class="slpwfb">
          <span class="likes-count">{$post->likes}</span>
          <span>{l s='likes' d='Modules.Phsimpleblog.Amp'}</span>
        </div>
        {/if}
        {if Configuration::get('PH_BLOG_DISPLAY_VIEWS')}
        <div class="slpwfb">{$post->views} {l s='views' d='Modules.Phsimpleblog.Amp'}</div>
        {/if}
    </div>

    <div class="simpleblog__post__content m40">
      <div class="post-content">
        {$post->content nofilter}
      </div>
    </div>

    {if isset($post->gallery)}
    <div class="post-gallery m40">
      <h4 class="module-title">
        <span>{l s='Post Gallery' d='Modules.Phsimpleblog.Amp'}</span>
      </h4>
      <amp-carousel height="{$post->image_size.featured_image.height}" layout="fixed-height" type="slides" controls>
      {foreach from=$post->gallery item="image"}
        <amp-img src="{$gallery_dir}{$image.image}.jpg" class="img-responsive" width="{$post->image_size.featured_image.width}" height="{$post->image_size.featured_image.height}"></amp-img>
      {/foreach}
      </amp-carousel>
    </div>
    {/if}

    {if Configuration::get('PH_BLOG_DISPLAY_RELATED') && $related_products}
    <section class="categoryproducts">
      <h4 class="module-title pp-plist grid2">
        <span>{l s='Related Products' d='Modules.Phsimpleblog.Amp'}</span>
      </h4>
      <amp-carousel {if (isset($amp.config.product.carousel.autoplay) && ($amp.config.product.carousel.autoplay == 1))}autoplay{/if}  height="{$amp.global.images.home.size.height + ($amp.global.images.home.size.height*0.4)}" width="{$amp.global.images.home.size.width}" layout="responsive" type="slides" controls>
        {foreach from=$related_products item="product"}
          {include file="mobile/catalog/_partials/miniatures/product.tpl" product=$product image_size='home_default'}
        {/foreach}
      </amp-carousel>
    </section>
    {/if}

  </div>
</div>
{/block}