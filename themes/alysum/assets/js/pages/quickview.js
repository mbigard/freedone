(function () {
    const injectCSS = () => {
        const files = ['product', 'quickview'];
        files.forEach((file) => {
            const linkId = `qw-${file}`;
            if (document.getElementById(linkId)) {
                return;
            }
            const fileref = document.createElement('link');
            fileref.id = linkId;
            fileref.rel = 'stylesheet';
            fileref.type = 'text/css';
            fileref.href = `${prestashop.urls.css_url}pages/${file}.css`;
            document.getElementsByTagName('head')[0].appendChild(fileref);
        });
    };
    injectCSS();
})();
