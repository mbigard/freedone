{assign var='btnClasses' value=['current-item', 'cp', 'smooth02', 'flex-container', 'icon-element']}
{if isset($params.view)}
    {if ($params.view == 'row')}
        {append var='btnClasses' value='justify-content-center align-items-center'}
    {else}
        {append var='btnClasses' value='align-items-center'}
    {/if}
{/if}

{if isset($params.layout) && ($params.layout != 'none')}
<div class="{' '|implode:$btnClasses}"{if $params.sidebar}{if isset($params.name)} data-pktabname="{$params.name}"{/if} data-pktabgroup="{$params.name}"{if isset($params.tabsection)} data-pktabsection="{$params.tabsection}"{/if} data-pktype="sidebar"{/if}>
    {if isset($params.icon) && ($params.layout == 'icon' || $params.layout == 'icon_text')}
        <svg class="svgic">
            <use href="{_THEME_IMG_DIR_}lib.svg#{$params.icon}"></use>
        </svg>
    {/if}
    {if isset($params.title) && ($params.layout == 'text' || $params.layout == 'icon_text')}
        <span>{$params.title}</span>
    {/if}
    {if (isset($params.counter))}
        {assign var='counterClasses' value=['header-item-counter', (isset($params.counterClass)) ? $params.counterClass : '']}
        <span class="{' '|implode:$counterClasses}" data-productsnum="{$params.counter}">{$params.counter}</span>
    {/if}
</div>
{/if}
