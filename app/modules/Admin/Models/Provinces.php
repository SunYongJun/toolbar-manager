<?php
namespace Admin\Models;
/**
	* 省份
	* @author 孙永军
*/

class Provinces extends \Phalcon\Mvc\Model {
	
	public function getSource(){
		return "tb_provinces";
	}	

}