{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='order_messages_table'}
{if $order.messages}
<div class="box messages">
  <h3 class="m10">{l s='Messages' d='Shop.Theme.Customeraccount'}</h3>
  {foreach from=$order.messages item=message}
    <div class="flex-container">
      <div class="flex-grow1">{$message.name}</div>
      <div>{$message.message_date}</div>
    </div>
    <div class="message-text m15">
      <i>{$message.message nofilter}</i>
    </div>
  {/foreach}
</div>
{/if}
{/block}

{block name='order_message_form'}
<section class="order-message-form box">
  <form action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxOrder' relative_protocol=false params=['who' => 'order-messages']}" method="post" target="_top">

    <header>
      <h3>{l s='Add a message' d='Shop.Theme.Customeraccount'}</h3>
      <p>{l s='If you would like to add a comment about your order, please write it in the field below.' d='Shop.Theme.Customeraccount'}</p>
    </header>

    <section class="form-fields">

      <select name="id_product" class="form-control form-control-select m15">
        <option value="0">{l s='-- please choose a product --' d='Shop.Forms.Labels'}</option>
        {foreach from=$order.products item=product}
          <option value="{$product.id_product}">{$product.name}</option>
        {/foreach}
      </select>

      <textarea rows="3" name="msgText" class="form-control"></textarea>

    </section>

    <footer class="form-footer flex-container align-items-center">
      <input type="hidden" name="id_order" value="{$order.details.id}">
      <input type="hidden" name="submitMessage" value="1">
      <button type="submit">
        {l s='Send' d='Shop.Theme.Actions'}
      </button>
      <div submit-error>
        {l s='Unable to send a message' d='Shop.Theme.Amp'}
      </div>
    </footer>

    <div submit-success>
      <div class="flex-container align-items-center flex-column">
        <amp-bodymovin-animation layout="flex-item" width="40" height="40" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation>
        <div>{l s='Your message has been sent to our staff' d='Shop.Theme.Amp'}</div>
      </div>
    </div>

  </form>
</section>
{/block}