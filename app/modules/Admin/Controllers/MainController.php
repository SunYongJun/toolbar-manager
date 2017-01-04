<?php
namespace Admin\Controllers;
/**
	* 入口类
	* @author 孙永军
*/ 

use Admin\Models\Stat;
use Admin\Models\Nav;

class mainController extends ControllerBase{

	function indexAction(){

	}

	function topAction(){

	}

	function leftAction(){
		$cond = "status = 1 ";

		if($this->session->get('user')['provinceid']){
			$cond .= " AND provinceid = {$this->session->get('user')['provinceid']}";
		}

		$navs = Nav::find(array(
			$cond,
			'order' => 'ord ASC'
			));
		$this->view->setVar('channel',$navs);
		$this->view->setVar('acl',unserialize(file_get_contents($this->_config->application->aclDir)));
	}

	function rightAction(){
		$this->view->setVar('btn',Stat::find(array(
			'conditions' => 'type = 1 AND cid = 0',
			'order' => 'id desc',
			'limit' => 10
			)));


		$sql = "SELECT SUM(stat.click) as click,nav.* FROM Admin\Models\Stat stat LEFT JOIN Admin\Models\Nav nav ON stat.cid = nav.id WHERE stat.type = 2 GROUP BY stat.cid";

		$tag = $this->modelsManager->executeQuery($sql);

		$sql = "SELECT SUM(stat.click) as click,content.* FROM Admin\Models\Stat stat LEFT JOIN Admin\Models\Content content ON stat.cid = content.id WHERE stat.type = 3 GROUP BY stat.cid LIMIT 10";

		$contents = $this->modelsManager->executeQuery($sql);

		$this->view->setVar('tag',$tag);
		$this->view->setVar('contents',$contents);
	
	}

	function footerAction(){

	}

	function mobileTBAction(){
		
	}

}