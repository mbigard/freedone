{if isset($amp.header.langs.languages)}
<ul class="languages-list user-list">
	{foreach from=$amp.header.langs.languages item=lang}
	<li class="flex-container align-items-center">
		<amp-img src="{$urls.img_lang_url}{$lang.id_lang}.jpg" width="24" height="17" alt="{$lang.name}"></amp-img>
		{if ($language.id != $lang.id_lang)}
			<a class="ellipsis flex-grow1" href="{$link->getLanguageLink($lang.id_lang)}" title="{$lang.name}">
		{/if}
			{$lang.name}
		{if ($language.id != $lang.id_lang)}
			</a>
		{/if}
	</li>
	{/foreach}
</ul>
{/if}