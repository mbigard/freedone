{*
* 2007-2020 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2020 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{function name="subscribtion_form" param=[]}
    <div class="newsletter-form relative">
        <div class="newsletter-form-input relative relative-input">
            <input class="newsletter-input-popup newsletter-input" type="email" name="email"
                placeholder="{l s='Your e-mail address' d='Modules.Emailsubscription.Shop'}"
                value="{if isset($value) && $value}{$value}{/if}" required>
            <button class="send-reqest" aria-label="submit subscription">
                <svg class="svgic">
                    <use href="{_THEME_IMG_DIR_}lib.svg#right-arrow-thin"></use>
                </svg>
            </button>
        </div>
        <div class="newsletter-form-info">
            {if $conditions && $param.conditions}
                <p>{$conditions}</p>
            {/if}
            {if $msg}
                <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
                    {$msg}
                </p>
            {/if}
            {if isset($id_module)}
                {hook h='displayGDPRConsent' id_module=$id_module}
            {/if}
            <input type="hidden" name="action_wdg" value="0">
            <input type="hidden" name="action" value="0">
        </div>
    </div>
{/function}

{if !isset($formonly)}
    {subscribtion_form param=['conditions' => false]}
{else}
    <div id="newsletter_block_left" class="email_subscription block">
        <h4>{l s='Stay up to date' d='Modules.Emailsubscription.Shop'}</h4>
        <div class="block_content">
            {if $msg}
                <p class="{if $nw_error}warning_inline{else}success_inline{/if}">{$msg}</p>
            {/if}
            {subscribtion_form param=['conditions' => true]}
        </div>
    </div>
{/if}