{*
* 2011-2021 Promokit
*
* @package   pk_amp
* @version   1.1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2021 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{hook h='displayAmpVars'}
{assign var="tglIdCart" value="selector-cart"}
{assign var="tglIdSearch" value="selector-search"}
{assign var="tglIdSidebar" value="sidebar"}
{assign var="page" value=$page.page_name|replace:'module-pkamp-':''}

{if (isset($amp.config.header.layout))}
  {include file="mobile/_partials/header/{$amp.config.header.layout}.tpl"}
{else}
  {include file='mobile/_partials/header/style1.tpl'}
{/if}