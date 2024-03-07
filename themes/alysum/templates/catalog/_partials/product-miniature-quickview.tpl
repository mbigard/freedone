{if $pkconf.pm_qw_button}
    <a href="#" class="quick-view btn btn-primary smooth05" data-link-action="quickview"
        title="{l s='Quick view' d='Shop.Theme.Actions'}" aria-label="{l s='Quick view' d='Shop.Theme.Actions'}"
        role="button">
        {if isset($urls)}
            <svg class="svgic svgic-search">
                <use href="{_THEME_IMG_DIR_}lib.svg#search"></use>
            </svg>
        {/if}
    </a>
{/if}