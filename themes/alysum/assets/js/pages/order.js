function updateForClosing(element) {
    const parent = element.closest('amp-sidebar');
    parent.removeAttribute('open');
    parent.removeAttribute('i-amphtml-sidebar-opened');
    element.removeAttribute('open');
    element.removeAttribute('i-amphtml-sidebar-opened');
    document.documentElement.classList.remove('i-amphtml-scroll-disabled');
    document.documentElement.removeAttribute('style');
    $('.amp-sidebar-mask').attr('hidden', true);
    $('.amp-sidebar-mask').attr('open', false);
}

$(document).ready(function()
{
    if (prestashop.page.page_name === 'module-pkamp-order') {
        $('body').on('click', '.amp-close-image', (e) => {
            e.preventDefault();
            updateForClosing(e.target)
        });
        $('body').on('click', '[on="tap:selector-tos.close"]', (e) => {
            e.preventDefault();
            updateForClosing(e.target)
        });
    }
});