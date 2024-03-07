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

{* get elementor template ID in Editor mode *}
{assign var="controller" value=(isset($smarty.get.controller)) ? $smarty.get.controller : false}
{assign var='preview_id' value=(isset($smarty.get.uid)) ? $smarty.get.uid : false}
{assign var='preview_id' value=(isset($smarty.get.preview_id)) ? $smarty.get.preview_id : $preview_id}
{assign var='partial_id' value=($preview_id) ? substr($preview_id, -6, 2) : 0}
{assign var='show_block' value=((!$preview_id || $partial_id > 1) && (isset($pktheme) && !empty($pktheme))) ? true : false}

{function name="CEEditorBlock"}
    {if $controller == 'index' && isset($PKCE)} {* these hooks used to edit elementor "Content Anywhere" *}
        {assign var="hookName" value=$PKCE::getUidHook($preview_id)}
        {if $hookName}{hook h=$hookName}{/if}
    {/if}

    {if $controller == 'preview'} {* block for elementor preview mode *}
        {block name='content'}{/block}
    {/if}

    {if $controller == 'cms'} {* block used to edit elementor CMS pages *}
        {block name='page_content_container'}{/block}
        {$cms_category.description nofilter}
    {/if}

    {if $controller == 'product'} {* block used to edit product footer & description *}
        <div class="elementor-template-hook">
            {block name="content_wrapper"}{/block}
        </div>
    {/if}

    {if $controller == 'category'} {* block used to edit category description *}
        {$category.description nofilter}
    {/if}

    {if $controller == 'manufacturer'} {* block used to edit brand description *}
        {$manufacturer.description nofilter}
    {/if}
{/function}

{function name="CategoryCEBlock"}
    {if ($pktheme.cp_builder_layout == -1)}
        {hook h='displayCategoryPageBuilder'}
    {else}
        {hook h='CETemplate' id="{$pktheme.cp_builder_layout}"}
    {/if}
{/function}

{function name="HomePageBlock"}
    {if $pktheme.hp_builder == 0}
        {hook h='displayHomeBuilder'}
    {else}
        {hook h='CETemplate' id="{$pktheme.hp_builder}"}
    {/if}
{/function}

{function name="SecondaryPagesTopBlock"}
    <div class="page-width top-content">
        {block name='notifications'}
            {include file='_partials/notifications.tpl'}
        {/block}

        {block name='breadcrumb'}
            {include file='_partials/breadcrumb.tpl'}
        {/block}
    </div>
{/function}

{function name="SecondaryPagesMainBlock"}
    <div class="page-width main-content">
        <div id="wrapper" class="clearfix container">
            <div class="row">

                {block name='left_column'}
                    <div id="left-column" class="sidebar col-xs-12 col-sm-4 col-md-3 relative smooth05">
                        {hook h='displayLeftColumn'}
                        <div class="sidebar-toggler flex-container align-items-center justify-content-center smooth05 hidden">
                            <svg class="svgic smooth05">
                                <use href="{_THEME_IMG_DIR_}lib.svg#arrowleft"></use>
                            </svg>
                        </div>
                    </div>
                {/block}

                {block name='content_wrapper'}
                    <div id="content-wrapper" class="wide left-column right-column">
                        {block name='content'}{/block}
                    </div>
                {/block}

            </div>
        </div>
    </div>
{/function}

{function name="SecondaryPagesBlock"}
    {SecondaryPagesTopBlock}
    {if ($page.page_name == 'category') && ($pktheme.cp_builder_layout != 0)}
        {CategoryCEBlock}
    {else}
        {SecondaryPagesMainBlock}
    {/if}
{/function}

{function name="PagesBlock"}
    {if ($page.page_name == 'index')}
        {HomePageBlock}
    {else}
        {SecondaryPagesBlock}
    {/if}
{/function}

{function name="FrontPageContentBlock"}
    {if !isset($pktheme) || empty($pktheme)}
        <p class="alert alert-danger">
            "Theme Settings" module error. Make sure the module is installed, enabled, and hooked on "displayHeader" hook.
        </p>
    {else}
        {PagesBlock}
    {/if}
{/function}

{function name="MainContentBlock"}
    <main id="main-content">
        {if $controller && $preview_id}
            {CEEditorBlock}
        {else}
            {hook h="displayWrapperTop"}

            {block name='product_activation'}
                {include file='catalog/_partials/product-activation.tpl'}
            {/block}

            {FrontPageContentBlock}

            {hook h="displayWrapperBottom"}
        {/if}
    </main>
{/function}

{function name="HeaderBlock"}
    {if $show_block}
        {include file='_partials/header.tpl'}
    {/if}
{/function}

{function name="FooterBlock"}
    {if $show_block}
        {include file='_partials/footer.tpl'}
    {/if}
{/function}