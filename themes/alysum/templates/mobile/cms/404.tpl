{*
* 2011-2021 Promokit
*
* @package   pkamp
* @version   2.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2021 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}
 
<!doctype html>
<html ⚡>

  {block name='head'}
    {include file='mobile/_partials/head.tpl'}
  {/block}

  <body id="page-404">

    {block name='header'}
      {include file='mobile/_partials/header.tpl'}
    {/block}

    <main class="m40 general-item">
      
      <h2 class="text-center">The page not found</h2>
        
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