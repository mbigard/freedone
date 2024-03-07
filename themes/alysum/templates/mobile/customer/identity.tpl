{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='content'}
<section class="identity">
  
  <h2 class="page-title">{l s='Identity' d='Shop.Theme.Amp'}</h2>

  {block name='page_content'}
    
    <form action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCustomer' relative_protocol=false params=['who' => 'identity']}" method="POST">

      {render file='mobile/customer/_partials/identity-form.tpl' ui=$customer_form}
      
      <div class="form-item">
        <input type="hidden" name="action" value="identity">
        <button class="btn" type="submit">{l s='Save' d='Shop.Theme.Amp'}</button>
      </div>

      <div submit-success>
        <div class="flex-container align-items-center vert-templ flex-column">
          <amp-bodymovin-animation layout="flex-item" width="40" height="40" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation>
          <div>{l s='Personal information is changed' d='Shop.Theme.Amp'}</div>
        </div>
      </div>

      <div submit-error>
        <div class="flex-container align-items-center flex-column p20">
          <div>{l s='Something goes wrong. Please try again' d='Shop.Theme.Amp'}</div>
        </div>
      </div>
    </form>
    
  {/block}

</section>
{/block}