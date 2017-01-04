<?php
namespace Admin\Models;
/**
	* 用户
	* @author 孙永军
*/

class User extends \Phalcon\Mvc\Model {
	public function getSource(){
		return 'tb_user';
	}

	public function initialize(){
		$this->hasOne('provinceid','Admin\Models\Provinces','provinceid',array('alias'=>'Provinces'));
	}
}