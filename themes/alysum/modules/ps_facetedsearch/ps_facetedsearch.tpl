{if isset($listing.rendered_facets) && ($listing.rendered_facets != "")}
<div id="search_filters_wrapper">
    {if Context::getContext()->isMobile()}
      <button class="btn filter-btn" data-toggle="collapse" data-target="#search_filters">
        {l s='Products Filter' d='Shop.Theme.Actions'}
      </button>
    {/if}
	{block name='product_list_active_filters'}
		{$listing.rendered_active_filters nofilter}
	{/block}
	{$listing.rendered_facets nofilter}
</div>
{/if}