<?php
namespace Admin\Models;
/**
	* 市
	* @author 孙永军
*/

class Cities extends \Phalcon\Mvc\Model {
	
	public function getSource(){
		return "tb_cities";
	}	

}