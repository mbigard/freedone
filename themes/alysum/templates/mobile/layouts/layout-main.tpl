{*
* 2011-2022 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2022 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}
 
<!doctype html>
<html amp lang="{$language.iso_code}">

  {block name='head'}
    {include file='mobile/_partials/head.tpl'}
  {/block}

  <body id="{if $page.page_name == 'module-pkamp-order'}checkout{else}{$page.page_name|replace:'module-pkamp-':''}{/if}" class="{$page.body_classes|classnames}">
  {if (isset($amp.config.general.googletagmanager.state) && $amp.config.general.googletagmanager.state == 1) && (isset($amp.config.general.googletagmanager.id) && $amp.config.general.googletagmanager.id != '')}
  <amp-analytics config="https://www.googletagmanager.com/amp.json?id={$amp.config.general.googletagmanager.id}&gtm.url={$urls.current_url}" data-credentials="include"></amp-analytics>
  {/if}

    {block name='header'}
      {include file='mobile/_partials/header.tpl'}
    {/block}

    <main class="m40 general-item">

      {if isset($page_error)}
        {$page_error}
      {else}

        {block name='content'}
          <p>AMP layout-main.tpl Content</p>
        {/block}

      {/if}
        
    </main>

    {block name='footer'}
      {include file='mobile/_partials/footer.tpl'}
    {/block}

    {block name='sidebars'}
      {include file='mobile/_partials/sidebars.tpl'}
    {/block}

    {hook h='displayAmpBeforeBodyCloseTag'}
  </body>
</html>