<?php
namespace Admin\Controllers;

class TestController extends ContentController{
	public function uploadAction(){
		var_dump($_FILES);
		if($_FILES['logo']){
			$path = '/images/logo';
			if(!is_dir($path)){
				mkdir($path,'0777',true);
			}
			$file = $path.'/'.mt_rand(1000,9999).time().mt_rand(1000,9999).'.jpg';
			move_uploaded_file($_FILES['logo']['tmp_name'],$file);
			echo $file;
		}

	}

	public function testAction(){
		var_dump($GLOBALS['config']->application->aclDir);
		var_dump(get_class_methods($this));
		var_dump($this->getDI());
		var_dump(get_class_methods($this->getDI()));
	}
}