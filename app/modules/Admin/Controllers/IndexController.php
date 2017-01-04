<?php
/**
	* 入口类
	* @author 孙永军
*/ 

namespace Admin\Controllers;
use \Phalcon\MVC\Controller;

class IndexController  extends Controller{
	function indexAction(){
		$this->response->redirect('main');
		$this->response->send();
	}
}