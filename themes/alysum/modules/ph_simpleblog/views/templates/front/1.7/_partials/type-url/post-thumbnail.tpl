{if Configuration::get('PH_BLOG_DISPLAY_THUMBNAIL') && (isset($post.banner_wide) || isset($post.banner_thumb))}
<a href="{$post.external_url}" target="_blank" itemprop="url">
    {if $blogLayout eq 'full'}
        <img src="{$post.banner_wide}" alt="{$post.title}" itemprop="image" class="img-fluid photo w-100 db">
    {else}
        <img src="{$post.banner_thumb}" alt="{$post.title}" itemprop="image" class="img-fluid photo w-100 db">
    {/if}
</a>
{/if}