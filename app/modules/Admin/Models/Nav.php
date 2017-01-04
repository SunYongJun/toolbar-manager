<?php
namespace Admin\Models;
/**
	* 频道
	* @author 孙永军
*/

class Nav extends \Phalcon\Mvc\Model {
	public function getSource(){
		return 'tb_nav';
	}

	public function initialize() {
		$this->hasOne('provinceid','Admin\Models\Provinces','provinceid',array('alias'=>'Provinces'));
	}
	
}