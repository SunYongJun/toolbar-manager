<?php
namespace Admin\Models;
/**
	* 区 / 县
	* @author 孙永军
*/

class Areas extends \Phalcon\Mvc\Model {
	
	public function getSource(){
		return "tb_areas";
	}	

}