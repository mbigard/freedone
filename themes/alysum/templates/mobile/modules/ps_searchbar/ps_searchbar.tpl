{assign var="togglerId" value="selector-search"}

<amp-sidebar id="{$togglerId}" class="lang-select user-select relative" layout="nodisplay" side="right">

  {include file='mobile/_partials/button-close.tpl' togglerId=$togglerId togglerTitle={l s='Search' d='Shop.Theme.Amp'}}

  <div class="search-bar">

    <input name="searchstring" type="text" on="
      {literal}
      input-debounced: 
        AMP.setState({
         query: event.value,
         showDropdown: event.value
        }),
        autosuggest-list.show,
        search-page.show;
      Tap:
        AMP.setState({
          query: query == null ? '' : query,
          showDropdown: 'true',
        }),
        autosuggest-list.show,
        search-page.show;
      {/literal}"
      [value]="query || ''" value="" autocomplete="off" placeholder="{l s='Search' d='Shop.Theme.Amp'}" />

      <div class="suggest m15">

        <div id="search-loading" hidden>
          <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg>
        </div>

        <div class="autosuggest-container hidden" [class]="(showDropdown && query) ? 'autosuggest-container' : 'autosuggest-container hidden'">

          <amp-list binding="no" id="autosuggest-list" class="mini-products" layout="fixed-height" height="500" items="emptyAndInitialTemplateJson.results" [src]="query ? autosuggest.endpoint + query : autosuggest.emptyAndInitialTemplateJson">
            
            <template type="amp-mustache">
              <amp-selector id="autosuggest-selector" keyboard-select-mode="focus" layout="container">

               <div class="select-option no-outline flex-container product-list-item" role="option" tabindex="0" on="{literal}tap:AMP.navigateTo(url='{{link}}'){/literal}" option="{literal}{{name}}{/literal}">

                  <amp-img alt="{literal}{{name}}{/literal}" src="{literal}{{image}}{/literal}" width="{$amp.global.images.small.size.width}" height="{$amp.global.images.small.size.height}" layout="responsive"></amp-img>

                  <div class="product-info">
                    <div class="product-title">{literal}{{name}}{/literal}</div>
                    {literal}{{#show_price}}{/literal}
                    <span class="price">{literal}{{price}}{/literal}</span>
                    {literal}{{/show_price}}{/literal}
                  </div>

               </div>

              </amp-selector>
            </template>
            
            <div placeholder>
              <div class="flex-container align-items-center" [hidden]="showDropdown">
                <amp-bodymovin-animation layout="flex-item" width="100" height="100" src="{$amp.global.assets}json/infinite.json" loop="true"></amp-bodymovin-animation>
              </div>
            </div>

            <div [hidden]="emptyAndInitialTemplateJson.searchnumber > 0">{l s='No products found' d='Shop.Theme.Amp'}</div>
            <div [text]="emptyAndInitialTemplateJson.query">-</div>

          </amp-list>

        </div>
      </div>

      <a id="search-page" hidden class="button" role="button" href="{url entity='module' name={$amp.global.name} controller='search' relative_protocol=false params=['searchstr' => '']}" [href]="searchPage.searchPageURL + query">{l s='Search result page' d='Shop.Theme.Amp'}</a>

   </div>

  <amp-state id="autosuggest" [src]="'{url entity='module' name={$amp.global.name} controller='ajaxSearch' relative_protocol=false}'">
   <script type="application/json">
    {
     "endpoint": "",
     "emptyAndInitialTemplateJson": [{
        "query": "",
        "results": [],
        "searchnumber": "0"
      }]
    }
   </script>
  </amp-state>

  <amp-state id="searchPage">
   <script type="application/json">
    {
     "searchPageURL": "{url entity='module' name={$amp.global.name} controller='search' relative_protocol=false params=['searchstr' => '']}"
    }
   </script>
  </amp-state>

</amp-sidebar>