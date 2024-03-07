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
{extends file='layouts/layout-error.tpl'}

{block name='content'}

  <section id="main">

      <div class="logo"><img src="{$shop.logo}" width="200" alt="logo"></div>

      <div id="message">

        <div class="title">
          <h1>{block name='page_title'}{l s='Our website is almost ready.' d='Shop.Theme.Global'}{/block}</h1>

          <section id="content" class="page-content page-maintenance">
              {$maintenance_text nofilter}
          </section>

          {block name='page_content_container'}
            <section id="content" class="page-content page-maintenance">
              {block name='page_content'}
                {* {$maintenance_text nofilter} *}
              {/block}
            </section>
          {/block}
        </div>
        
        {block name='hook_maintenance'}
          {$HOOK_MAINTENANCE nofilter}
        {/block}

      </div>

  </section>

{/block}