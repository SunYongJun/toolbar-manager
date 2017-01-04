<?php
namespace Admin\Models;
/**
	* 区 / 县
	* @author 孙永军
*/

class Stat extends \Phalcon\Mvc\Model {
	
	public function getSource(){
		return "tb_stat";
	}	

}