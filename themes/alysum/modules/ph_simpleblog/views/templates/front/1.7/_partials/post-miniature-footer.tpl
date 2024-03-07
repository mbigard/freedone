<div class="simpleblog__listing__post__wrapper__footer slpwf flex-container">
    {if Configuration::get('PH_BLOG_DISPLAY_DATE')}
    <div class="simpleblog__listing__post__wrapper__footer__block slpwfb">
        <time datetime="{$post.date_add|date_format:'c'}">{$post.date_add|date_format:Configuration::get('PH_BLOG_DATEFORMAT')}</time>
    </div>
    {/if}
    
    {if isset($post.author) && !empty($post.author) && Configuration::get('PH_BLOG_DISPLAY_AUTHOR')}
    <div class="simpleblog__listing__post__wrapper__footer__block slpwfb">
        <span itemprop="author">{$post.author}</span>
    </div>
    {else}
    <meta itemprop="author" content="{Configuration::get('PS_SHOP_NAME')}">
    {/if}
    {if $post.allow_comments eq true && Configuration::get('PH_BLOG_DISPLAY_COMMENTS') && Configuration::get('PH_BLOG_COMMENTS_SYSTEM') == 'native'}
    <div class="simpleblog__listing__post__wrapper__footer__block slpwfb">
        <span>
            <a href="{$post.url}#phsimpleblog_comments">{$post.comments} {l s='comments'  d='Modules.Phsimpleblog.Shop'}</a>
        </span>
    </div>
    {/if}
    {if Configuration::get('PH_BLOG_DISPLAY_VIEWS')}
    <div class="simpleblog__listing__post__wrapper__footer__block slpwfb">
        <span>
            {$post.views} {l s='views'  d='Modules.Phsimpleblog.Shop'}
        </span>
    </div>
    {/if}
    {if $is_category eq false && Configuration::get('PH_BLOG_DISPLAY_CATEGORY') && false}
    <div class="simpleblog__listing__post__wrapper__footer__block slpwfb">
        <span>
        <a href="{$post.category_url}" title="{$post.category}" rel="category">{$post.category}</a>
        </span>
    </div>
    {/if}
    <div itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
        <div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
          <meta itemprop="url" content="{$urls.shop_domain_url|rtrim:'/'}{$shop.logo}">
        </div>
        <meta itemprop="name" content="{Configuration::get('PS_SHOP_NAME')}">
        <meta itemprop="email" content="{Configuration::get('PS_SHOP_EMAIL')}">
    </div>
    <meta itemprop="datePublished" content="{$post.date_add}">
    <meta itemprop="dateModified" content="{$post.date_upd}">
    <meta itemprop="mainEntityOfPage" content="{$urls.shop_domain_url}">
</div><!-- .simpleblog__listing__post__wrapper__footer -->