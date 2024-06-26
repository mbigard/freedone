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
var fees_is_hide = false;
function checkAll(pForm)
{
  for (i = 0, n = pForm.elements.length; i < n; i++)
  {
    var objName = pForm.elements[i].name;
    var objType = pForm.elements[i].type;
    if (objType == 'checkbox' && objName != 'checkme')
    {
      box = eval(pForm.elements[i]);
      box.checked = !box.checked;
    }
  }
}

function checkDelBoxes(pForm, boxName, parent)
{
  for (i = 0; i < pForm.elements.length; i++)
    if (pForm.elements[i].name == boxName)
      pForm.elements[i].checked = parent;
  $(window).resize();    
}
$(document).on('click','input[type="radio"]',function(){
   input_name = $(this).attr('name');
   $('input[name="'+input_name+'"]').parent().parent().removeClass('checked');
   $(this).parent().parent().addClass('checked'); 
});
$(document).ready(function() {
	carriersRangeInputs.watchCarriersRangeInputChange();
	bind_inputs();
	initCarrierWizard();
	checked_radio();
	if (parseInt($('input[name="is_free"]:checked').val()))
		is_freeClick($('input[name="is_free"]:checked'));
	displayRangeType();

	$('#attachement_fileselectbutton').click(function(e) {
		$('#carrier_logo_input').trigger('click');
	});

	$('#attachement_filename').click(function(e) {
		$('#carrier_logo_input').trigger('click');
	});

	$('#carrier_logo_input').change(function(e) {
		var name  = '';
		if ($(this)[0].files !== undefined)
		{
			var files = $(this)[0].files;

			$.each(files, function(index, value) {
				name += value.name+', ';
			});

			$('#attachement_filename').val(name.slice(0, -2));
		}
		else // Internet Explorer 9 Compatibility
		{
			name = $(this).val().split(/[\\/]/);
			$('#attachement_filename').val(name[name.length-1]);
		}
	});

	$('#carrier_logo_remove').click(function(e) {
		$('#attachement_filename').val('');
	});

	if ($('#is_free_on').prop('checked') === true)
	{
		$('#shipping_handling_off').prop('checked', true).prop('disabled', true).parents('.radio').addClass('disabled');
		$('#shipping_handling_on').prop('disabled', true).prop('checked', false).parents('.radio').addClass('disabled');
	}


	$(document).on('click','#is_free_on',function(){
		$('#is_free_off').prop('checked', false).parent().removeClass('checked');
		$('#shipping_handling_off').prop('checked', true).prop('disabled', true).parents('.radio').addClass('disabled');
		$('#shipping_handling_on').prop('disabled', true).prop('checked', false).parents('.radio').addClass('disabled');
	});
	$(document).on('click','#is_free_off',function(){
		$('#is_free_on').prop('checked', false).parent().removeClass('checked');
		if ($('#shipping_handling_off').prop('disabled') === true)
		{
			$('#shipping_handling_off').prop('disabled', false).prop('checked', false).parents('.radio').removeClass('disabled');
			$('#shipping_handling_on').prop('disabled', false).prop('checked', true).parents('.radio').removeClass('disabled');
		}
	});
});

function initCarrierWizard()
{
	$("#carrier_wizard").smartWizard({
		'labelNext' : labelNext,
		'labelPrevious' : labelPrevious,
		'labelFinish' : labelFinish,
		'fixHeight' : 1,
		'onShowStep' : onShowStepCallback,
		'onLeaveStep' : onLeaveStepCallback,
		'onFinish' : onFinishCallback,
		'transitionEffect' : 'slideleft',
		'enableAllSteps' : enableAllSteps,
		'keyNavigation' : false
	});
	displayRangeType();
    $('#carrier_wizard .actionBar .buttonFinish').before('<a class="buttonCancel btn btn-cancel btn-primary" href="'+carrierlist_url+'"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg> '+labelCancel+'</a>');
}

function displayRangeType()
{
	if ($('input[name="shipping_method"]:checked').val() == 1)
	{
		string = string_weight;
		$('.weight_unit').show();
		$('.price_unit').hide();
	}
	else
	{
		string = string_price;
		$('.price_unit').show();
		$('.weight_unit').hide();
	}
	is_freeClick($('input[name="is_free"]:checked'));
	$('.range_type').html(string);
}

function onShowStepCallback()
{
	$('.anchor li a').each(function () {
		$(this).closest('li').addClass($(this).attr('class'));
	});
	$('#carrier_logo_block').prependTo($('div.content').filter(function() { return $(this).css('display') != 'none' }).find('.defaultForm').find('fieldset'));
	resizeWizard();
}

function onFinishCallback(obj, context)
{
	$('.wizard_error').remove();
    var data = new FormData();
    var data_inputs = $('#carrier_wizard .stepContainer .content form').serializeArray();
    $.map(data_inputs, function(n, i){
        data.append(n['name'],n['value']);
    });
    data.append('action','finish_step');
    data.append('ajax',1);
    data.append('step_number',context.fromStep);
    if($('#carrier_wizard .stepContainer .content form input[type="file"]').length )
    {
        $('#carrier_wizard .stepContainer .content form input[type="file"]').each(function(){
            var file_data = this.files;
            var input_name = $(this).attr('name');
            for (var i = 0; i < file_data.length; i++) {
                data.append(input_name, file_data[i]);
            }
        });
        
    }
	$.ajax({
		type:"POST",
		url : validate_url,
		async: false,
		dataType: 'json',
		data : data ,
		contentType: false,
        processData: false,
        success : function(data) {
			if (data.has_error)
			{
				displayError(data.errors, context.fromStep);
				resizeWizard();
			}
			else
				window.location.href = carrierlist_url;
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			alert("TECHNICAL ERROR: \n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus);
		}
	});
}

function onLeaveStepCallback(obj, context)
{
	if (context.toStep == nbr_steps)
		displaySummary();

	return validateSteps(context.fromStep, context.toStep); // return false to stay on step and true to continue navigation
}

function displaySummary()
{
    var id_default_lang = typeof default_language !== 'undefined' ? default_language : 1,
        id_lang = id_default_lang;

    // Try to find current employee language
    if (typeof languages !== 'undefined' && typeof iso_user !== 'undefined')
        for (var i=0; i<languages.length; i++)
            if (languages[i]['iso_code'] == iso_user)
            {
                id_lang = languages[i]['id_lang'];
                break;
            }

    // used as buffer - you must not replace directly in the translation vars
    var tmp,
        delay_text = $('#delay_' + id_lang).val();

    // Assign text in default language if empty
    if (!delay_text)
        delay_text = $('#delay_' + id_default_lang).val();

	// Carrier name
	$('#summary_name').text($('#name').val());

	// Delay and pricing
	tmp = summary_translation_meta_informations.replace('%2$s', '<strong>' + delay_text + '</strong>');
    if ($('#is_free_on').is(':checked'))
		tmp = tmp.replace('%1$s', summary_translation_free);
	else
		tmp = tmp.replace('%1$s', summary_translation_paid);
	$('#summary_meta_informations').html(tmp);

	// Tax and calculation mode for the shipping cost
	tmp = summary_translation_shipping_cost.replace('%2$s', $('#id_tax_rules_group option:selected').text());

		if ($('#billing_price').is(':checked'))
			tmp = tmp.replace('%1$s', summary_translation_price);
		else if ($('#billing_weight').is(':checked'))
			tmp = tmp.replace('%1$s', summary_translation_weight);
		else
			tmp = tmp.replace('%1$s', '<strong>' + summary_translation_undefined + '</strong>');



	$('#summary_shipping_cost').text(tmp);

	// Weight or price ranges
	$('#summary_range').text(summary_translation_range+' '+summary_translation_range_limit);


	if ($('input[name="shipping_method"]:checked').val() == 1)
		unit = PS_WEIGHT_UNIT;
	else
		unit = currency_sign;

	var range_inf = summary_translation_undefined;
	var range_sup = summary_translation_undefined;

	$('tr.range_inf td input').each(function()
	{
		if (!isNaN(parseFloat($(this).val())) && (range_inf == summary_translation_undefined || parseFloat(range_inf) > parseFloat($(this).val())))
			range_inf = $(this).val();
	});

	$('tr.range_sup td input').each(function(){

		if (!isNaN(parseFloat($(this).val())) && (range_sup == summary_translation_undefined || parseFloat(range_sup) < parseFloat($(this).val())))
			range_sup = $(this).val();
	});
    if(range_sup!='[undefined]')
    {
        $('#summary_range').show();
        $('#summary_range').html(
    		$('#summary_range').html()
    		.replace('%1$s', '<strong>' + range_inf +' '+ unit + '</strong>')
    		.replace('%2$s', '<strong>' + range_sup +' '+ unit + '</strong>')
    		.replace('%3$s', '<strong>' + $('#range_behavior option:selected').text().toLowerCase() + '</strong>')
    	);
    }
	else
        $('#summary_range').hide();
	if ($('#is_free_on').is(':checked'))
		$('span.is_free').hide();
	// Delivery zones
	$('#summary_zones').html('');
	$('.input_zone').each(function(){
		if ($(this).is(':checked'))
			$('#summary_zones').html($('#summary_zones').html() + '<li><strong>' + $(this).closest('tr').find('label').text() + '</strong></li>');
	});

	// Group restrictions
	$('#summary_groups').html('');
	$('input[name$="groupBox[]"]').each(function(){
		if ($(this).is(':checked'))
        {
           $('#summary_groups').html($('#summary_groups').html() + '<li><strong>' + $(this).closest('tr').find('td:eq(2)').text() + '</strong></li>');
        }
			
	});

	// shop restrictions
	$('#summary_shops').html('');
	$('.input_shop').each(function(){
		if ($(this).is(':checked'))
			$('#summary_shops').html($('#summary_shops').html() + '<li><strong>' + $(this).closest().text() + '</strong></li>');
	});
}

function validateSteps(fromStep, toStep)
{
	var is_ok = true;
	if ((multistore_enable && fromStep == 3) || (!multistore_enable && fromStep == 2))
	{
		if (toStep > fromStep && $('input[name="is_free"]:checked').val()==0)
		{
			is_ok = false;
			$('.input_zone').each(function () {
				if ($(this).prop('checked'))
					is_ok = true;
			});

			if (!is_ok)
			{
				displayError([select_at_least_one_zone], fromStep);
				return;
			}
		}

		if (toStep > fromStep && $('input[name="is_free"]:checked').val()==0 && !validateRange(2))
		{
		  is_ok = false;
		}
	}

	$('.wizard_error').remove();

	if (is_ok && isOverlapping())
	{
	   is_ok = false;
	}
	if (is_ok)
	{
		form = $('#carrier_wizard #step-'+fromStep+' form');
		$.ajax({
			type:"POST",
			url : validate_url,
			async: false,
			dataType: 'json',
			data : form.serialize()+'&step_number='+fromStep+'&action=validate_step&ajax=1',
			success : function(datas)
			{
				if (datas.has_error)
				{
					is_ok = false;
					$('div.input-group input').focus(function () {
						$(this).closest('div.input-group').removeClass('has-error');
					});
					displayError(datas.errors, fromStep);
					resizeWizard();
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				jAlert("TECHNICAL ERROR: \n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus);
			}
		});
	}
	return is_ok;
}

function displayError(errors, step_number)
{
	$('#carrier_wizard .actionBar a.btn').removeClass('disabled');
	$('.wizard_error').remove();
	str_error = '<div class="error wizard_error" style="display:none"><ul>';
	for (var error in errors)
	{
		$('#carrier_wizard .actionBar a.btn').addClass('disabled');
		$('input[name="'+error+'"]').closest('div.input-group').addClass('has-error');
		str_error += '<li>'+errors[error]+'</li>';
	}
	$('#step-'+step_number).prepend(str_error+'</ul></div>');
	$('.wizard_error').fadeIn('fast');
	bind_inputs();
}

function resizeWizard()
{
	//resizeInterval = setInterval(function (){$("#carrier_wizard").smartWizard('fixHeight'); clearInterval(resizeInterval)}, 100);
}

function bind_inputs()
{
	$('input').focus(function () {
		$(this).closest('div.input-group').removeClass('has-error');
		$('#carrier_wizard .actionBar a.btn').not('.buttonFinish').removeClass('disabled');
		$('.wizard_error').fadeOut('fast', function () { $(this).remove()});
	});

	$('tr.delete_range td button').off('click').on('click', function () {
		if (confirm(delete_range_confirm))
		{
			index = $(this).closest('td').index();
			$('tr.range_sup td:eq('+index+'), tr.range_inf td:eq('+index+'), tr.fees_all td:eq('+index+'), tr.delete_range td:eq('+index+')').remove();
			$('tr.fees').each(function () {
				$(this).find('td:eq('+index+')').remove();
			});
			rebuildTabindex();
		}
		return false;
	});

	$('tr.fees td input:checkbox').off('change').on('change', function ()
	{
		if($(this).is(':checked'))
		{

			$(this).closest('tr').find('td').each(function () {
				index = $(this).index();
				enableGlobalFees(index);
				$(this).find('div.input-group input:text').removeAttr('disabled');

			});
		}
		else
			$(this).closest('tr').find('td').find('div.input-group input:text').attr('disabled', 'disabled');

		return false;
	});

	$('tr.range_sup td input:text, tr.range_inf td input:text').keypress(function (evn) {
		index = $(this).closest('td').index();
		if (evn.keyCode == 13)
		{
			if (validateRange(index))
				enableRange(index);
			else
				disableRange(index);
			return false;
		}
	});

	$('tr.fees_all td input:text').keypress(function (evn) {
		index = $(this).parent('td').index();
		if (evn.keyCode == 13)
			return false;
	});

	$(document.body).off('change', 'tr.fees_all td input').on('change', 'tr.fees_all td input', function() {
        index = $(this).closest('td').index();
        val = $(this).val();
		$(this).val('');
		$('tr.fees').each(function () {
			$(this).find('td:eq('+index+') input:text:enabled').val(val);
		});

		return false;
	});

	$('input[name="is_free"]').off('click').on('click', function() {
		is_freeClick(this);
	});

	$('input[name="shipping_method"]').off('click').on('click', function() {
		$('input[name="shipping_method"]').prop('checked',false).parent().removeClass('checked');
		$(this).prop('checked',true).parent().addClass('checked');
		$.ajax({
			type:"POST",
			url : validate_url,
			async: false,
			dataType: 'html',
			data : 'id_carrier='+parseInt($('#id_carrier').val())+'&shipping_method='+parseInt($(this).val())+'&action=changeRanges&ajax=1',
			success : function(data) {
				$('#zone_ranges').replaceWith(data);
				displayRangeType();
				bind_inputs();
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				jAlert("TECHNICAL ERROR: \n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus);
			}
		});
	});

	$('#zones_table td input[type=text]').off('change').on('change', function () {
		checkAllFieldIsNumeric();
	});
}

function is_freeClick(elt)
{
	var is_free = $(elt);
	if (parseInt(is_free.val()))
		hideFees();
	else if (fees_is_hide)
		showFees();
}

function hideFees()
{
	$('tr.range_inf td, tr.range_sup td, tr.fees_all td, tr.fees td').each(function () {
		if ($(this).index() >= 2)
		{
			$(this).find('input:text, button').val('').css('background-color', '#999999').css('pointer-events', 'none').css('border-color', '#999999');
			$(this).css('background-color', '#999999');
		}
	});
	fees_is_hide = true;
}

function showFees()
{
	$('tr.range_inf td, tr.range_sup td, tr.fees_all td, tr.fees td').each(function () {
		if ($(this).index() >= 2)
		{
			//enable only if zone is active
			tr = $(this).closest('tr');
			validate = $('tr.fees_all td:eq('+$(this).index()+')').hasClass('validated');
			$(this).find('input:text, button').css('background-color', '').css('border-color', '').css('pointer-events', '');
			$(this).find('button').css('background-color', '').css('border-color', '').removeAttr('disabled');
			$(this).css('background-color', '');
		}
	});
}
function checked_radio()
{
	$('.stepContainer .switch input[type="radio"]').each(function(){
		if ( $(this).parents('.radio').length > 0 ){
			$(this).parents('.switch').find('.radio').removeClass('checked');
			$(this).parents('.radio').addClass('checked');
		}
	});
	$('.stepContainer .switch input[type="radio"]').on('click',function(){
		if ( $(this).parents('.radio').length > 0 ){
			$(this).parents('.switch').find('.radio').removeClass('checked');
			$(this).parents('.radio').addClass('checked');
		}
	});
}

function validateRange(index)
{
	$('#carrier_wizard .actionBar a.btn').removeClass('disabled');
	$('.wizard_error').remove();

	var isValid = true;
	var $currentRangeSup = $('tr.range_sup td:eq(' + index + ')').find('div.input-group input:text');
	var $currentRangeInf = $('tr.range_inf td:eq(' + index + ')').find('div.input-group input:text');
	var rangeSup = parseFloat($currentRangeSup.val().trim());
	var rangeInf = parseFloat($currentRangeInf.val().trim());
	
	//reset css error
	$currentRangeSup.closest('div.input-group').removeClass('has-error');
	$currentRangeInf.closest('div.input-group').removeClass('has-error');

	if (isNaN(rangeSup) || rangeSup.length === 0) {
		$currentRangeSup.closest('div.input-group').addClass('has-error');
		isValid = false;
		displayError([invalid_range], $("#carrier_wizard").smartWizard('currentStep'));
	} else if (isValid && (isNaN(rangeInf) || rangeInf.length === 0)) {
		$currentRangeInf.closest('div.input-group').addClass('has-error');
		isValid = false;
		displayError([invalid_range], $("#carrier_wizard").smartWizard('currentStep'));
	} else if (isValid && rangeInf >= rangeSup) {
		$currentRangeSup.closest('div.input-group').addClass('has-error');
		$currentRangeInf.closest('div.input-group').addClass('has-error');
		isValid = false;
		displayError([invalid_range], $("#carrier_wizard").smartWizard('currentStep'));
	} else if (isValid && (index > 2 || $('tr.range_sup td').not('.range_type, .range_sign').length > 1)) { //check range only if it's not the first range
		isValid = !isOverlapping();
        
		if (!isValid) {
			$currentRangeSup.closest('div.input-group').addClass('has-error');
			$currentRangeInf.closest('div.input-group').addClass('has-error');
			displayError([range_is_overlapping], $("#carrier_wizard").smartWizard('currentStep'));
		}
	}

	if (isValid) {
		$('tr.range_sup td').not('.range_type, .range_sign').each( function () {
			var $this = $(this);
			var currentIndex = $this.index();
			if ($this.find('.has-error').length > 0 && currentIndex !== index) {
				isValid = validateRange(currentIndex);
				if (isValid) {
					enableRange(currentIndex);
				}
			}
		});
	}

	isValid = !$currentRangeSup.closest('div.input-group').hasClass('has-error');

	return isValid;
}

function enableZone(index)
{
	$('tr.fees').each(function () {
		if ($(this).find('td:eq(1)').find('input[type=checkbox]:checked').length)
			$(this).find('td:eq('+index+')').find('div.input-group input').removeAttr('disabled');
	});
}

function disableZone(index)
{
	$('tr.fees').each(function () {
		$(this).find('td:eq('+index+')').find('div.input-group input').attr('disabled', 'disabled');
	});
}

function enableRange(index)
{
	$('tr.fees').each(function () {
		//only enable fees for enabled zones
		if ($(this).find('td').find('input:checkbox').is(':checked'))
			enableZone(index);
	});
	$('tr.fees_all td:eq('+index+')').addClass('validated').removeClass('not_validated');

		enableGlobalFees(index);
	bind_inputs();
}

function enableGlobalFees(index)
{
	$('span.fees_all').show();
	$('tr.fees_all td:eq('+index+')').find('div.input-group input').show().removeAttr('disabled');
	$('tr.fees_all td:eq('+index+')').find('div.input-group .currency_sign').show();
}

function disabledGlobalFees(index)
{
	$('span.fees_all').hide();
	$('tr.fees_all td:eq('+index+')').find('div.input-group input').hide().attr('disabled', 'disabled');
	$('tr.fees_all td:eq('+index+')').find('div.input-group .currency_sign').hide();
}


function disableRange(index)
{
	$('tr.fees').each(function () {
		//only enable fees for enabled zones
		if ($(this).find('td').find('input:checkbox').is(':checked'))
			disableZone(index);
	});
	$('tr.fees_all td:eq('+index+')').find('div.input-group input').attr('disabled', 'disabled');
	$('tr.fees_all td:eq('+index+')').removeClass('validated').addClass('not_validated');
}

function add_new_range()
{
	if (!$('tr.fees_all td:last').hasClass('validated'))
	{
		alert(need_to_validate);
		return false;
	}

	last_sup_val = $('tr.range_sup td:last input').val();
	//add new rand sup input
	$('tr.range_sup td:last').after('<td class="range_data"><div class="input-group fixed-width-md"><span class="input-group-addon weight_unit" style="display: none;">'+PS_WEIGHT_UNIT+'</span><span class="input-group-addon price_unit" style="display: none;">'+currency_sign+'</span><input class="form-control" name="range_sup[]" type="text" autocomplete="off" /></div></td>');
	//add new rand inf input
	$('tr.range_inf td:last').after('<td class="border_bottom"><div class="input-group fixed-width-md"><span class="input-group-addon weight_unit" style="display: none;">'+PS_WEIGHT_UNIT+'</span><span class="input-group-addon price_unit" style="display: none;">'+currency_sign+'</span><input class="form-control" name="range_inf[]" type="text" value="'+last_sup_val+'" autocomplete="off" /></div></td>');
	$('tr.fees_all td:last').after('<td class="border_top border_bottom"><div class="input-group fixed-width-md"><span class="input-group-addon currency_sign" style="display:none" >'+currency_sign+'</span><input class="form-control" style="display:none" type="text" /></div></td>');

	$('tr.fees').each(function () {
		if ($(this).find('td.zone').find('input:checked').length > 0 ){
			$(this).find('td:last').after('<td><div class="input-group fixed-width-md"><span class="input-group-addon currency_sign">'+currency_sign+'</span><input class="form-control" name="fees['+$(this).data('zoneid')+'][]" type="text" /></div></td>');
		} else {
			$(this).find('td:last').after('<td><div class="input-group fixed-width-md"><span class="input-group-addon currency_sign">'+currency_sign+'</span><input class="form-control" disabled="disabled" name="fees['+$(this).data('zoneid')+'][]" type="text" /></div></td>');
		}

	});
	$('tr.delete_range td:last').after('<td><button class="btn btn-default">'+labelDelete+'</button</td>');

	bind_inputs();
	rebuildTabindex();
	displayRangeType();
	resizeWizard();
	return false;
}

function delete_new_range()
{
	if ($('#new_range_form_placeholder').find('td').length = 1)
		return false;
}

function checkAllFieldIsNumeric()
{
	$('#carrier_wizard .actionBar a.btn').removeClass('disabled');
	$('#zones_table td input[type=text]').each(function () {
		if (!$.isNumeric($(this).val()) && $(this).val() != '')
			$(this).closest('div.input-group').addClass('has-error');
	});
}

function rebuildTabindex()
{
	i = 1;
	$('#zones_table tr').each(function ()
	{
		j = i;
		$(this).find('td').each(function ()
		{
			j = zones_nbr + j;
			if ($(this).index() >= 2 && $(this).find('div.input-group input'))
				$(this).find('div.input-group input').attr('tabindex', j);
		});
		i++;
	});
}

function repositionRange(current_index, new_index)
{
	$('tr.range_sup, tr.range_inf, tr.fees_all, tr.fees, tr.delete_range ').each(function () {
		$(this).find('td:eq('+current_index+')').each(function () {
			$(this).closest('tr').find('td:eq('+new_index+')').after(this.outerHTML);
			$(this).remove();
		});
	});
}

function checkRangeContinuity(reordering)
{
	reordering = typeof reordering !== 'undefined' ? reordering : false;
	res = true;

	$('tr.range_sup td').not('.range_type, .range_sign').each(function ()
	{
		index = $(this).index();
		if (index > 2)
		{
			range_sup = parseFloat($('tr.range_sup td:eq('+index+')').find('div.input-group input:text').val().trim());
			range_inf = parseFloat($('tr.range_inf td:eq('+index+')').find('div.input-group input:text').val().trim());
			prev_index = index-1;
			prev_range_sup = parseFloat($('tr.range_sup td:eq('+prev_index+')').find('div.input-group input:text').val().trim());
			prev_range_inf = parseFloat($('tr.range_inf td:eq('+prev_index+')').find('div.input-group input:text').val().trim());

			if (range_inf < prev_range_inf || range_sup < prev_range_sup)
			{
				res = false;
				if (reordering)
				{
					new_position = getCorrectRangePosistion(range_inf, range_sup);
					if (new_position)
						repositionRange(index, new_position);
				}
			}
		}
	});
	if (res)
		$('.ranges_not_follow').fadeOut();
	else
		$('.ranges_not_follow').fadeIn();
	resizeWizard();
}

function getCorrectRangePosistion(current_inf, current_sup)
{
	new_position = false;
	$('tr.range_sup td').not('.range_type, .range_sign').each(function ()
	{
		index = $(this).index();
		range_sup = parseFloat($('tr.range_sup td:eq('+index+')').find('div.input-group input:text').val().trim());
		next_range_inf = 0
		if ($('tr.range_inf td:eq('+index+1+')').length)
			next_range_inf = parseFloat($('tr.range_inf td:eq('+index+1+')').find('div.input-group input:text').val().trim());
		if (current_inf >= range_sup && current_sup < next_range_inf)
			new_position = index;
	});
	return new_position;
}

function isOverlapping()
{
	var isValid = false;
	$('#carrier_wizard .actionBar a.btn').removeClass('disabled');
	$('tr.range_sup td').not('.range_type, .range_sign').each(function() {
		var index = $(this).index();
		var currentInf = parseFloat($('.range_inf td:eq(' + index + ') input').val());
		var currentSup = parseFloat($('.range_sup td:eq(' + index + ') input').val());

		$('tr.range_sup td').not('.range_type, .range_sign').each(function() {
			var testingIndex = $(this).index();

			if (testingIndex !== index && testingIndex >= (index - 1)) { //do not test himself
				var testingInf = parseFloat($('.range_inf td:eq(' + testingIndex + ') input').val());
				var testingSup = parseFloat($('.range_sup td:eq(' + testingIndex + ') input').val());
				var checkOverLapping = (index < testingIndex) ?
					(currentInf >= testingInf || currentInf >= testingSup || currentSup > testingInf || currentSup >= testingSup)
					: (currentInf <= testingInf || currentInf < testingSup || currentSup <= testingInf || currentSup <= testingSup);

				if (checkOverLapping) {
					$('tr.range_sup td:eq(' + testingIndex + ') div.input-group, tr.range_inf td:eq(' + testingIndex + ') div.input-group').addClass('has-error');
					disableRange(testingIndex);
					displayError([overlapping_range], $("#carrier_wizard").smartWizard('currentStep'));
					isValid = true;
				}
			}
		});
	});

	return isValid;
}

function checkAllZones(elt)
{
	if($(elt).is(':checked'))
	{
		
		$('.fees div.input-group input:text').each(function () {
			index = $(this).closest('td').index();
			enableGlobalFees(index);
			if ($('tr.fees_all td:eq('+index+')').hasClass('validated'))
			{
				$(this).removeAttr('disabled');
				$('.fees_all td:eq('+index+') div.input-group input:text').removeAttr('disabled');
			}
		});
        $('.input_zone').each(function(){
            $(this).prop('checked',true)
        });
	}
	else
	{
		$('.input_zone').removeis(':checked');
		$('.fees div.input-group input:text, .fees_all div.input-group input:text').attr('disabled', 'disabled');
	}

}

var carriersRangeInputs = {
	/** Check the carriers range inputs after each change */
	watchCarriersRangeInputChange: function() {
		var $document = $(document);
		var inputs = 'tr.range_sup td input:text, tr.range_inf td input:text';

		$document.on('focus', inputs, function() {
			$(this).closest('div.input-group').removeClass('has-error');
			$(this).typeWatch({
				captureLength: 0,
				highlight: false,
				wait: 1000,
				callback: function() {
					var index = $(this.el).closest('td').index();
					var rangeSup = $('tr.range_sup td:eq(' + index + ')').find('div.input-group input:text').val().trim();
					var rangeInf = $('tr.range_inf td:eq(' + index + ')').find('div.input-group input:text').val().trim();
					if (rangeSup !== '' && rangeInf !== '') {
						carriersRangeInputs.checkCarriersRangeValidation(index);
					}
				}
			});
		});

		$document.on('blur', inputs, function() {
			var $this = $(this);
			$this.off();
			var index = $this.closest('td').index();
			var hasError = $('tr.range_sup td:eq(' + index + ') .has-error, tr.range_inf td:eq(' + index + ') .has-error');
			
			if ($('.wizard_error').length === 0 || hasError.length !== 0) {
				carriersRangeInputs.checkCarriersRangeValidation(index);
			}
		});
	},
	/**
	 * Check range validation
	 * @param {number} index
	 */
	checkCarriersRangeValidation: function(index) {
		if (validateRange(index)) {
			enableRange(index);
		} else {
			disableRange(index);
		}
	}
};
$(document).on('click','#checked_all_zone',function(){
   if($(this).is(':checked'))
	{
	    var checkboxes = document.getElementsByClassName('input_zone');
        for (var i=0; i<checkboxes.length; i++)  {
              if (checkboxes[i].type == 'checkbox')   {
                    checkboxes[i].checked = true;
              }
        } 
        $(window).resize();  
		$('.fees div.input-group input:text').each(function () {
			index = $(this).closest('td').index();
			enableGlobalFees(index);
			$(this).removeAttr('disabled');
			$('.fees_all td:eq('+index+') div.input-group input:text').removeAttr('disabled');

		});
        
	}
	else
	{
		$('.input_zone').prop('checked',false);
        $(window).resize();
		$('.fees div.input-group input:text, .fees_all div.input-group input:text').attr('disabled', 'disabled');
	} 
});
