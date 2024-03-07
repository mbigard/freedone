$(document).ready(function(){
  const products = document.getElementById('products');
  const isMasonry = document.body.classList.contains('category-page-type-masonry');

  const initMasonry = () => {

    const viewBtn = document.querySelector('.view_btn.active');

    if (!products.classList.contains('view_grid') || !viewBtn) {
      return console.error('Unable to calculate isotope parameters');
    }

    const masonryParams = {
      root: '.product-list-container',
      items: '.product-miniature',
      defaultGridCols: 5,
      itemsGap: Number(pktheme.cp_item_gap['grid-column-gap']) || 40,
    }

    const calculateItemWidth = (btn) => {
      const cols = (btn.dataset.gridcols > 1) ? btn.dataset.gridcols : masonryParams.defaultGridCols;
      const containerWidth = document.querySelector(masonryParams.root).getBoundingClientRect().width;
      return (containerWidth - (masonryParams.itemsGap * (cols - 1))) / cols;
    }

    masonryParams.itemsWidth = calculateItemWidth(viewBtn);

    const updateItemsParams = () => {
      const items = document.querySelectorAll(masonryParams.items);

      items.forEach((item) => {
        item.style.marginBottom = `${masonryParams.itemsGap}px`;
        let width = `${masonryParams.itemsWidth}px`;

        item.classList.contains('miniature-size-x-2x') && (width = `${masonryParams.itemsWidth * 2 + masonryParams.itemsGap}px`);
        item.classList.contains('miniature-size-x-3x') && (width = `${masonryParams.itemsWidth * 3 + masonryParams.itemsGap * 2}px`);

        item.style.width = width;
      });
    }

    const masonryConfig = {
      itemSelector: masonryParams.items,
      percentPosition: true,
      columnWidth: masonryParams.itemsWidth,
      gutter: masonryParams.itemsGap,
      transitionDuration: '0.2s',
      stagger: 0
    };

    updateItemsParams();

    let $grid = $(masonryParams.root);

    $grid.imagesLoaded(() => {
      $grid.masonry(masonryConfig);
    });

    document.body.classList.add('masonry-active');

    addMasonryEventListeners();
  }

  const addMasonryEventListeners = () => {
      const viewButton = document.querySelectorAll('.view_btn');
      viewButton.forEach((btn) => btn.addEventListener('click', () => {setTimeout(initMasonry, 0)}));
  }

  const addSidebarTogglerListener = () => {
    const togglerButton = document.querySelector('.sidebar-toggler');
    if (!togglerButton) return;
    togglerButton.addEventListener('click', (e) => {
      e.target.parentElement.classList.toggle('sidebar-open')
    });
  }

  // ACTIVATE NECESSARY FUNCTIONS

  // activate masonry view if initiator class is exist
  isMasonry && initMasonry();

  addSidebarTogglerListener();

  // add listener for updateProductList event
  prestashop.on('updateProductList', () => {
    setTimeout(() => {
      isMasonry && initMasonry();

      addTriggerButtonListener();

      const {top} = products.getBoundingClientRect();
      $('html, body').animate({scrollTop: top || 500}, 500);

    }, 0);
  });

});