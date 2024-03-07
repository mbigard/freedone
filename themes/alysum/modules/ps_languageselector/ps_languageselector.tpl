<div class="lang-select user-select relative">
    <div class="langs dd_el">
        <div class="current-item cp smooth02">
            <span class="flex-container align-items-center icon-element">
                <svg class="svgic">
                    <use href="{_THEME_IMG_DIR_}lib.svg#globe"></use>
                </svg>
                <span>{l s='Language' d='Modules.Languageselector.Shop'}</span>
            </span>
        </div>
        <ul class="opt-list dd_container dd_view">
            {foreach from=$languages item=lang}
                <li class="smooth02 cp main_bg_hvr">
                    <img class="fl" src="{$urls.img_lang_url}{$lang.id_lang}.jpg" width="16" height="11"
                        alt="{$lang.name_simple}">
                    {if ($language.id != $lang.id_lang)}
                        <a class="fl ellipsis" href="{url entity='language' id=$lang.id_lang}" data-iso-code="{$lang.iso_code}"
                            title="{$lang.name}">
                        {/if}
                        {$lang.name_simple}
                        {if ($language.id != $lang.id_lang)}
                        </a>
                    {/if}
                </li>
            {/foreach}
        </ul>
    </div>
</div>