{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
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
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<!doctype html>
<html lang="{$language.iso_code}">

<head>
    {block name='head'}
        {include file='_partials/head.tpl'}
    {/block}
</head>

<body id="{$page.page_name}" class="{$page.body_classes|classnames}">

    {hook h='displayAfterBodyOpeningTag'}

    {block name='header'}
        {include file='_partials/header.tpl'}
    {/block}

    {block name='notifications'}
        {include file='_partials/notifications.tpl'}
    {/block}

    <div id="main-content">
    <section id="wrapper" class="flex-container page-width">
        <div class="container">
            {block name='content'}
                <section id="content" class="flex-container checkout-steps">
                    <div class="checkout-step-items flex-grow1">
                        {block name='checkout_process'}
                            {render file='checkout/checkout-process.tpl' ui=$checkout_process}
                        {/block}
                    </div>
                    <div class="cart-total">
                        {block name='cart_summary'}
                            {include file='checkout/_partials/cart-summary.tpl' cart = $cart}
                        {/block}
                        {hook h='displayFrontCodeAssociations' mod='codeassociations'}
                        {hook h='displayReassurance'}
                    </div>
                </section>
            {/block}
        </div>
    </section>
    </div>

    <footer id="footer" class="relative">
        {include file='_partials/footer.tpl'}
    </footer>

    {block name='javascript_bottom'}
        {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
    {/block}

    {block name='hook_before_body_closing_tag'}
        {hook h='displayBeforeBodyClosingTag'}
    {/block}

</body>

</html>