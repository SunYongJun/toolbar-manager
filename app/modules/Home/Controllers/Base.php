<?php
/**
	* 用户控制器
	* @author 孙永军
*/ 

namespace Home\Controllers;

use Phalcon\Mvc\Controller as Controller;

class Base  extends Controller{
	public function initialize(){
		// var_dump($this->di->acl());exit;
	}
}