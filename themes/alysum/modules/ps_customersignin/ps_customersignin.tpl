<div class="header_user relative">
    <ul>
        <li class="header_user_info">
            <svg class="svgic main_color svgic-login">
                <use href="{_THEME_IMG_DIR_}lib.svg#login"></use>
            </svg>
            {if $logged}
                <a href="{$my_account_url}" class="account main_color_hvr main_color" rel="nofollow">
                    {$customer.firstname} {$customer.lastname}
                </a>
                <a href="{$logout_url}" title="{l s='Log me out' d='Modules.Customersignin.Shop'}"
                    class="logout main_color_hvr" rel="nofollow">
                    {l s='Sign out' d='Shop.Theme.Actions'}
                </a>
            {else}
                <a href="{$my_account_url}" class="login main_color_hvr" rel="nofollow">
                    {l s='Sign in' d='Shop.Theme.Actions'}
                </a>
                {l s='or' d='Modules.Customersignin.Shop'}
                <a href="{$urls.pages.register}" class="login main_color_hvr">
                    {l s='Register' d='Modules.Customersignin.Shop'}
                </a>
            {/if}
        </li>
    </ul>
</div>