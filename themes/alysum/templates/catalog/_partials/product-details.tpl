{if (!isset($builder) && (isset($pktheme.pp_details_tab) && ($pktheme.pp_details_tab == 1))) || isset($builder)}
    {if !isset($builder)}
    <div class="js-product-details tab-pane fade{if !$product.description} in active{/if}"
      id="product-details"
      data-product="{$product.embedded_attributes|json_encode}"
      role="tabpanel"
    >
    {/if}
        {if isset($product_manufacturer->id)}
          <div class="product-manufacturer hidden">
            {if isset($manufacturer_image_url)}
              <a href="{$product_brand_url}">
                <img src="{$manufacturer_image_url}" class="img img-thumbnail manufacturer-logo" alt="manufacturer-logo" loading="lazy" />
              </a>
            {else}
              <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
              <span>
                <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
              </span>
            {/if}
          </div>
        {/if}
    
        <section class="product-features">
          <h3 class="h6">{l s='Product Details' d='Shop.Theme.Catalog'}</h3>
          <div class="data-sheet">
            {if isset($product_manufacturer->id)}
              <div class="product-manufacturer">
                {if isset($manufacturer_image_url)}
                  <a href="{$product_brand_url}">
                    <img src="{$manufacturer_image_url}" class="img img-thumbnail manufacturer-logo" alt="{$product_manufacturer->name}">
                  </a>
                {else}
                  <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
                  <span>
                    <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
                  </span>
                {/if}
              </div>
            {/if}
            {* {block name='product_reference'}
            {if isset($product.reference_to_display)}
              <div class="product-reference">
                <label class="label">{l s='Reference' d='Shop.Theme.Catalog'} </label>
                <span>{$product.reference_to_display}</span>
              </div>
            {/if}
            {/block} *}
            {block name='product_quantities'}
              {if $product.show_quantities}
                <div class="product-quantities">
                  <label class="label">{l s='In stock' d='Shop.Theme.Catalog'}</label>
                  <span data-stock="{$product.quantity}" data-allow-oosp="{$product.allow_oosp}">{$product.quantity} {$product.quantity_label}</span>
                </div>
              {/if}
            {/block}
            {block name='product_availability_date'}
              {if $product.availability_date}
                <div class="product-availability-date">
                  <label>{l s='Availability date:' d='Shop.Theme.Catalog'} </label>
                  <span>{$product.availability_date}</span>
                </div>
              {/if}
            {/block}
            {block name='product_out_of_stock'}
              <div class="product-out-of-stock">
                {hook h='actionProductOutOfStock' product=$product}
              </div>
            {/block}
          </div>
        </section>
    
        {block name='product_features'}
        {if $product.grouped_features}
          <section class="product-features">
            <h3 class="h6">{l s='Data sheet' d='Shop.Theme.Catalog'}</h3>
            <dl class="data-sheet">
              {foreach from=$product.grouped_features item=feature}
                <dt class="name feat{$feature.id_feature}">{$feature.name}</dt>
                <dd class="value feat{$feature.id_feature}">{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
              {/foreach}
            </dl>
          </section>
        {/if}
        {/block}
    
        {* if product have specific references, a table will be added to product details section *}
        {block name='product_specific_references'}
          {if (!empty($product.specific_references))}
            <section class="product-features">
              <h3 class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</h3>
                <dl class="data-sheet">
                  {foreach from=$product.specific_references item=reference key=key}
                    <dt class="name">{$key}</dt>
                    <dd class="value">{$reference}</dd>
                  {/foreach}
                </dl>
            </section>
          {/if}
        {/block}
    
        {block name='product_condition'}
          {if (!empty($product.condition))}
            <div class="product-condition">
              <label class="label">{l s='Condition' d='Shop.Theme.Catalog'} </label>
              <link href="{$product.condition.schema_url}"/>
              <span>{$product.condition.label}</span>
            </div>
          {/if}
        {/block}
        
      {if !isset($builder)}
      </div>
      {/if}
    {/if}