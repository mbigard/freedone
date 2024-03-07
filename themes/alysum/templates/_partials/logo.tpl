<div class="header_logo h-100 w-100">
  {if isset($page.page_name) && $page.page_name != 'product' && $page.page_name != 'category'}<div class="m-0 logo-link-wrap">{else}<div class="logo-link-wrap">{/if}
    <a class="header_logo_img dib" href="{$urls.base_url}" title="{$shop.name}">
        <img class="logo db" src="{$shop.logo}" alt="{$shop.name}" width="{Configuration::get('SHOP_LOGO_WIDTH')}" height="{Configuration::get('SHOP_LOGO_HEIGHT')}">
    </a>
  {if isset($page.page_name) && $page.page_name != 'product' && $page.page_name != 'category'}</div>{else}</div>{/if}
</div>