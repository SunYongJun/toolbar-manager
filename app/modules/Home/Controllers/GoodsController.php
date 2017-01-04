<?php
namespace Home\Controllers;

use Home\Controllers\Base;
use Home\Models\Goods;

class GoodsController extends Base{
	public function indexAction(){
		$goods = Goods::find();

		foreach($goods as $v){
			echo $v->goods_name.'<br>';
		}
	}
}