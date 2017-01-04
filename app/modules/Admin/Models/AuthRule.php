<?php
namespace Admin\Models;
/**
	* 权限规则
	* @author 孙永军
*/

class AuthRule extends \Phalcon\Mvc\Model {
	public function getSource(){
		return 'tb_auth_rule';
	}

}