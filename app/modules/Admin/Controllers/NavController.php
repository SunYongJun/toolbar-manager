<?php
namespace Admin\Controllers;

use Admin\Models\Nav;
/**
	* 频道控制
	* @author 孙永军
*/

class navController extends ControllerBase{
	private $showType = [1=>'文字',2=>'图片'];

	public function initialize(){
		parent::initialize();
		$this->view->setVar('showType',$this->showType);
	}

	public function indexAction(){

		$cond = "status = 1 ";

		if($this->session->get('user')['provinceid']){
			$cond .= " AND provinceid = {$this->session->get('user')['provinceid']}";
		}

		$navs = Nav::find(array(
			$cond,
			'order' => 'ord ASC'
			));

		$this->view->setVar('navs',$navs);
	}

	public function addAction(){
		if($this->session->get('user')['provinceid'] == 0){
			$this->view->setVar('provinces',Provinces::find());
		}
	}

	public function insertAction(){
		$nav = new Nav;
		$nav->name = $this->request->getPost('name');
		$nav->tmpl = $this->request->getPost('tmpl');
		$nav->ord  = $this->request->getPost('ord');
		$nav->desc = $this->request->getPost('desc');
		$nav->type = $this->request->getPost('type');
		// $nav->cityid = $this->request->getPost('cityid') ? $this->request->getPost('cityid') : 0;
		$nav->provinceid = $this->session->get('user')['provinceid'] ? $this->session->get('user')['provinceid'] : $this->request->getPost('provinceid');

		if($nav->create()){
			$this->flashSession->success("添加成功！");
			$this->redirect('nav/index');
		}else{
			$this->redirect('nav/add');
		}
	}

	public function editAction(){
		if(!$this->request->get('id')){
			$this->redirect('nav/index');
		}
		$nav = Nav::findFirst($this->request->get('id'));
		$_type = $this->request->get('showType') ? $this->request->get('showType') : $nav->type;
		$this->view->setVar('_type',$_type);
		$this->view->setVar('nav',$nav);
		if($this->session->get('user')['provinceid'] == 0){
			$this->view->setVar('provinces',Provinces::find());
		}
	}

	public function doitAction(){
		if($this->request->isPost()){

			$model = Nav::findFirst($this->request->getPost('id'));
			$model->name 	= $this->request->getPost('name');
			$model->type    = $this->request->getPost('type');
			$model->tmpl 	= $this->request->getPost('tmpl');			
			$model->ord 	= $this->request->getPost('ord');
			$model->desc 	= $this->request->getPost('desc');
			// $nav->cityid 	= $this->request->getPost('cityid') ? $this->request->getPost('cityid') : 0;

			if($model->save()){
				$this->flashSession->success("修改成功！");
				$this->redirect('nav/index');
			}else{
				foreach($model->getMessages() as $message){
					echo $message,"\n";
				}
			}
		}

		$this->redirect('nav/edit?id='.$this->request->getPost('id'));
	}

	public function delAction(){

		if($this->request->get('id')){
			$result = Nav::findFirst($this->request->get('id'));
			$result->status = 2;
			if($result->save($this->request->get('id'))){
				$this->redirect("nav/index");
			}else{
				foreach($model->getMessages() as $message){
					echo $message,"\n";
				}
			}
		}

	}

}