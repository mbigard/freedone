{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{foreach from=$steps item="step" key="index"}
  {render identifier=$step.identifier position=($index+1) ui=$step.ui amp_po=$payment_options}
{/foreach}
