<?php
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

if (!defined('_PS_VERSION_')) { exit; }
class Ets_mp_paggination_class {
	public $total = 0;
	public $page = 1;
	public $limit = 20;
	public $num_links = 4;
	public $url = '';
	public $text = 'Showing {start} to {end} of {total} ({pages} Pages)';
    public $text_first = '';
    public $text_last = '';
    public $text_next = '';
    public $text_prev = '';
	public $style_links = 'links';
	public $style_results = 'results';
    public $alias;
    public $friendly;
    public $name;
    public function __construct()
    {
        $this->alias = false;
        $this->friendly = false;
        $this->text_first = Ets_mp_defines::displayText('|&lt;','span','');
        $this->text_last = Ets_mp_defines::displayText('&gt;|','span','');
        $this->text_next = Ets_mp_defines::displayText('&gt;','span','');
        $this->text_prev = Ets_mp_defines::displayText('&lt;','span','');
    }
	public function render() {
        if(!in_array($this->limit,array(10,8,12,20,30,50,100,300)))
            $this->limit = 10;
        if($this->limit!=10 && $this->name)
            $this->url .='&paginator_'.$this->name.'_select_limit='.(int)$this->limit;
		$total = $this->total;
		if($total<=1)
            return false;
		if ($this->page < 1) {
			$page = 1;
		} else {
			$page = $this->page;
		}
		
		if (!(int)$this->limit) {
			$limit = 10;
		} else {
			$limit = $this->limit;
		}
		
		$num_links = $this->num_links;
		$num_pages = ceil($total / $limit);
		
		$output = '';
		
		if ($page > 1) {
            $output .= Ets_mp_defines::displayText($this->text_first,'a','frist','',$this->replacePage(1)).Ets_mp_defines::displayText($this->text_prev,'a','prev','',$this->replacePage($page-1));
        }

		if ($num_pages > 1) {
			if ($num_pages <= $num_links) {
				$start = 1;
				$end = $num_pages;
			} else {
				$start = $page - floor($num_links / 2);
				$end = $page + floor($num_links / 2);
			
				if ($start < 1) {
					$end += abs($start) + 1;
					$start = 1;
				}
						
				if ($end > $num_pages) {
					$start -= ($end - $num_pages);
					$end = $num_pages;
				}
			}

			if ($start > 1) {
				$output .= Ets_mp_defines::displayText(' .... ','p','paginration_vv');
			}

			for ($i = $start; $i <= $end; $i++) {
				if ($page == $i) {
                    $output .= Ets_mp_defines::displayText($i,'b','');
				} else {
                    $output .= Ets_mp_defines::displayText($i,'a','','',$this->replacePage($i));
				}	
			}
							
			if ($end < $num_pages) {
				$output .= Ets_mp_defines::displayText(' .... ','p','paginration_vv');
			}
		}
		
   		if ($page < $num_pages) {
            $output .= Ets_mp_defines::displayText($this->text_next,'a','next','',$this->replacePage($page+1)).Ets_mp_defines::displayText($this->text_last,'a','last','', $this->replacePage($num_pages));
        }
		
		$find = array(
			'{start}',
			'{end}',
			'{total}',
			'{pages}'
		);
		
		$replace = array(
			($total) ? (($page - 1) * $limit) + 1 : 0,
			((($page - 1) * $limit) > ($total - $limit)) ? $total : ((($page - 1) * $limit) + $limit),
			$total, 
			$num_pages
		);
        return   Ets_mp_defines::displayText(str_replace($find, $replace, $this->text),'div',$this->style_results). Module::getInstanceByName('ets_marketplace')->displayPaggination($limit,$this->name).($output ? Ets_mp_defines::displayText($output,'div','links') : '');
    }
    public function replacePage($page)
    {
        if($page > 1)
            return str_replace('_page_', $page, $this->url);
        else
            return str_replace('/_page_', '', $this->url);
    }
}
?>