<?php

/**
	* 权限控制
	* @author 孙永军
*/ 

namespace Admin\Controllers;

use Admin\Models\AuthGroup;
use Admin\Models\AuthRule;

class AuthController extends ControllerBase{
	function indexAction(){
		$currentPage = isset($_GET['page']) && !empty($_GET['page']) ? $_GET['page'] : 1;
		$paginator = new \Phalcon\Paginator\Adapter\Model(
			array(
				'data' => AuthGroup::find('status = 1'),
				'limit' => 10,
				'page' => $currentPage
				)
			);
		$rules = $paginator->getPaginate();

		$this->view->setVar('groups',$rules);
		$this->view->setVar('param',$this->getPageUrl());
	}

	function groupaddAction(){
		$this->view->setVar('rules',AuthRule::find('status = 1'));
	}

	function groupinsertAction(){
		if($this->request->isPost()){
			$group = new AuthGroup();
			$group -> title = $this->request->getPost('title');
			$group -> rules = implode(',',$this->request->getPost('ids'));

			if($group->create()){
				$this->clearAclData();
				$this->flashSession->success("添加成功！");	
			}

		}
		$this->redirect('auth/index');
	}

	function groupeditAction(){
		if(isset($_GET['id'])){
			if($group = AuthGroup::findFirst($this->request->get('id'))){
				foreach($group->getRules()->toArray() as $v){
					$rulesIds[] = $v['id'];
				}
				$this->view->setVar('rulesIds',$rulesIds);
				$this->view->setVar('rules',AuthRule::find('status = 1'));
				$this->view->setVar('group',$group);
				return;
			}
		}
		
		$this->redirect('auth/index');  	
	}

	function groupdoitAction(){
		if($this->request->isPost()){
			$group = AuthGroup::findFirst($this->request->getPost('id'));
			$group -> title = $this->request->getPost('title');
			$group -> rules = implode(',',$this->request->getPost('ids'));
			if($group->save()){
				$this->clearAclData();
				$this->flashSession->success("修改成功！");				
			}
			$this->redirect('auth/index');
		}
	}

	function groupdelAction(){
		if($rule = AuthGroup::findFirst($this->request->get('id'))){
			$rule->status = 2;
			$rule->save();
		}
		$this->redirect('auth/group');
	}

	function groupDelAllAction(){
		if($this->request->isPost() && is_array($this->request->getPost('ids'))){
			$sql = "UPDATE AuthGroup SET status = 2 WHERE id IN (".implode(',',$this->request->getPost('ids')).")";
			$this->modelsManager->executeQuery($sql);
		}
		$this->redirect('auth/group');
	}

	function ruleAction(){

		/**
		* 分页
		*/
		$currentPage = isset($_GET['page']) && !empty($_GET['page']) ? $_GET['page'] : 1;
		$paginator = new \Phalcon\Paginator\Adapter\Model(
			array(
				'data' => AuthRule::find('status = 1'),
				'limit' => 10,
				'page' => $currentPage
				)
			);
		$rules = $paginator->getPaginate();

		$this->view->setVar('rules',$rules);
		$this->view->setVar('param',$this->getPageUrl());
	}

	function ruleaddAction(){

	}

	function ruleinsertAction(){
		if($this->request->isPost()){
			$rule = new AuthRule();
			$rule->controller = $this->request->getPost('controller');
			$rule->action = $this->request->getPost('action');
			$rule->title = $this->request->getPost('title');
			$rule->status = 1;

			if($rule->create()){
				$this->flashSession->success("添加成功！");				
			}
			$this->redirect('auth/rule');
		}
	}

	function ruleeditAction(){
		if(isset($_GET['id'])){
			if($rule = AuthRule::findFirst($this->request->get('id'))){
				return $this->view->setVar('rule',$rule);
			}
		}
		
		$this->redirect('auth/rule');  		
	}

	function ruledoitAction(){
		if($this->request->isPost()){
			$rule = AuthRule::findFirst($this->request->getPost('id'));
			$rule->controller = $this->request->getPost('controller');
			$rule->action = $this->request->getPost('action');
			$rule->title = $this->request->getPost('title');

			if($rule->save()){
				$this->flashSession->success("修改成功！");				
			}
			$this->redirect('auth/rule');
		}
	}

	function ruledelAction(){
		if($rule = AuthRule::findFirst($this->request->get('id'))){
			$rule->status = 2;
			$rule->save();
			$this->fillGroup(array($this->request->get('id')));
		}
		$this->redirect('auth/rule');
	}

	function ruleDelAllAction(){
		if($this->request->isPost() && is_array($this->request->getPost('ids'))){
			$sql = "UPDATE Admin\Models\AuthRule SET status = 2 WHERE id IN (".implode(',',$this->request->getPost('ids')).")";
			$this->modelsManager->executeQuery($sql);
			$this->fillGroup($this->request->getPost('ids'));
		}
		$this->redirect('auth/rule');
	}

	private function fillGroup($ids){
		foreach(AuthGroup::find('status = 1') as $v){
			$v->rules = implode(',',array_diff(explode(',',$v->rules),$ids));

			$v->update();
		}
		$this->clearAclData();
	}

	private function clearAclData(){
		unlink(__DIR__.'/../../plugins/acl.data');
	}


}