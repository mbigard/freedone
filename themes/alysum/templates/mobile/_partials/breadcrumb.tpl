{**
 * 2007-2019 PrestaShop
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
 * @copyright 2007-2019 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

<nav data-depth="{$breadcrumb.count}" class="breadcrumb page-width container hidden-md-down">
  <div class="row h-100">
    <div class="col-xs-12">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="p-a-0">
      {if ($breadcrumb.count == 1)}
        {$breadcrumb.links.1.title = $page.meta.title}
        {$breadcrumb.links.1.url = '#'}
      {/if}
      {foreach from=$breadcrumb.links item=path name=breadcrumb}
      {block name='breadcrumb_item'}
        {if not $smarty.foreach.breadcrumb.last}
        <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <a itemprop="item" href="{$path.url}">
            <span itemprop="name">{$path.title}</span>
          </a>
          <meta itemprop="position" content="{$smarty.foreach.breadcrumb.iteration}">
        </li>
        {elseif isset($path.title)}
          <li>
            <span>{$path.title}</span>
          </li>
        {/if}
      {/block}
      {/foreach}
    </ol>
    </div>
  </div>
</nav>