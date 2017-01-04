<?php
namespace Admin\Controllers;
/**
	* 控制基类
	* @author 孙永军
*/

use \Phalcon\Mvc\Controller;
abstract class ControllerBase extends Controller {

	protected $status = [0=>'不限',1=>"正常",2=>"删除",3=>"待审核",4=>"未通过"];
	protected $tmpl = [0=>"流量",1=>"表格",2=>"浮动",3=>"活动",4=>"隐藏",5=>"自定义布局",6=>"自定义代码"];

    protected $_config;

    private $_config_path = '/app/config/config.php';

	public function initialize(){

		if(!$this->session->get('user')){
			$this->redirect('login');
		}

		$this->_config = require ROOT_PATH.$this->_config_path;

		$this->view->setVar('action',$this->dispatcher->getActionName());
		$this->view->setVar('controller',$this->dispatcher->getControllerName());
		$this->view->setVar('status',$this->status);
		$this->view->setVar('tmpl',$this->tmpl);
	}
	
	public function beforeExecuteRoute($dispatcher) {
		\Phalcon\Tag::setTitleSeparator('·');
		\Phalcon\Tag::setTitle('ToolBar管理系统');
	}

	public function afterExecuteRoute($dispatcher) {
		$this->assets
				->addCss('css/style.css');
     
		$this->assets
				->addJs('js/jquery.js');
	}

	
	public function redirect($url) {
		$this->response->redirect($url);
		$this->response->send();
		return;
	}

	protected function getPageUrl(){		
		if(count($this->request->get()) > 1){
			$url = $this->request->get();
			unset($url['_url']);
			
			foreach($url as $k=>$v){
				$urlArr[] = $k.'='.$v;
			}
			
			$param = implode($urlArr,'&');
			return '?'.$param.'&';
		}else{
			return '?';
		}
	}

}
