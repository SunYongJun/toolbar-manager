<?php
namespace Admin\Controllers;

use Admin\Models\Provinces;
use Admin\Models\User;
use Admin\Models\AuthGroup;
/**
	* 用户管理
	* @author 孙永军
*/

class userController extends ControllerBase{ 

	public function initialize(){
		parent::initialize();
		$this->view->setVar('provinces',Provinces::find());
	}

	public function indexAction(){
		$condi = '1=1 ';
		$bind  = array();

		if($this->request->get('email')){
			$condi .= " AND email = :email: ";
			$bind['email'] = $this->request->get('email');
		}

		if($this->request->get('provinceid')){
			$condi .= " AND provinceid = :provinceid: ";
			$bind['provinceid'] = $this->request->get('provinceid');
		}


		if($this->request->get('name')){
			$condi .= " AND name like :name: ";
			$bind['name'] = $this->request->get('name').'%';
		}

		if($this->request->get('company')){
			$condi .= " AND company like :company: ";
			$bind['company'] = $this->request->get('company').'%';
		}

		if($this->request->get('status')){
			$condi .= " AND status = :status: ";
			$bind['status'] = $this->request->get('status');
		}else{
			$condi .= " AND status != :status: ";
			$bind['status'] = 4;
		}

		$users = User::find(array(
			"conditions" => $condi,
			"bind" => $bind
			));

		$this->view->setVar('users',$users);	
	}

	public function addAction(){
		$this->view->setVar('auth',AuthGroup::find('status = 1'));
	}

	public function insertAction(){
		$user = new User;

		$user->name = $this->request->getPost('name');
		$user->email = $this->request->getPost('email');
		$user->password  = sha1($this->request->getPost('password'));
		$user->provinceid = $this->request->getPost('provinceid');
		$user->phone = $this->request->getPost('phone');
		$user->company = $this->request->getPost('company');
		$user->addr = $this->request->getPost('addr');
		$user->auth = $this->request->getPost('auth');
		$user->ctime = $user->mtime = time();
		$user->status = 1;

		if($user->create()){
			$this->flashSession->success("添加成功！");
			$this->redirect('user/index');
		}else{
			$this->redirect('user/add');
		}
	}

	public function editAction(){
		if(!$this->request->get('id')){
			$this->redirect('user/index');
		}

		$user = User::findFirst($this->request->get('id'));

		$this->view->setVar('auth',AuthGroup::find('status = 1'));
		$this->view->setVar('user',$user);
	}

	public function doitAction(){
		if($this->request->isPost()){

			$user = user::findFirst($this->request->getPost('id'));
			$user->name 	= $this->request->getPost('name');
			$user->email = $this->request->getPost('email');	
			$user->provinceid = $this->request->getPost('provinceid');		
			$user->phone = $this->request->getPost('phone');
			$user->company = $this->request->getPost('company');
			$user->addr = $this->request->getPost('addr');
			$user->auth = $this->request->getPost('auth');

			if($this->request->getPost('password')){
				$user->password  = sha1($this->request->getPost('password'));
			}

			if($user->save()){
				$this->flashSession->success("修改成功！");
				$this->redirect('user/index');
			}else{
				foreach($model->getMessages() as $message){
					echo $message,"\n";
				}
				exit;
			}
		}

		$this->redirect('user/edit?id='.$this->request->getPost('id'));
	}

	public function delAction(){

		if($this->request->get('id')){
			$result = User::findFirst($this->request->get('id'));
			$result->status = 4;
			if($result->save($this->request->get('id'))){
				$this->redirect("user/index");
			}else{
				foreach($model->getMessages() as $message){
					echo $message,"\n";
				}
			}
		}

	}

}