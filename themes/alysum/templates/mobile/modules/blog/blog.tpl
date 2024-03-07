{extends file='mobile/layouts/layout-main.tpl'}

{block name='content'}
<div class="page-content-amp">
<h2 class="m20">{l s='Blog' d='Modules.Phsimpleblog.Amp'}</h2>
{if isset($posts) && count($posts)}
  {foreach from=$posts item=post}
  <div class="blog-post m40">

    {if isset($post.banner_thumb)}
    <div class="m20">
      <a href="{$post.url}">
        <amp-img layout="responsive"  src="{$post.banner_thumb}" alt="{$post.title}" width="{$post.image_size.banner_thumb.width}" height="{$post.image_size.banner_thumb.height}"></amp-img>
      </a>
    </div>
    {/if}

    <div class="blog-headline">
      <h3 class="m0">
        <a href="{$post.url}" title="{$post.title}">
          {$post.title}
        </a>
      </h3>
    </div>

    <div class="m10 blog-post-info flex-container">
      {if Configuration::get('PH_BLOG_DISPLAY_DATE')}
      <div class="slpwfb">
        <time datetime="{$post.date_add|date_format:'c'}">{$post.date_add|date_format:Configuration::get('PH_BLOG_DATEFORMAT')}</time>
      </div>
      {/if}
      {if isset($post.author) && !empty($post.author) && Configuration::get('PH_BLOG_DISPLAY_AUTHOR')}
      <div class="slpwfb">
        <span itemprop="author">{$post.author}</span>
      </div>
      {/if}
      {if $post.allow_comments eq true && Configuration::get('PH_BLOG_COMMENTS_SYSTEM') == 'native'}
      <div class="slpwfb">
        <a href="{$post.url}#phsimpleblog_comments">{$post.comments} {l s='comments' d='Modules.Phsimpleblog.Amp'}</a>
      </div>
      {/if}
      {if Configuration::get('PH_BLOG_DISPLAY_VIEWS')}
      <div class="slpwfb">
        <span>{$post.views} {l s='views' d='Modules.Phsimpleblog.Amp'}</span>
      </div>
      {/if}
      {if $is_category eq false && Configuration::get('PH_BLOG_DISPLAY_CATEGORY')}
      <div class="slpwfb">
        {l s='Category'  d='Modules.Phsimpleblog.Amp'}: <a href="{$post.category_url}" title="{$post.category}" rel="category">{$post.category}</a>
      </div>
      {/if}
    </div>


    {if Configuration::get('PH_BLOG_DISPLAY_DESCRIPTION')}
    <div class="m20">{$post.short_content nofilter}</div>
    {/if}

    <a href="{$post.url}" class="btn btn-primary">
      {l s='Read more' d='Modules.Phsimpleblog.Amp'}
    </a>

  </div>
  {/foreach}
{else}
  <div class="warning alert alert-warning">{l s='There are no posts' d='Modules.Phsimpleblog.Amp'}</div>
{/if}
</div>
{/block}