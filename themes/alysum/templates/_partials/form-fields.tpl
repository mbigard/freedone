{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

{function name="svgic" id='' class=''}
    <svg class="svgic {$class}">
        <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
    </svg>
{/function}
    
{if isset($field.type)}
{if $field.type == 'hidden'}

    {block name='form_field_item_hidden'}
        <input type="hidden" name="{$field.name}" value="{$field.value}">
    {/block}

{else}
    <div class="form-group row{if !empty($field.errors)} has-error{/if}{if !$field.required} field-optional{/if}">
        {if isset($field.show_label) && $field.show_label != false || !isset($field.show_label)}
            <label class="col-md-4 form-control-label{if $field.required} required{/if}">
                {if $field.type !== 'checkbox'}
                    {$field.label}
                {/if}
            </label>
        {/if}
        <div class="col-md-8{if ($field.type === 'radio-buttons')} form-control-valign{/if}">
            <div class="relative">
                {if $field.type === 'select'}

                    {block name='form_field_item_select'}
                        <select class="form-control form-control-select" name="{$field.name}" {if $field.required}required{/if}>
                            <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                            {foreach from=$field.availableValues item="label" key="value"}
                                <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
                            {/foreach}
                        </select>
                    {/block}

                {elseif $field.type === 'countrySelect'}
                    {block name='form_field_item_country'}
                        <select class="form-control form-control-select js-country" name="{$field.name}"
                            {if $field.required}required{/if}>
                            <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                            {foreach from=$field.availableValues item="label" key="value"}
                                <option value="{$value}" {if $value eq $field.value}selected{/if}>{$label}</option>
                            {/foreach}
                        </select>
                    {/block}

                {elseif $field.type === 'radio-buttons'}

                    {block name='form_field_item_radio'}
                        {foreach from=$field.availableValues item="label" key="value"}
                            <label class="radio-inline">
                                <span class="custom-radio">
                                    <input name="{$field.name}" type="radio" value="{$value}" {if $field.required}required{/if}
                                        {if $value eq $field.value} checked{/if}>
                                    <span></span>
                                </span>
                                {$label}
                            </label>
                        {/foreach}
                    {/block}
                {elseif $field.type === 'checkbox'}

                    {block name='form_field_item_checkbox'}
                        <span class="custom-checkbox">
                            <input name="{$field.name}" id="{$field.name}" type="checkbox" value="1"
                                {if $field.value}checked="checked" {/if} {if $field.required}required{/if}>
                            <span>
                                {svgic id='done' class='svgic-done'}
                            </span>
                            {* <label for="{$field.name}">{$field.label nofilter}</label> *}
                            <label for="{$field.name}">{$field.label|unescape:'html' nofilter}</label>
                        </span>
                    {/block}

                {elseif $field.type === 'date'}

                    {block name='form_field_item_date'}
                        <input class="form-control" type="date" value="{$field.value}"
                            placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}">
                        {if isset($field.availableValues.comment)}
                            <span class="form-control-comment">
                                {$field.availableValues.comment}
                            </span>
                        {/if}
                    {/block}

                {elseif $field.type === 'birthday'}
                    {block name='form_field_item_birthday'}
                        <div class="js-parent-focus">
                            {html_select_date field_order=DMY time={$field.value}
                                field_array={$field.name}
                                prefix=false
                                reverse_years=true
                                field_separator='<br>'
                                day_extra='class="form-control form-control-select"'
                                month_extra='class="form-control form-control-select"'
                                year_extra='class="form-control form-control-select"'
                                day_empty={l s='-- day --' d='Shop.Forms.Labels'}
                                month_empty={l s='-- month --' d='Shop.Forms.Labels'}
                                year_empty={l s='-- year --' d='Shop.Forms.Labels'}
                                start_year={'Y'|date}-100 end_year={'Y'|date}
                            }
                        </div>
                    {/block}

                {elseif $field.type === 'password'}

                    {block name='form_field_item_password'}
                        <div class="input-group-dis js-parent-focus">
                            {if (isset($field.icon))}<div class="icon-true relative">{/if}
                                <input class="form-control js-child-focus js-visible-password" name="{$field.name}" type="password"
                                    placeholder="{l s='Password' d='Shop.Theme.Global'}" value=""
                                    pattern=".{literal}{{/literal}5,{literal}}{/literal}" {if $field.required}required{/if}>
                                <span class="focus-border"><i></i></span>
                                {if (isset($field.icon))}
                                    {svgic id={$field.icon} class='input-icon'}
                                </div>
                            {/if}
                            <span class="input-group-btn" style="display:none">
                                <button class="btn" type="button" data-action="show-password"
                                    data-text-show="{l s='Show' d='Shop.Theme.Actions'}"
                                    data-text-hide="{l s='Hide' d='Shop.Theme.Actions'}">
                                    {l s='Show' d='Shop.Theme.Actions'}
                                </button>
                            </span>
                        </div>
                    {/block}

                {else}

                    {block name='form_field_item_other'}
                        <div class="relative">
                            {if (isset($field.icon))}<div class="icon-true">{/if}
                                <input
                                    name="{$field.name}"
                                    class="form-control"
                                    value="{$field.value}"
                                    type="{if $field.type == 'firstname'}text{else}{$field.type}{/if}" 
                                    placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{else}{$field.label}{/if}"
                                    {if $field.maxLength} maxlength="{$field.maxLength}"{/if}
                                    {if $field.required} required{/if}>
                                    <span class="focus-border"><i></i></span>
                            {if (isset($field.icon))}{svgic id={$field.icon} class='input-icon'}</div>{/if}
                        </div>
                        {if isset($field.availableValues.comment)}
                            <span class="form-control-comment">
                                {$field.availableValues.comment}
                            </span>
                        {/if}
                    {/block}
                {/if}

                {block name='form_field_errors'}
                    {include file='_partials/form-errors.tpl' errors=$field.errors}
                {/block}

                <div class="form-control-comment">
                    {block name='form_field_comment'}
                        {if (!$field.required && !in_array($field.type, ['radio-buttons', 'checkbox', 'password']))}
                            {l s='Optional' d='Shop.Forms.Labels'}
                        {/if}
                    {/block}
                </div>

            </div>
        </div>
    </div>
{/if}
{/if}