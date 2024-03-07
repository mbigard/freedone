{if Configuration::get('PH_BLOG_DISPLAY_MORE')}
<div class="simpleblog__listing__post__wrapper__content__footer">
    <a href="{$post.url}" class="btn btn-primary" title="{$post.title|htmlspecialchars}">
        {l s='Read more' d='Modules.Phsimpleblog.Shop'}
    </a>
</div>
{/if}