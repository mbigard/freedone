{assign var='rootClasses' value=['lang-select', 'user-select', 'relative', 'dib']}
{if isset($dropdown_position)}
    {append var='rootClasses' value="pk-position-{$dropdown_position}"}
{/if}
{if isset($skin) && $skin == 'inline'}
    {append var='rootClasses' value="pk-inline"}
{/if}

<div class="{' '|implode:$rootClasses}">
    <div class="pk-languages dd_el">
        {if isset($button_layout) && isset($button_view)}
        {assign var=params value=[
            "title" => "{l s='Language' d='Modules.Pkelements.Languages'}",
            "layout" => $button_layout,
            "view" => $button_view,
            "icon" => 'language',
            "sidebar" => false
        ]}
        {include file='module:pkelements/views/templates/_partials/headeritems/headeritem.tpl' params=$params}
        {/if}
        <ul class="opt-list{if isset($skin) && $skin == 'dropdown'} dd_container dd_view{/if}">
            {foreach from=$languages item=lang}
            <li class="smooth02 cp relative">
                <a class="flex-container align-items-center{if ($language->id == $lang.id_lang)} active{/if}" href="{if ($language->id == $lang.id_lang)}#{else}{url entity='language' id=$lang.id_lang}{/if}" data-iso-code="{$lang.iso_code}" title="{$lang.name}">
                    {if (isset($show_flag) && ($show_flag == 'yes'))}
                        <img src="{$urls.img_lang_url}{$lang.id_lang}.jpg" class="db pk-img" width="16" height="11" alt="{$lang.name}">
                    {/if}
                    {if (isset($show_name) && ($show_name == 'yes'))}
                        <span>{if (isset($show_flag) && ($show_flag == 'yes'))}&nbsp;{/if}{$lang.name}</span>
                    {/if}
                    {if (isset($show_iso_code) && ($show_iso_code == 'yes'))}
                        <span>{if (isset($show_name) && ($show_name == 'yes'))}&nbsp;{/if}{$lang.iso_code}</span>
                    {/if}
                </a>
            </li>
            {/foreach}
        </ul>
    </div>
</div>