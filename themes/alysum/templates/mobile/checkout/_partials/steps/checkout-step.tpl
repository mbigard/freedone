{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='step'}
<section  id    = "{$identifier}"
          class = "{[
                      'checkout-step'   => true,
                      '-current'        => $step_is_current,
                      '-reachable'      => $step_is_reachable,
                      '-complete'       => $step_is_complete,
                      'js-current-step' => $step_is_current
                  ]|classnames}"
>
  <h4>
    <span class="step-number">{$position}.</span>{$title}
    <span class="step-edit text-muted hidden">{l s='Edit' d='Shop.Theme.Actions'}</span>
  </h4>

  <div class="content">
    {block name='step_content'}DUMMY STEP CONTENT{/block}
  </div>
</section>
{/block}
