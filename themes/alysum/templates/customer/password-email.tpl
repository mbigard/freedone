{**
 * 2007-2020 PrestaShop
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
 * @copyright 2007-2020 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file='page.tpl'}

{block name='page_title'}
    {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
    <div class="col-xs-12">
        <form action="{$urls.pages.password}" class="forgotten-password" method="post">
            {if !empty($errors)}
                <ul class="ps-alert-error list-style-none alert alert-danger">
                    {foreach $errors as $error}
                        <li class="item">
                            <i>
                                <svg class="svgic" viewBox="0 0 24 24">
                                    <path
                                        d="M11,15H13V17H11V15M11,7H13V13H11V7M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20Z">
                                    </path>
                                </svg>
                            </i>
                            {$error}
                        </li>
                    {/foreach}
                </ul>
            {/if}

            <header>
                <p class="send-renew-password-link">
                    {l s='Please enter the email address you used to register. You will receive a temporary link to reset your password.' d='Shop.Theme.Customeraccount'}
                </p>
            </header>

            <section class="form-fields">
                <div class="form-group">
                    <div class="icon-true relative">
                        <input type="email" name="email" id="email"
                            value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}"
                            class="form-control password-forgot" required
                            placeholder="{l s='Email address' d='Shop.Forms.Labels'}">
                        <svg class="svgic input-icon">
                            <use href="{_THEME_IMG_DIR_}lib.svg#email"></use>
                        </svg>
                    </div>
                </div>
            </section>

            <footer class="form-footer">
                <button class="form-control-submit btn btn-primary" name="submit" type="submit">
                    {l s='Send reset link' d='Shop.Theme.Actions'}
                </button>
            </footer>

        </form>
    </div>
{/block}