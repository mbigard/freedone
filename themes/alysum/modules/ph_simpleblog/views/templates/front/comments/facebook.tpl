{*
* 2007-2014 PrestaShop
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
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<div id="simpleblog-post-comments" class="post-block">
	<h3 class="block-title">{l s='comments' d='Modules.Phsimpleblog.Shop'} (<fb:comments-count href={$post->url|escape:'html':'UTF-8'}/></fb:comments-count>)</h3>
	<div class="fb-comments" data-href="{$post->url|escape:'html':'UTF-8'}" data-colorscheme="{Configuration::get('PH_BLOG_FACEBOOK_COLOR_SCHEME')|escape:'html':'UTF-8'}" data-numposts="5" data-width="100%"></div>
</div>