<?php
/**
	* 用户控制器
	* @author 孙永军
*/ 

namespace Home\Controllers;

use Home\Controllers\Base;
use Home\Models\User;

class UserController  extends Base{
	function indexAction(){
		header('Content-type:text/html;charset=utf-8');
		$user = User::find();

		foreach($user as $v){
			echo $v->id.'<br / >'.$v->name.'<br / >'.$v->email.'<hr / >';
		}
	}
	function insertAction(){

		echo '--------user-------------';
		
		$user = new User;
		$arr = ['夸父','义和','帝俊','太一','刑天','伏羲','女娲','鸿钧'];
		$user -> name = $arr[mt_rand(0,7)];
		$user -> email = 'admin@qq.com';
		$user -> pwd = md5('');
		echo $user -> create();
	}
}