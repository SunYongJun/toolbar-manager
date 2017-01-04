<?php
namespace Admin\Controllers;

use Admin\Models\Nav;
use Admin\Models\Content;
use Admin\Models\Cities;
/**
	* 内容控制
	* @author 孙永军
*/


class ContentController extends ControllerBase{

	public function indexAction(){
		
		$cond = ' status != :status: AND nid = :nid:';

		$nid = isset($_GET['nid']) ? $_GET['nid'] : Nav::findFirst(array(
				'conditions' => 'status != 2',
				'order' => 'ord ASC'
				))->id;
		
		$channel = Nav::findFirst($nid);

		$contents = Content::find(array(
			"conditions" => $cond,
			"bind" => array('nid'=>$nid,'status'=>2),
			"order" => 'ord ASC'
			));


		/**
		* 分页
		*/
		$currentPage = isset($_GET['page']) && !empty($_GET['page']) ? $_GET['page'] : 1;
		$paginator = new \Phalcon\Paginator\Adapter\Model(
			array(
				'data' => $contents,
				'limit' => 10,
				'page' => $currentPage
				)
			);
		$page = $paginator->getPaginate();



		$this->view->setVar('param',$this->getPageUrl());
		$this->view->setVar('page',$page);
		$this->view->setVar('channel',$channel);
		$this->view->setVar('contents',$contents);

	}

	public function addAction(){

		if(isset($_GET['nid'])){
			$channel = Nav::findFirst($_GET['nid']);
		}else{
			$channel = Nav::findFirst(array(
				'conditions' => 'status != 2',
				'order' => 'ord ASC'
				));
		}

		$this->view->setVar('channel',$channel);
		$this->view->setVar('cities',Cities::find('provinceid = '.$channel->provinceid));
	
	}

	public function insertAction(){

		if($this->request->isPost()){
			$content = new Content;
			$content->nid 	= $this->request->getPost('nid');
			$content->title = $this->request->getPost('title') ? $this->request->getPost('title') :null;
			$content->contents = trim($this->request->getPost('contents')) ? $this->request->getPost('contents') :null;
			$content->linkname = $this->request->getPost('linkname') ? $this->request->getPost('linkname') :null;
			$content->logo = $this->request->getPost('logo') ? $this->request->getPost('logo') :null;
			$content->cityid 	= $this->request->getPost('cityid') ? $this->request->getPost('cityid') : 0;
			$content->url 	= $this->request->getPost('url') ? $this->request->getPost('url') : null;
			$content->ord 	= (int) $this->request->getPost('ord');
			$content->status 	= 3;
			

			if($content->create()){
				$this->flashSession->success("添加成功！");
				$this->redirect('content/index?nid='.$this->request->getPost('nid'));					
			}else{
				foreach($content->getMessages() as $message){
					echo $message,"\n";
				}
				exit;
			}
		}	
		$this->redirect('content/add');
	}

	public function editAction(){
		if($this->request->get('id')){
			$result = Content::findFirst($this->request->get('id'));
			$this->view->setVar('result',$result);
			$this->view->setVar('cities',Cities::find('provinceid = '.Nav::findFirst($request->nid)->provinceid));
		}else{
			$this->redirect('content/index');
		}
	}

	public function doitAction(){

		if($this->request->isPost()){
			$content = Content::findFirst($this->request->getPost('id'));

			$content->title = $this->request->getPost('title') ? $this->request->getPost('title') :null;
			$content->contents = $this->request->getPost('contents') ? trim($this->request->getPost('contents')) :null;
			$content->linkname = $this->request->getPost('linkname') ? $this->request->getPost('linkname') :null;
			$content->logo = $this->request->getPost('logo') ? $this->request->getPost('logo') :null;
			$content->cityid 	= $this->request->getPost('cityid') ? $this->request->getPost('cityid') : 0;
			$content->url 	= $this->request->getPost('url') ? $this->request->getPost('url') : null;
			$content->ord 	= (int) $this->request->getPost('ord');
			$content->status 	= 3;
			
			if($content->save()){
				$this->flashSession->success("修改成功！");
				$this->redirect('content/index?nid='.$content->nid);					
			}else{
				foreach($content->getMessages() as $message){
					echo $message,"\n";
				}
				exit;
				$this->redirect('content/edit?id='.$this->request->getPost('id'));
			}
			
		}	
	}

	public function delAction(){

		if($this->request->isGet()){
			$content = Content::findFirst($this->request->get('id'));

			$content->status = 2;

			if($content->save()){
				$this->flashSession->success("删除成功！");	
						
			}else{

				foreach($model->getMessages() as $message){
					echo $message,"\n";
				}
				exit;
			}	
		}
		$nid = isset($_GET['nid']) ? $_GET['nid'] : 1;
		$this->redirect('content/index?nid='.$nid);	
	}

	public function delAllAction(){
		if($this->request->isAjax()){
			$sql = "UPDATE Content SET status = 2 WHERE id IN (".implode(',',$this->request->getPost('ids')).")";
			echo $this->modelsManager->executeQuery($sql)->success();
		}		
	}

	public function uploadAction(){

		if($this->request->hasFiles() && !$this->request->getUploadedFiles()[0]->getError()){

			foreach ($this->request->getUploadedFiles() as $file) {

				$logo = './images/logo/'.mt_rand(0,9999).time().mt_rand(0,9999).'.jpg';

                $file->moveTo($logo);
            }

            echo $logo;            
		}

	}

	public function getAreaAction(){
		if($this->request->isAjax()){
			$areas = Areas::find('cityid = '.$this->request->getPost('cityid'));

			$result = array();
			foreach($areas as $area){
				$result[$area->areaid] = $area->area;
			}

			echo json_encode($result);
		}
	}

	public function mainAction(){
		
	}


}