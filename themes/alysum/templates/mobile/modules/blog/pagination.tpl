<!-- Pagination -->
{if $start!=$stop}
<nav class="blog-pagination">
  <ul class="flex-container">
  	{if $p != 1}
	{assign var='p_previous' value=$p-1}
	<li>
		<a rel="prev" href="{SimpleBlogPost::getPageLink($p_previous, $type, $rewrite)}" class="previous disabled "><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#arrowleft"></use></svg></a>
	</li>
{else}
	<li>
		<a rel="prev" href="#" class="previous disabled "><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#arrowleft"></use></svg></a>
	</li>
{/if}
{if $start > 1}
	<li><a href="{SimpleBlogPost::getPageLink(1, $type, $rewrite)}">1</a></li>
	<li>
		<span class="spacer">…</span>
	</li>
{/if}
{section name=pagination start=$start loop=$stop+1 step=1}
	{if $p == $smarty.section.pagination.index}
		<li class="current">
			<a href="#" class="disabled">{$p}</a>
		</li>
	{else}
		<li>
			<a href="{SimpleBlogPost::getPageLink($smarty.section.pagination.index, $type, $rewrite)}">{$smarty.section.pagination.index}</a>
		</li>
	{/if}
{/section}
      {if $pages_nb>$stop}
	<li>
		<span class="spacer">…</span>
	</li>
	<li><a href="{SimpleBlogPost::getPageLink($pages_nb, $type, $rewrite)}">{$pages_nb|intval}</a></li>
{/if}
{if $pages_nb > 1 AND $p != $pages_nb}
	{assign var='p_next' value=$p+1}
	<li>
            <a rel="next" href="{SimpleBlogPost::getPageLink($p_next, $type, $rewrite)}" class="next ">
            	<svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#arrowright"></use></svg>
            </a>
        </li>
{else}
	<li>
            <a rel="next" href="#" class="next  disabled"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#arrowright"></use></svg></a>
        </li>
{/if}
  </ul>
</nav>
{/if}