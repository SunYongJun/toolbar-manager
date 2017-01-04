<?php
namespace Admin\Models;
/**
	* 权限组
	* @author 孙永军
*/

class AuthGroup extends \Phalcon\Mvc\Model {
	public function getSource(){
		return 'tb_auth_group';
	}

	public function getRules(){
		$sql = 'SELECT id,title,controller,action FROM Admin\Models\AuthRule WHERE id IN ('.$this->rules.')';
		return $this->modelsManager->executeQuery($sql);
	}
}