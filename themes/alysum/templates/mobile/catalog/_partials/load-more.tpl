{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<!-- LOAD MORE -->
<amp-list-load-more class="lmore lmore-show" load-more-button>
  <button class="inv-btn w100 ampstart-btn caps m1 show">
  {l s='Show More Products' d='Shop.Theme.Amp'}
  </button>
</amp-list-load-more>
<amp-list-load-more class="lmore lmore-waiting" load-more-loading>
  <div class="width text-center">{l s='Waiting' d='Shop.Theme.Amp'}...</div>
</amp-list-load-more>
<amp-list-load-more class="lmore lmore-error" load-more-failed>
  <button class="inv-btn w100 ampstart-btn caps m1 show">
    {l s='Unable to Load More Products' d='Shop.Theme.Amp'}
  </button>
</amp-list-load-more>
<amp-list-load-more class="lmore lmore-nomore" load-more-end>
  <button class="inv-btn w100 ampstart-btn caps m1 show">
  {l s='No more products' d='Shop.Theme.Amp'}
  </button>
</amp-list-load-more>
<!-- /LOAD MORE -->