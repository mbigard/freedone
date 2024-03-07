{*
* 2007-2020 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2020 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{extends file='page.tpl'}

{block name='head_hreflang'}
  {if (isset($alternativeLangs) && (!empty($alternativeLangs)))}
  {foreach from=$alternativeLangs item=pageUrl key=code}
  <link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
  {/foreach}
  {/if}
{/block}

<div class="page-width main-content">
  <div id="wrapper" class="clearfix container">
    <div class="row blog-row">

      {block name='head_seo_title'}
        {if isset($post->meta_title) && $post->meta_title != ''}
          {$post->meta_title} - {$page.meta.title}
        {else}
          {$post->title} - {$page.meta.title}
        {/if}
      {/block}

      {if isset($post->meta_description) && $post->meta_description != ''}
        {block name='head_seo_description'}{$post->meta_description}{/block}
      {/if}

      {if isset($post->meta_keywords) && $post->meta_keywords != ''}
        {block name='head_seo_keywords'}{$post->meta_keywords}{/block}
      {/if}

      {block name='content_wrapper'}
        <div id="content-wrapper" class="wide left-column col-xs-12 col-sm-12 col-md-12">
          {block name='page_content'}
            {block name='page_header_container'}
          <header class="page-header">
            <h1 class="h1">{$post->title}</h1>
          </header>
          {/block}
            {assign var='post_type' value=$post->post_type}
            <div class="simpleblog__postInfo">
                <ul>
                  {if Configuration::get('PH_BLOG_DISPLAY_DATE')}
                    <li>
                      <span>
                        <time>
                          {$post->date_add|date_format:Configuration::get('PH_BLOG_DATEFORMAT')}
                        </time>
                      </span>
                    </li>
                    {/if}
                    {if isset($post->author) && !empty($post->author) && Configuration::get('PH_BLOG_DISPLAY_AUTHOR')}
                    <li>
                      <span>
                        {$post->author}
                      </span>
                    </li>
                    {/if}
                    {if Configuration::get('PH_BLOG_DISPLAY_CATEGORY')}
                    <li>
                      <span>
                        <a
                          href="{$link->getModuleLink('ph_simpleblog', 'category', ['sb_category' => $post->category_rewrite])}"
                          title="{$post->category}"
                        >
                          {$post->category}
                        </a>
                      </span>

                    </li>
                    {/if}
                    {if Configuration::get('PH_BLOG_DISPLAY_LIKES')}
                    <li>
                      <a href="#" data-guest="{$guest}" data-post="{$post->id_simpleblog_post}" class="simpleblog-like-button">
                        <span class="likes-count">
                          {$post->likes}
                        </span>
                        <span>
                          {l s='likes' d='Modules.Phsimpleblog.Shop'}
                        </span>
                      </a>
                    </li>
                    {/if}
                    {if Configuration::get('PH_BLOG_DISPLAY_VIEWS')}
                    <li>
                      <span>
                        {$post->views} {l s='views' d='Modules.Phsimpleblog.Shop'}
                      </span>
                    </li>
                    {/if}
                    {if $allow_comments eq true && Configuration::get('PH_BLOG_COMMENTS_SYSTEM') == 'native'}
                    <li>
                      <span>
                        <a href="{$post->url}#phsimpleblog_comments">{$post->comments} {l s='comments' d='Modules.Phsimpleblog.Shop'}</a>
                      </span>
                    </li>
                    {/if}
                </ul>
            </div>
            <div class="simpleblog__post">
              {if $post->featured_image && Configuration::get('PH_BLOG_DISPLAY_FEATURED')}
                <a href="{$post->featured_image}" title="{$post->title}" class="fancybox simpleblog__post-featured">
                  <img src="{$post->featured_image}" alt="{$post->title}" class="img-fluid" />
                </a>
              {/if}
                <div class="simpleblog__post__content">

                  {if $post_type == 'gallery' && sizeof($post->gallery)}
                  <div class="post-gallery">
                    {foreach $post->gallery as $image}
                    <a rel="post-gallery-{$post->id_simpleblog_post}" class="fancybox" href="{$gallery_dir}{$image.image}.jpg" title="{l s='View full' d='Modules.Phsimpleblog.Shop'}"><img src="{$gallery_dir}{$image.image}.jpg" class="img-fluid" /></a>
                    {/foreach}
                  </div><!-- .post-gallery -->
                  {elseif $post_type == 'video'}
                  <div class="post-video" itemprop="video">
                    {$post->video_code nofilter}
                  </div><!-- .post-video -->
                  {else}
                  <img src="{$urls.shop_domain_url}{$post->banner}" class="db">
                  {/if}
                </div>
                {$post->content nofilter}
                <div class="simpleblog__post__after-content" id="displayPrestaHomeBlogAfterPostContent">
                {hook h='displayPrestaHomeBlogAfterPostContent'}
              </div><!-- #displayPrestaHomeBlogAfterPostContent -->
            </div>

            {if $post->tags && Configuration::get('PH_BLOG_DISPLAY_TAGS') && isset($post->tags_list)}
              <span class="post-tags clear">
                <h3 class="block-title">{l s='Tags' d='Modules.Phsimpleblog.Shop'}:</h3>
                {foreach from=$post->tags_list item=tag name='tagsLoop'}
                  {$tag|escape:'html':'UTF-8'}{if !$smarty.foreach.tagsLoop.last}, {/if}
                {/foreach}
              </span>
            {/if}

            {if Configuration::get('PH_BLOG_DISPLAY_SHARER')}
            {include file="module:ph_simpleblog/views/templates/hook/after-post-content.tpl"}
            {hook h='displayBlogForPrestaShopSocialSharing'}
            {/if}

            {if Configuration::get('PH_BLOG_DISPLAY_RELATED') && $related_products}
              {include file="module:ph_simpleblog/views/templates/front/1.7/_partials/post-single-related-products.tpl"}
            {/if}

            {if $allow_comments eq true && Configuration::get('PH_BLOG_COMMENTS_SYSTEM') == 'native'}
              {include file="module:ph_simpleblog/views/templates/front/1.7/comments/layout.tpl"}
            {/if}

            {if $allow_comments eq true && Configuration::get('PH_BLOG_COMMENTS_SYSTEM') == 'facebook'}
              {include file="module:ph_simpleblog/views/templates/front/1.7/comments/facebook.tpl"}
            {/if}

            {if $allow_comments eq true && Configuration::get('PH_BLOG_COMMENTS_SYSTEM') == 'disqus'}
              {include file="module:ph_simpleblog/views/templates/front/1.7/comments/disqus.tpl"}
            {/if}
          {/block}
        </div>
      {/block}
    </div>
  </div>
</div>

{if isset($jsonld)}
<script type="application/ld+json">
{$jsonld nofilter}
</script>
{/if}