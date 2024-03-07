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
 
{block name='product_countdown'}
  {if isset($product.embedded_attributes.specific_prices.to)}
      {assign var=to value="-"|explode:$product.embedded_attributes.specific_prices.to}
      {if $to[0] != "0000"}
        <div class="countdown flex-container countdown-{$product.id_product|intval}"
          data-product_id="{$product.id_product|intval}"
          data-until="{$product.embedded_attributes.specific_prices.to|date_format:'%Y-%m-%dT%H:%M:%S'}"
          data-titles='&lcub;"year":"{l s='Year' d='Shop.Theme.Actions'}","month":"{l s='Months' d='Shop.Theme.Actions'}","day":"{l s='Days' d='Shop.Theme.Actions'}","hour":"{l s='Hours' d='Shop.Theme.Actions'}","minute":"{l s='Min' d='Shop.Theme.Actions'}","second":"{l s='Sec' d='Shop.Theme.Actions'}"&rcub;'></div>
      {/if}
  {/if}
{/block}