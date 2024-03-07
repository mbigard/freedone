/**
 * Copyright ETS Software Technology Co., Ltd
 *
 * NOTICE OF LICENSE
 *
 * This file is not open source! Each license that you purchased is only available for 1 website only.
 * If you want to use this file on more websites (or projects), you need to purchase additional licenses.
 * You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future.
 *
 * @author ETS Software Technology Co., Ltd
 * @copyright  ETS Software Technology Co., Ltd
 * @license    Valid for 1 website (or project) for each purchase of license
 */
$(document).on('click','.btn-send-mail',function(e){
    e.preventDefault();
    if(!$(this).hasClass('loading'))
    {
        $(this).addClass('loading');
        var $this = $(this);
        $.ajax({
            type: 'POST',
            headers: { "cache-control": "no-cache" },
            url: $this.attr('href'),
            data:'ajax=1',
            async: true,
            cache: false,
            dataType : "json",
            success: function(json)
            {
                if(json.success)
                {
                    showSuccessMessage(json.success);
                    $this.parents('tr').remove();
                }
                if(json.errors)
                {
                    showErrorMessage(json.errors)
                }
                $this.removeClass('loading');
            }
        });
    }
});
$(document).on('click','#list-mail_log .link_view',function(){
    if(!$(this).hasClass('loading'))
    {
        $(this).addClass('loading') ;
        var $button = $(this);
        url_ajax = $(this).attr('href');
        $.ajax({
            url: url_ajax,
            data: 'ajax=1',
            type: 'post',
            dataType: 'json',
            success: function(json){
                $button.removeClass('loading');
                if(json.mail_content)
                {
                    if($('.ets_mp_mail_popup').length>0)
                        $('.ets_mp_mail_popup').remove();
                    if($('.ets_mp_mail_popup').length==0)
                    {
                        var html ='<div class="ets_mp_mail_popup show">';
                        html +='<div class="popup_content table">';
                        html +='<div class="popup_content_tablecell">';
                        html +='<div class="popup_content_wrap" style="position: relative">';
                        html +=' <span class="close_popup">+</span>';
                        html +='<div id="block-form-popup-dublicate">';
                        html +='<div id="quick-view-mail" class="quick-view-mail">';
                        html +='<div class="header_poup">';
                        html += json.title;
                        html +='</div>';
                        html +='<div class="content_poup">';
                        html +='<div class="row form-group subject-mail">';
                        html += json.subject;
                        html +='<div>';
                        html +='</div>';
                        html +='</div>';
                        html +='</div>';
                        html +='</div>';
                        html +='</div>';
                        html +='</div>';
                        html +='</div>';
                        $('body').append(html);
                    }
                    else
                        $('.ets_mp_mail_popup').addClass('show');
                    createIframe = $('<iframe id="preview_template_html_mail"></iframe>');
                    $('body .ets_mp_mail_popup .popup_content_wrap .content_poup').append(createIframe);
                    var contentIFrame = createIframe[0].contentDocument || createIframe[0].contentWindow.document;
                    contentIFrame.write(json.mail_content);
                    contentIFrame.close();
                }
            },
            error: function(xhr, status, error)
            {
                $button.removeClass('loading');
                var err = eval("(" + xhr.responseText + ")");
                alert(err.Message);
            }
        });
    }
    return false;
});
$(document).on('click','.close_popup',function(){
    $('.ets_mp_mail_popup').removeClass('show');
});