{*
* 2011-2021 Promokit
*
* @package   pk_amp
* @version   1.1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2021 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<header class="m20 general-item style2">
  <div class="header-top flex-container align-items-center">

    {if isset($amp.config.header.accounticon) && ($amp.config.header.accounticon == 1)}
    {include file='mobile/_partials/button-toggler.tpl' togglerId=$tglIdSidebar togglerIcon='account' togglerClass='clear-button'}
    {/if}
    {if isset($amp.config.header.lngicon) && ($amp.config.header.lngicon == 1)}
    {include file='mobile/_partials/button-toggler.tpl' togglerId='language' togglerIcon='language' togglerClass='clear-button'}
    {/if}
    {if isset($amp.config.header.curicon) && ($amp.config.header.curicon == 1)}
    {include file='mobile/_partials/button-toggler.tpl' togglerId='currency' togglerIcon='currency' togglerClass='clear-button'}
    {/if}
    {if isset($amp.config.header.searchicon) && ($amp.config.header.searchicon == 1)}
    {include file='mobile/_partials/button-toggler.tpl' togglerId=$tglIdSearch togglerIcon='search' togglerClass='clear-button'}
    {/if}
    {if isset($amp.config.header.carticon) && ($amp.config.header.carticon == 1)}
    {include file='mobile/_partials/button-toggler.tpl' togglerId=$tglIdCart togglerIcon='cart' togglerClass='clear-button'}
    {/if}

  </div>

  <div class="header-bottom flex-container">

    {include file='mobile/_partials/logo.tpl'}

    <div class="menu flex-container">
      {include file='mobile/_partials/button-toggler.tpl' togglerId='selector-menu' togglerIcon='burger' togglerClass='clear-button reverse-order w100 text-uppercase'}
    </div>

  </div>

  {if ( ($page == "category") || ($page == "product") ) && isset($amp.config.header.breadcrumb) && ($amp.config.header.breadcrumb == 1)}
    <div class="container breadcrumb-container relative">
      <div class="fixed-width">{include file='mobile/_partials/breadcrumb.tpl'}</div>
    </div>
  {/if}

</header>