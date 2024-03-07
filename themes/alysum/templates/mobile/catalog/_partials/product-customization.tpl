{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<section class="product-customization">
  {if !$configuration.is_catalog}
    <div class="card card-block m10">
      <h3 class="h4 card-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h3>
      {l s='Don\'t forget to save your customization to be able to add to cart' d='Shop.Forms.Help'}
    </div>
    {block name='product_customization_form'}
      <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false params=['who' => 'product-customization']}" target="_top">
        <ul>
          {foreach from=$customizations.fields item="field"}
            <li class="product-customization-item flex-container flex-column m15">
              <label> {$field.label}</label>
              {if $field.type == 'text'}
                <textarea placeholder="{l s='Your message here' d='Shop.Forms.Help'}" class="product-message w100" maxlength="250" {if $field.required} required {/if} name="{$field.input_name}"></textarea>
                <small>{l s='250 char. max' d='Shop.Forms.Help'}</small>
                {if $field.text !== ''}
                <h6 class="customization-message">
                  {l s='Your customization:' d='Shop.Theme.Catalog'}
                  <label>{$field.text}</label>
                </h6>
                {/if}
              {elseif $field.type == 'image'}
                {if $field.is_customized}
                  <br>
                  <img src="{$field.image.small.url}">
                  <a class="remove-image" href="{$field.remove_image_url}" rel="nofollow">{l s='Remove Image' d='Shop.Theme.Actions'}</a>
                {/if}
                <span class="custom-file relative db">
                  <span class="js-file-name">{l s='No selected file' d='Shop.Forms.Help'}</span>
                  <input class="file-input js-file-input" {if $field.required} required {/if} type="file" name="{$field.input_name}">
                  <button class="btn btn-primary">{l s='Choose file' d='Shop.Theme.Actions'}</button>
                </span>
                <small>.png .jpg .gif</small>
              {/if}
            </li>
          {/foreach}
        </ul>
        <div class="m40">
          <input type="hidden" name="submitCustomizedData" value="1">
          <input type="hidden" name="current_url" value="{$urls.current_url}">
          <input type="hidden" name="id_product" value="{$product.id}">
          <input class="btn btn-primary pull-xs-right" type="submit" value="{l s='Save Customization' d='Shop.Theme.Actions'}">
        </div>
      </form>
    {/block}
  {/if}
</section>