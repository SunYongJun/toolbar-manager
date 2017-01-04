<?php
namespace Admin\Models;
/**
	* 内容
	* @author 孙永军
*/

class Content extends \Phalcon\Mvc\Model {

	public function initialize(){
		$this->belongsTo("nid","Admin\Models\Nav","id",array('alias'=>'Nav'));
		$this->hasOne('cityid','Admin\Models\Cities','cityid',array('alias'=>'Cities'));
	}

	public function getSource(){
		return "tb_content";
	}	

}