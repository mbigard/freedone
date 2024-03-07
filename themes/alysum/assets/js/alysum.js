const pkBreakpoints = pktheme.breakpoints;
const isTouchDevice = 'ontouchstart' in document.documentElement;
const selectors = {
    glideSlider: '.glide',
    glideSlides: '.glide__slides',
    ddContainer: '.dd_container',
    buttonQuickView: '.quick-view',
    buttonAddToCart: '.product-miniature .add-to-cart',
};
const classes = {
    inProgress: 'in_progress',
    ddHover: 'dd_el_hover',
    modalOpen: 'modal-open',
};
// add selectors to global object
prestashop.themeSelectors.alysum = {
    selectors,
    classes,
};

document.addEventListener('DOMContentLoaded', () => {
    // trigger when DOM is loaded
    addBodyClasses();
    configureJGrowl();
    updateCurrentYear();
    addPrestashopEvents();
    findAndInitCarousels();
    addModalWindowListener();
    addCategoryTreeListeners();
    addToCartButtonListeners();
    addTriggerButtonListener();
    addImagesLoadEventListener();
    addProductMiniatureListeners();
    isTouchDevice ? addTapListener() : addHoverListener();
});

// mark every loaded image with 'loaded' class
const addImagesLoadEventListener = () => {
    const loadedClass = 'loaded';
    document.querySelectorAll('img').forEach((item) => {
        item.addEventListener('load', () => item.classList.add(loadedClass));
    });
};

/*
 * 1. add a button with data attr "trigger-name"
 * 2. add trigget target element with data attr "trigger-target" with the same value as button has
 */
const addTriggerButtonListener = () => {
    const triggerClass = 'hidden';
    const triggerTarget = 'data-trigger-target';
    const triggerName = '[data-trigger-name]';
    const triggersCollection = document.querySelectorAll(triggerName);

    if (!triggersCollection) return;

    const animateSection = (section) => {
        const duration = 500;
        const easing = 'ease-out';
        const isHidden = section.classList.contains(triggerClass);
        isHidden && section.classList.toggle(triggerClass);
        section.classList.add('oh');
        section.animate(
            [
                {
                    height: isHidden ? '0px' : `${section.offsetHeight}px`,
                    easing,
                },
                {
                    height: isHidden ? `${section.offsetHeight}px` : '0px',
                    easing,
                },
            ],
            { duration }
        );
        setTimeout(() => {
            isHidden || section.classList.toggle(triggerClass);
            section.classList.remove('oh');
        }, duration);
    };

    triggersCollection.forEach((item) => {
        item.addEventListener('click', ({ target }) => {
            const triggerName = target.dataset.triggerName;
            const triggerTargetEl = document.querySelector(`[${triggerTarget}="${triggerName}"]`);
            triggerTargetEl && animateSection(triggerTargetEl);
        });
    });
};

// find all carousels in a page and init them
const findAndInitCarousels = (slider = null) => {
    const glides = slider ? slider : document.querySelectorAll('.glide');

    const defaultGlideConfig = {
        type: 'carousel',
        startAt: 0,
        perView: 4,
        gap: 30,
    };

    const getVal = (item, attr, val) => parseInt(item.dataset[attr]) || val;

    glides.forEach((item) => {
        let glide;
        const parsedConfig = {
            navPosition: getVal(item, 'navwrap', 0),
            alignArrows: getVal(item, 'align-arrows', 0),
            perView: getVal(item, 'desktopnum', 4),
            phone: getVal(item, 'phonenum', 1),
            tablet: getVal(item, 'tabletnum', 2),
            desktop: getVal(item, 'desktopnum', 4),
        };

        function initGlide() {
            const currentItemConfig = {
                perView: parsedConfig.perView,
                breakpoints: {
                    [pkBreakpoints.phone]: {
                        perView: parsedConfig.phone,
                    },
                    [pkBreakpoints.tablet]: {
                        perView: parsedConfig.tablet,
                    },
                    [pkBreakpoints.desktop]: {
                        perView: parsedConfig.desktop,
                    },
                },
            };

            const configuration = {
                ...defaultGlideConfig,
                ...currentItemConfig,
            };

            glide = new Glide(item, configuration);

            glide.on('mount.before', () => {
                addGlideArrows();
                parsedConfig.alignArrows && shiftArrows();
            });

            glide.mount();
        }

        function addGlideArrows() {
            const getArrow = (role) => {
                const icon = `${prestashop.urls.img_url}lib.svg#${role}-arrow-thin`;
                const arrow = role === 'left' ? '<' : '>';
                const label = role === 'left' ? 'Previous' : 'Next';
                return `<button class="glide__arrow glide__arrow--${role}" data-glide-dir="${arrow}" aria-label="${label}"><svg class="svgic"><use href="${icon}"></use></svg></button>`;
            };

            const arrowLeft = getArrow('left');
            const arrowRight = getArrow('right');
            const position = parsedConfig.navPosition === 0 ? 'center-center' : 'top-left';
            const wrapper = `<div class="glide__arrows ${position}" data-glide-el="controls"></div>`;

            $(item).append($(wrapper));
            $(item).find('.glide__arrows').html('');
            $(item).find('.glide__arrows').append($(arrowLeft));
            $(item).find('.glide__arrows').append($(arrowRight));
        }

        function shiftArrows() {
            let topShift = 0;
            const firstCarouselItem = $(item).find(prestashop.selectors.product.miniature)[0];

            if (firstCarouselItem) {
                const imgMargin = parseInt(
                    $(firstCarouselItem).find('.product-thumbnail').css('margin-bottom')
                );
                const infoSectionHeight = parseInt($(firstCarouselItem).find('.product-desc-wrap').height());
                topShift = (infoSectionHeight + imgMargin) / 2;
            }

            let arrows = $(item).find('.glide__arrow');

            $(arrows[0]).css('top', `calc(50% - ${topShift}px)`);
            $(arrows[1]).css('top', `calc(50% - ${topShift}px)`);
        }

        if (isCarousel(item)) {
            initGlide();
        }
    });
};

const configureJGrowl = () => {
    if (typeof $.jGrowl !== 'function') {
        return;
    }
    // default config for jGrowl Popup Messages script
    $.jGrowl.defaults.pool = 5;
    $.jGrowl.defaults.life = 4000;
    $.jGrowl.defaults.closer = false;
    $.jGrowl.defaults.theme = 'jGrowl-promokit';
    $.jGrowl.defaults.animateClose = { height: 'hide' };
};

const addBodyClasses = () => {
    document.body.classList.add(isTouchDevice ? 'touch' : 'no-touch');
};

const addTapListener = () => {
    const dropDownRoot = '.dd_el .pk-item-content';

    $(document).on('click', dropDownRoot, function (event) {
        const {
            currentTarget: { href, tagName, parentElement },
        } = event;

        const isRedirect = () => {
            return tagName === 'A' && !['', '#'].includes(href) && !parentElement.dataset.pktype;
        };

        // if clicked element is A and it has a link then go to link
        isRedirect() && (location.href = href);

        if (parentElement.querySelector(selectors.ddContainer)?.length === 0) {
            return;
        }

        event.preventDefault();

        const isHover = parentElement.classList.contains(classes.ddHover);
        const childContainer = $(this).parent().children(selectors.ddContainer);

        $(dropDownRoot).not(this).parent().removeClass(classes.ddHover);

        isHover
            ? childContainer.stop().slideUp(200, 'easeOutExpo')
            : childContainer.stop().slideDown(200, 'easeOutExpo');

        parentElement.classList.toggle(classes.ddHover);
    });
};

const addHoverListener = () => {
    const dropDownRoot = '.dd_el';
    $(document).on('mouseenter', dropDownRoot, function () {
        $(selectors.ddContainer).stop().slideUp(0, 'easeOutExpo');
        $(this)
            .children(selectors.ddContainer)
            .stop()
            .slideDown(500, 'easeOutExpo')
            .addClass(classes.ddHover);
    });

    $(document).on('mouseleave', dropDownRoot, function () {
        $(this)
            .children(selectors.ddContainer)
            .removeClass(classes.ddHover)
            .delay('400')
            .stop()
            .slideUp(200, 'easeOutExpo');
    });

    $(document).on('mouseleave', selectors.ddContainer, function () {
        $(this).removeClass(classes.ddHover).delay('400').stop().slideUp(200, 'easeOutExpo');
    });
};

const addCategoryTreeListeners = () => {
    $(document).on('click', '.header-bottom .ps_categorytree .module-title', function () {
        $(this).next('.module-body').slideToggle();
    });

    $(document).on('click', '.catmenu-trigger', function (e) {
        e.preventDefault();
        $(this).parent().toggleClass('catmenu-open');
        $(this).toggleClass('ps-cat-act');
        $(this).parent().next('div').slideToggle();
        return false;
    });
};

const isCarousel = (block) => {
    const { dataset } = block;
    if (!dataset || !block.querySelector(selectors.glideSlides)) {
        return false;
    }

    const isDebug = false;
    const windWidth = window.innerWidth;
    const itemsNum = block.querySelector(selectors.glideSlides).children.length;

    const phone = parseInt(dataset.phonenum);
    const tablet = parseInt(dataset.tabletnum);
    const desktop = parseInt(dataset.desktopnum);

    const log = (str) => {
        isDebug && console.log(windWidth + '|items num:' + itemsNum + '|' + str);
    };

    isDebug && console.log(block);

    if (windWidth <= pkBreakpoints.mobile) {
        log('phone num:' + phone);
        return itemsNum > phone;
    }

    if (windWidth <= pkBreakpoints.tablet && windWidth > pkBreakpoints.mobile) {
        log('tablet num:' + tablet);
        return itemsNum > tablet;
    }

    log('desktop num:' + desktop);
    return itemsNum > desktop;
};

const isEmail = (email) => {
    const regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(email);
};

const updateCurrentYear = () => {
    // update footer year. Works for any element with .current_year class
    document.querySelectorAll('.current_year').forEach((item) => {
        item.innerHTML = new Date().getFullYear();
    });
};

const addProductMiniatureListeners = () => {
    const hoverClass = 'pmhovered';
    const activeSwitcher = 'active-switcher';
    const switcher = '.pmimage-switcher';
    const switchers = [...document.querySelectorAll(switcher)];

    switchers.forEach((switcher) => {
        const items = [...switcher.querySelectorAll('span')];
        items.forEach((item) => {
            const rootA = item.closest('a');
            const index = items.indexOf(item);
            const imgs = rootA.querySelectorAll('img');

            item.addEventListener('mouseenter', () => {
                rootA.classList.add(activeSwitcher);
                imgs[index].classList.add(hoverClass);
            });

            item.addEventListener('mouseleave', () => {
                rootA.classList.remove(activeSwitcher);
                imgs[index].classList.remove(hoverClass);
            });
        });
    });
};

const addToCartButtonListeners = () => {
    document.querySelectorAll(selectors.buttonAddToCart).forEach((item) => {
        item.addEventListener('click', ({ target }) => target.classList.add(classes.inProgress));
    });
};

const removeAllButtonLoaders = () => {
    document.querySelectorAll(selectors.buttonAddToCart).forEach((item) => {
        item.classList.remove(classes.inProgress);
    });
    document.querySelectorAll(selectors.buttonQuickView).forEach((item) => {
        item.classList.remove(classes.inProgress);
    });
};

const addModalWindowListener = () => {
    const observer = new MutationObserver((mutations) => {
        mutations.forEach(() => {
            if (document.body.classList.contains(classes.modalOpen)) {
                prestashop.emit('modalIsOpen', {});
            }
        });
    });
    observer.observe(document.body, { attributes: true });
};

const addPrestashopEvents = () => {
    prestashop.on('modalIsOpen', () => {
        removeAllButtonLoaders();
    });

    prestashop.on('clickQuickView', (e) => {
        // add loader for a clicked button
        const productRoot = document.querySelector(
            `${prestashop.selectors.product.miniature}[data-id-product="${e.dataset.idProduct}"]`
        );
        productRoot.querySelector(selectors.buttonQuickView).classList.add(classes.inProgress);
    });

    prestashop.on('updatedProduct', () => {
        const slider = document.querySelector('.pp-img-carousel');
        slider && findAndInitCarousels([slider]);
    });

    prestashop.on('updateProductList', () => {
        setTimeout(() => addProductMiniatureListeners(), 0);
    });
};
