<div class="curr-select user-select relative">
    <div class="currencies dd_el">
        <div class="current-item cp dib smooth02">
            <span class="flex-container align-items-center icon-element">
                <svg class="svgic">
                    <use href="{_THEME_IMG_DIR_}lib.svg#currency"></use>
                </svg>
                <span>{l s='Currency' d='Modules.Currencyselector.Shop'}</span>
            </span>
        </div>
        <ul class="opt-list dd_container dd_view">
            {foreach from=$currencies item=currency}
                <li class="dropdown-option cp smooth02{if $currency.current} current{/if}">
                    <a rel="nofollow" class="currency-sign main_color" href="{$currency.url}">{$currency.sign}
                        {$currency.name}
                    </a>
                </li>
            {/foreach}
        </ul>
    </div>
</div>