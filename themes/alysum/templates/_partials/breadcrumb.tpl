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
 {function name="listItem" link='' title=''}
    <li>
        {if $link != ''}<a href="{$link}">{/if}
            <span>{$title}</span>
        {if $link != ''}</a>{/if}
    </li>
{/function}

{if isset($page.page_name) && $page.page_name !== 'index'}
<nav data-depth="{$breadcrumb.count}" class="breadcrumb page-width hidden-md-down">
  <ol class="p-a-0">
    {if ($breadcrumb.count == 1) && ($page.page_name != 'index')}
      {$breadcrumb.links.1.title = $page.meta.title}
      {$breadcrumb.links.1.url = '#'}
    {/if}

    {foreach from=$breadcrumb.links item=path name=breadcrumb}
      {if !empty($path)}
        {block name='breadcrumb_item'}
            {if not $smarty.foreach.breadcrumb.last}
                {listItem link=$path.url title=$path.title}
            {else}
                {* following block displays categories of currect product. The option is currently disabled *}
                {if $page.page_name == 'product-DISABLED'}
                    {foreach from=Product::getProductCategories($product.id) item=cat}
                        {if $cat > 2}
                            {assign var='current_cat' value=Category::getCategoryInformation(array($cat))}
                            {listItem link=$link->getCategoryLink({$cat}) title=$current_cat[{$cat}]['name']}
                        {/if}
                    {/foreach}
                {else}
                    {if isset($path.title)}{listItem title=$path.title}{/if}
                {/if}
            {/if}
        {/block}
      {/if}
    {/foreach}
  </ol>
</nav>
{/if}