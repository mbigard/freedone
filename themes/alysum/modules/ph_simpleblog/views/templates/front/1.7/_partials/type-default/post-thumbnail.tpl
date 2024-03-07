{if Configuration::get('PH_BLOG_DISPLAY_THUMBNAIL') && (isset($post.banner_wide) || isset($post.banner_thumb))}
<a href="{$post.url}" aria-label="{$post.title}"{if isset($style) && $style == 'style-2'} class="square-content" style="background-image: url('{$post.banner_thumb}')"{/if}>
    {if $blogLayout eq 'full'}
      {assign var="postimage" value="{$post.banner_wide}"}
    {else}
      {assign var="postimage" value="{$post.banner_thumb}"}
    {/if}
    {assign var="postimage" value="{$post.banner_thumb}"}
    <img src="{$postimage}" alt="{$post.title}" width="1170" height="658" class="img-fluid photo w-100 db" loading="lazy">
</a>
{/if}