{*
* Promokit AMP
*
* @package   pk_amp
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
* @version   1.0.2
* @author    https://promokit.eu
*}
<amp-sidebar id="{$tglIdMenu}" class="lang-select user-select relative" layout="nodisplay" side="left">

	{include file='mobile/_partials/button-close.tpl' togglerId=$togglerId togglerTitle={l s='Menu' d='Shop.Theme.Amp'}}

	{function name="menu" nodes=[] depth=0}
	  {strip}
	    {if $nodes|count}
	      <amp-accordion animate class="section-wrap{if $depth == 0} full-w{else} inner-accordion{/if}">
	        {foreach from=$nodes item=node}
		        <section class="{$node.type}{if $node.current} current{/if}{if $node.children|count} parent{/if}"{if (isset($amp.config.menu.items.state) && ($amp.config.menu.items.state == 'expanded'))} expanded{/if}>
					    <h4>
					    	<div class="flex-container align-items-center">
							  <a class="roboto flex-grow1" href="{$node.url}" {if $node.open_in_new_window} target="_blank" {/if}>{$node.label}</a>
							  {if (!empty($node.children))}
							  <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
							  {/if}
							  </div>
					    </h4>
					    <div>
					    {if (!empty($node.children))}
	              {menu nodes=$node.children depth=$node.depth}
	            {/if}
	            </div>
					  </section>
	        {/foreach}
	      </amp-accordion>
	    {/if}
	  {/strip}
	{/function}

  {menu nodes=$amp.menu.children}
  
</amp-sidebar>