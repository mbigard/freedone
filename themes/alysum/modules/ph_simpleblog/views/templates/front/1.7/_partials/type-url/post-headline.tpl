<div class="blog-headline">
    <a href="{$post.external_url}" target="_blank">
        {$post.title|truncate:"{if isset($title_length)}{$title_length}{else}999{/if}":"{if isset($title_length)}...{else}{/if}"}
    </a>
</div>