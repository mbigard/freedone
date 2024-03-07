{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<amp-state id="addToCart">
  <script type="application/json">
    {
      "productId": ""
    }
  </script>
</amp-state>

<amp-state id="productsList">
  <script type="application/json">
    {literal}{
      "hasMorePages": "{/literal}{if (isset($products.hasMorePages))}{$products.hasMorePages}{else}1{/if}{literal}",
      "static_token": "{/literal}{$static_token}{literal}",
      "items": {/literal}{if (isset($catProducts))}{$catProducts|@json_encode nofilter}{else}[]{/if}{literal}
    }{/literal}
  </script>
</amp-state>

<amp-state id="productState">
  <script type="application/json">
    {literal}{
      "nextPageUrl": "{/literal}{$amp.global.vars.nextPageToLoad}{literal}",
      "sortOrder": "position.asc",
      "hasMorePages": "1",
      "static_token": "{/literal}{$static_token}{literal}"
    }{/literal}
  </script>
</amp-state>