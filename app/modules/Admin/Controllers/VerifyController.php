<?php
namespace Admin\Controllers;
/**
	* 审核控制
	* @author 孙永军
*/ 

use Admin\Models\Content;

class VerifyController extends ControllerBase{
	function indexAction(){

		$cond = "status = 3";

		$result = Content::find($cond);

		$this->view->setVar("result",$result);

	}

	public function execAction(){
		
			if($this->request->isPost() && $this->request->getPost('ids')){
			
				$sql = "UPDATE Admin\Models\Content SET status = {$this->request->get('status')} WHERE id IN (".implode(',',$this->request->getPost('ids')).")";
				$this->modelsManager->executeQuery($sql);

			}elseif($this->request->isGet()){

				$content = Content::findFirst($this->request->get('id'));
				$content->status = $this->request->get('status');
				$content->save();
			}


		$this->redirect('Verify/index');
	}


}