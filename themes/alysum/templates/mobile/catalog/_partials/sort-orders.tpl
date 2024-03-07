{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<amp-accordion class="product-sorting m20" expand-single-section animate>
  <section>
    <h4>
      <div class="roboto flex-container align-items-center">
      <span class="flex-grow1 flex-container align-items-center filter-title">
        <amp-bodymovin-animation layout="flex-item" class="filter-title-icon" width="24" height="24" src="{$amp.global.assets}json/filter.json" loop="true"></amp-bodymovin-animation>
        <span class="flex-grow1">{l s='Product Filter' d='Shop.Theme.Amp'}</span>
      </span>
      <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
      </div>
    </h4>

    <form id="filter" method="GET" action="{$amp.global.urls.productListSource}" action-xhr="{$amp.global.urls.productListSource}" target="_top" on="{literal}submit-success: AMP.setState({
    productsList: {
      items: event.response.loadmore ? productsList.items.concat(event.response.items) : event.response.items
    },
    productState: {
      nextPageUrl: event.response.nextPageUrl,
      pageNumber: event.response.pageNumber,
      hasMorePages: event.response.hasMorePages,
      isFilter: true
    }});{/literal}">
      {if (isset($facets))}
      {foreach from=$facets item="facet" name=facet}
      {if $facet.displayed == 1 && $facet.type != 'price'}
        <amp-accordion class="facet" expand-single-section animate>
        <section{if ($smarty.foreach.facet.index == 0)} expanded{/if}>
        {assign var=_expand_id value=10|mt_rand:100000}
        <h5 class="facet-title">
          <div class="roboto flex-container align-items-center">
          <div class="flex-grow1">{$facet.label}</div>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
          </div>
        </h5>
        {if $facet.widgetType !== 'dropdown'}
          <ul id="facet_{$_expand_id}">
            {foreach from=$facet.filters item="filter"}
              {if $filter.displayed == 1}
              {assign var=filter_id value=10|mt_rand:100000}
                <li{if isset($filter.properties.color) || isset($filter.properties.texture)} class="color-label"{/if}>
                  <label class="facet-label flex-container align-items-center{if $filter.active == 1} active{/if}" for="filter_{$filter_id}">
                    {assign var=att_name value="attr[{$facet.label}][]"}
                    {assign var=att_value value=$filter.label}
                    {if $facet.multipleSelectionAllowed}
                      <input type="checkbox" class="pk-check" id="filter_{$filter_id}" name="{$att_name}" value="{$att_value}" {if $filter.active == 1} checked{/if}>
                      <div class="flex-label-wrap flex-container">
                        {if isset($filter.properties.color)}
                          <span class="color" style="background-color:{$filter.properties.color}">y</span>
                        {elseif isset($filter.properties.texture)}
                          <span class="color texture" style="background-image:url({$filter.properties.texture})">x</span>
                        {else}
                          <span></span>
                        {/if}
                        <svg width="18px" height="18px" viewBox="0 0 18 18">
                          <path d="M1,9 L1,3.5 C1,2 2,1 3.5,1 L14.5,1 C16,1 17,2 17,3.5 L17,14.5 C17,16 16,17 14.5,17 L3.5,17 C2,17 1,16 1,14.5 L1,9 Z"></path>
                          <polyline points="1 9 7 14 15 4"></polyline>
                        </svg>
                      </div>
                    {else}
                      <input type="radio" id="filter_{$filter_id}" name="{$att_name}" value="{$att_value}" {if $filter.active == 1} checked{/if}>
                    {/if}
                    <span class="flex-grow1 search-link js-search-link" rel="nofollow">
                      {$filter.label}
                      {if $filter.magnitude}
                        <span class="magnitude" hidden>({$filter.magnitude})</span>
                      {/if}
                    </span>
                    {if $facet.multipleSelectionAllowed}
                      {if isset($filter.properties.color)}
                        <span class="color-tooltip" style="background-color:{$filter.properties.color}"></span>
                      {elseif isset($filter.properties.texture)}
                        <span class="color-tooltip" style="background-image:url({$filter.properties.texture})"></span>
                      {/if}
                    {/if}
                  </label>
                </li>
              {/if}
            {/foreach}
          </ul>
        {else}
          <p id="facet_{$_expand_id}">
            {assign var=att_selected value=0}
            {foreach from=$facet.filters item="filter" name="filter"}
              {if $filter.active == 1}
              {assign var=att_selected value=$smarty.foreach.filter.index+1}
              {/if}
            {/foreach}
            <select class="w100" name="attr[{$facet.label}][]">
              <option disabled{if $att_selected == 0} selected{/if} value="">-- {l s='No Selection' d='Shop.Theme.Amp'} --</option>
              {foreach from=$facet.filters key=att_id item="filter" name="filter"}
                <option value="{$filter.label}"{if $smarty.foreach.filter.index+1 == $att_selected} selected{/if}>
                  {$filter.label}
                </option>
              {/foreach}
            </select>
          </p>
        {/if}
        </section>
        </amp-accordion>
      {/if}
      {/foreach}
      {/if}

      <!-- SORTING -->
      <div class="ampstart-input m15 flex-container">
        <label class="flex-grow1">{l s='Sort By' d='Shop.Theme.Amp'}:</label>
        <select name="sortOrder">
          <option value="position.asc"{if $sortOrder.comp == 'position.asc'} selected{/if}>
            {l s='Relevance' d='Shop.Theme.Amp'}
          </option>
          <option value="name.asc"{if $sortOrder.comp == 'name.asc'} selected{/if}>
            {l s='Name, A to Z' d='Shop.Theme.Amp'}
          </option>
          <option value="name.desc"{if $sortOrder.comp == 'name.desc'} selected{/if}>
            {l s='Name, Z to A' d='Shop.Theme.Amp'}
          </option>
          <option value="price.asc"{if $sortOrder.comp == 'price.asc'} selected{/if}>
            {l s='Price, low to high' d='Shop.Theme.Amp'}
          </option>
          <option value="price.desc"{if $sortOrder.comp == 'price.desc'} selected{/if}>
            {l s='Price, high to low' d='Shop.Theme.Amp'}
          </option>
          <option value="date_add.asc"{if $sortOrder.comp == 'date_add.asc'} selected{/if}>
            {l s='Add date, old to new' d='Shop.Theme.Amp'}
          </option>
          <option value="date_add.desc"{if $sortOrder.comp == 'date_add.desc'} selected{/if}>
            {l s='Add date, new to old' d='Shop.Theme.Amp'}
          </option> 
        </select>
      </div>
      <!-- /SORTING -->

      <!-- PRODUCTS PER PAGE -->
      <input type="hidden" name="productsPerPage" value="{if (isset($amp.config.category.product.number))}{$amp.config.category.product.number}{else}12{/if}">
      <input type="hidden" name="pageNumber" value="1" [value]="productState.pageNumber">
      <!-- /PRODUCTS PER PAGE -->

      <div class="form-footer flex-container align-items-center">
        <input type="submit" name="apply" value="{l s='Apply' d='Shop.Theme.Amp'}" class="ampstart-btn big-btn caps m1 show">

        <div submit-success>
          <div class="flex-container align-items-center">
            <amp-bodymovin-animation layout="flex-item" width="34" height="34" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation>
            <div>{l s='Done' d='Shop.Theme.Amp'}</div>
          </div>
        </div>
        <div submit-error>&nbsp;{l s='Unable to Sort Products' d='Shop.Theme.Amp'}</div>
        <div submitting>&nbsp;{l s='Waiting' d='Shop.Theme.Amp'}...</div>
      </div>

      <button class="load-more-button lmore lmore-show" hidden>
        <label for="run-loadmore">
        <input type="checkbox" role="button" tabindex="0" name="loadmore" id="run-loadmore" hidden value="{l s='Load More' d='Shop.Theme.Amp'}" class="ampstart-btn big-btn caps m1 show" on="tap:filter.submit">
        {l s='Show More Products' d='Shop.Theme.Amp'}
        </label>
      </button>

    </form>
  </section>
</amp-accordion>