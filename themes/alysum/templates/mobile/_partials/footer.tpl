{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}
 
<footer id="footer" class="general-item">
  <div class="flex-container align-items-center flex-column w100 footer-wrapper bs">
    <div class="footer-links w100 m40">
      {if !empty($amp.footer.linkBlocks)}
      <amp-accordion animate>
      {foreach from=$amp.footer.linkBlocks item=block}
        <section expanded>
          {include file='mobile/_partials/accordion-title.tpl' togglerTitle={$block.title}}
          <div>
            {if !empty($block.links)}
            <ul>
            {foreach from=$block.links item=link}
              {if ($link.id == 'link-static-page-authentication')}
                <li><a on="tap:sidebar.toggle" href="#">{$link.title}</a></li>
              {else}
                <li><a href="{$link.url}">{$link.title}</a></li>
              {/if}
            {/foreach}
            </ul>
            {else}
              {l s="No links here" d="Shop.Theme.Amp"}
            {/if}
          </div>
        </section>
      {/foreach}
      </amp-accordion>
      {/if}
    </div>
    <div class="footer_bottom_hook text-center">
      {if $amp.config.footer.socialdisplay == 1}
        <div id="socialnetworks" class="m15">
          <ul class="socialnetworks_menu flex-container justify-center">
          {foreach from=$amp.config.footer.social item=s key=name}
          {if !empty($s)}
          <li class="{$name}">
            <a rel="noreferrer" class="smooth02 flex-container align-items-center justify-center icon-{$name}" title="{$name}" target="_blank" href="{$s}"><svg class="svgic svgic-{$name}"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#{$name}"></use></svg></a>
          </li>
          {/if}
          {/foreach}
          </ul>
        </div>
      {/if}
      {if $amp.config.footer.paymentdisplay == 1}
        <div class="payment-methods m15">
          <ul class="flex-container justify-center">
          {foreach from=$amp.config.footer.payment item=s key=name}
          {if (!empty($s) && $s == 1)}
          <li class="{$name}">
            <svg class="svgic svgic-{$name}"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#{$name}"></use></svg>
          </li>
          {/if}
          {/foreach}
          </ul>
        </div>
      {/if}
    </div>
    <div class="footer_text text-center">
      {l s="2021 - Developed by promokit.eu" d="Shop.Theme.Amp"}
    </div>
  </div>
</footer>
{include file='mobile/_partials/cookies.tpl'}
{include file='mobile/_partials/svg.tpl'}
{include file='mobile/_partials/footer-bottom.tpl'}