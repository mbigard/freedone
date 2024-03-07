{*
* 2011-2023 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2023 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='address_block_item'}
<article id="address-{$address.id}" class="address" data-id-address="{$address.id}">
    <div class="address-body m15">
    <h3>{$address.alias}</h3>
    <address>{$address.formatted nofilter}</address>
    </div>
    {block name='address_block_item_actions'}
    <div class="address-footer flex-container">
        <a href="{url entity='module' name={$amp.global.name} controller='address' relative_protocol=false params=['id_address' => $address.id]}" class="btn" data-link-action="edit-address">
        <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#pencil"></use></svg>{l s='Edit' d='Shop.Theme.Actions'}
        </a>&nbsp;
        <form method="POST" 
        action-xhr="{assign var='url' value={url entity='module' name={$amp.global.name} controller='ajaxAddress' relative_protocol=false params=['id_address' => $address.id]}}"
        target="_top">
        <input type="hidden" name="id_address" value="{$address.id}">
        <input type="hidden" name="delete" value="1">
        <input type="hidden" name="token" value="{$token}">
        <div class="flex-container align-items-center">
            <button type="submit" class="btn">
            <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg>{l s='Delete' d='Shop.Theme.Actions'}
            </button>
            <div submit-success class="p0 m0">&nbsp;{l s='Success' d='Shop.Theme.Amp'}</div>
            <div submit-error class="p0 m0">&nbsp;{l s='Unable to delete address' d='Shop.Theme.Amp'}</div>
            <div submitting class="p0 m0">&nbsp;{l s='Waiting' d='Shop.Theme.Amp'}...</div>
        </div>
        </form>
    </div>
    {/block}
</article>
<hr>
{/block}