<?php
namespace Admin\Controllers;
/**
	* 数据统计
	* @author 孙永军
*/ 

class StatController extends ControllerBase{

	function indexAction(){

		$date = "";

		if($this->request->isPost()){
			$date .= " WHERE time >= ".date('Ymd',strtotime($this->request->getPost('startDate'))) * 100 ." AND time < ".(date('Ymd',strtotime($this->request->getPost('endDate'))) + 1)*100;
		}

		$sql = "SELECT *,SUM(click) sclick,FLOOR(time/100) day FROM Admin\Models\Stat {$date} GROUP BY type,FLOOR(time/100)";

		$result = $this->modelsManager->executeQuery($sql);

		$byDate = [];

		foreach($result as $v){
			$byDate[date('Y-m-d',strtotime($v->day))][$v->stat->type] = $v->sclick;
		}

		$this->view->setVar('byDate',$byDate);

		$this->view->setVar('result',$result);
	}
	
}