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
var ctx_commision_line;
var chart_commision_line;
$(document).ready(function(){
    ctx_commision_line = $('#ets_mp_stats_commision_line');
    chart_commision_line= ets_mp_creatDashboardChart(ctx_commision_line,commissions_line_datasets,chart_labels,'line')
    $(document).on('click','input[name="chart_by_product"]',function(){
       if($(this).val()=='all')
       {
            $('.line-chart-commissions .box-tool-search').hide();
            $('.line-chart-commissions .box-header').removeClass('show_search_time');
            ets_mp_ajaxSubmitCommissionsChart(chart_commision_line,$('select[name="filter-time-stats-commissions"]').val(),$('.date_from_commissions').val(),$('.date_to_commissions').val());
       }
       else
       {
            $('.line-chart-commissions .box-tool-search').show();
            $('.line-chart-commissions .box-header').addClass('show_search_time');
            ets_mp_ajaxSubmitCommissionsChart(chart_commision_line,$('select[name="filter-time-stats-commissions"]').val(),$('.date_from_commissions').val(),$('.date_to_commissions').val());
       }
    });
    $(document).on('change','select[name="filter-time-stats-commissions"]',function(){
        $this=$(this);
        if($this.val()!='time_range')
        {
            $('.line-chart-commissions .box-tool-timerange').hide();
            $('.line-chart-commissions .box-header').removeClass('show_range');
            ets_mp_ajaxSubmitCommissionsChart(chart_commision_line,$this.val(),false,false);
        }
        else
        {
            $('.line-chart-commissions .box-tool-timerange').show();
            $('.line-chart-commissions .box-header').addClass('show_range');
            if($('.date_from_commissions').val()!='' && $('date_to_commissions').val()!='' && $('.date_to_commissions').val()!=$('.date_from_commissions').val())
            {
                ets_mp_ajaxSubmitCommissionsChart(chart_commision_line,$this.val(),$('.date_from_commissions').val(),$('.date_to_commissions').val());
            }     
        }
    });
    $('.ets_mp_date_ranger_filter').on('apply.daterangepicker', function(ev, picker) {
        var date_from= picker.startDate.format('YYYY-MM-DD');
        var date_to = picker.endDate.format('YYYY-MM-DD');
        $(this).next().val(date_from);
        $(this).next().next().val(date_to);
        if($(this).closest('.box-dashboard').hasClass('line-chart-commissions')){
            ets_mp_ajaxSubmitCommissionsChart(chart_commision_line,'time_range',date_from,date_to);
        }
    });
    var ets_mpDate = new Date();
    if(typeof daterangepicker !== 'undefined'){
        $('.ets_mp_date_ranger_filter').daterangepicker({
            locale: { 
                format: 'YYYY/MM/DD'
            }
        });
    }
    if($('#product_search_chart').length)
    {
        $(document).on('click','.delete_product_search',function(){
            $('.product_selected').remove();
            $('#id_product_chart').val('');
            $('#product_search_chart').val('');
            ets_mp_ajaxSubmitCommissionsChart(chart_commision_line,$('select[name="filter-time-stats-commissions"]').val(),$('.date_from_commissions').val(),$('.date_to_commissions').val());
        });
        $('#product_search_chart').autocomplete(ets_mp_url_search_product,{
    		minChars: 1,
    		autoFill: true,
    		max:20,
    		matchContains: true,
    		mustMatch:false,
    		scroll:false,
    		cacheLength:0,
    		formatItem: function(item) {
    			return '<img src="'+item[4]+'" style="width:24px;"/>'+' - '+item[2]+' <br/> '+(item[3] ? 'REF: '+item[3]:'');
    		}
    	}).result(etsMPAddProudctChart);
    }
});
var etsMPAddProudctChart = function(event,data,formatted)
{
    if (data == null)
		return false;
    $('#id_product_chart').val(data[0]);
    ets_mp_ajaxSubmitCommissionsChart(chart_commision_line,$('select[name="filter-time-stats-commissions"]').val(),$('.date_from_commissions').val(),$('.date_to_commissions').val());
    if($('#product_search_chart').next('.products_selected').length <=0)
    {
       $('#product_search_chart').before('<div class="product_selected">'+data[2]+' <span class="delete_product_search"></span><div>');
       $('#product_search_chart').val(''); 
    }
}
function ets_mp_ajaxSubmitCommissionsChart(chart,date_type,date_from,date_to)
{
    $('.box-dashboard.line-chart-commissions').addClass('loading');
    $.ajax({
        url: '',
        type: 'post',
        dataType: 'json',
        data: {
            actionSubmitCommissionsChart: date_type,
            ajax : 1,
            date_from: date_from,
            date_to: date_to,
            id_product_chart : $('input[name="chart_by_product"]:checked').val()=='search' ? $('input[name="id_product_chart"]').val():0
        },
        success: function(json)
        {  
            ets_mp_updateDashboardChart(chart,json.label_datas,json.commissions_line_datasets,json.labelStringx);
            $('.box-dashboard.line-chart-commissions').removeClass('loading');
            $('#total_number_of_product_sold').html(json.total_number_of_product_sold);
            $('#total_turn_over').html(json.total_turn_over);
            $('#total_earning_commission').html(json.total_earning_commission);
        }
    });
}
function ets_mp_creatDashboardChart(ctx,datasets,labels,type)
{
    var aR = null; //store already returned tick
    var conversationLineChart = new Chart(ctx, {
        type: type,
        data: {
            datasets: datasets,
            labels: labels,
            
        },
        options: {
          scales: {
            xAxes: [{
				display: true,
				scaleLabel: {
					display: true,
					labelString: charxlabelString
				}
            }],
             yAxes: [{
                display: true,
				scaleLabel: {
					display: true,
					labelString: charylabelString
				},
                ticks: {
                   min: 0,
                }
             }]
          },
          legend: {
                display: true,
                position:'top'
          },
          tooltips: {
                mode: 'point'
          },
       }
    });
    return conversationLineChart;
}
function ets_mp_updateDashboardChart(chart,label_datas,datas,labelStringx)
{
    chart.data.labels=[];
    if(label_datas)
    {
        $(label_datas).each(function(){
            chart.data.labels.push(this);
        });
    }
    var i=0;
    chart.data.datasets.forEach(function(dataset){
        dataset.data=[];
        if(datas[i])
        {
            $(datas[i]).each(function(){
                dataset.data.push(this);
            });
        }
        i++;
    });
    chart.options.scales.xAxes = [{
		display: true,
		scaleLabel: {
			display: true,
			labelString: labelStringx
		}
    }];
    chart.update();
}