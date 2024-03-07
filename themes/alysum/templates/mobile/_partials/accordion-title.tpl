{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<h4 class="m20">
    <div class="roboto flex-container align-items-center">
        <span class="flex-grow1">
            {if isset($togglerTitle)}
                {if ($togglerTitle == 'login')}
                    {l s='Login' d='Shop.Theme.Amp'}/
                    {l s='Register' d='Shop.Theme.Amp'}
                {else}
                    {$togglerTitle|unescape}
                {/if}
            {else}
                {l s='Accordion Title' d='Shop.Theme.Amp'}
            {/if}
        </span>
        <svg class="svgic smooth">
            <use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use>
        </svg>
    </div>
</h4>