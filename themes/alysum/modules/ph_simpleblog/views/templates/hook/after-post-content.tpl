{if Configuration::get('PH_BLOG_DISPLAY_SHARER')}
<div class="post-block simpleblog-socialshare">
	<h3 class="block-title">{l s='Share this post' d='Modules.Phsimpleblog.Shop'}</h3>
	<div class="simpleblog-socialshare-icons simpleblog__share">
    	{include file='catalog/_partials/product-additional-info.tpl' justlist="1"}
	</div><!-- simpleblog-socialshare-icons. -->
</div><!-- .simpleblog-socialshare -->
{/if}