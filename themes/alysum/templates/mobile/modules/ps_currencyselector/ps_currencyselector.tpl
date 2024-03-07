{if (isset($amp.header.curr.currencies))}
<ul class="currencies-list user-list">
	{foreach from=$amp.header.curr.currencies item=currency_item}
	<li class="dropdown-option cp smooth02">
		<a rel="nofollow" class="currency-sign main_color{if $currency.name == $currency_item.name} active_item{/if}" href="{$currency_item.url}">{$currency_item.sign} {$currency_item.name}</a>
	</li>
	{/foreach}
</ul>
{/if}