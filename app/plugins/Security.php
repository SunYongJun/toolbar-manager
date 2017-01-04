<?php

/**
	* 权限控制
	* @author 孙永军
*/


namespace Plugins;

use Phalcon\Mvc\User\Plugin;
use Phalcon\Events\Event;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Acl\Adapter\Memory;
use Phalcon\Acl;
use Phalcon\Acl\Role;
use Phalcon\Acl\Resource;
use Admin\Models\AuthRule;
use Admin\Models\AuthGroup;

class Security extends Plugin{
	public function beforeDispatch(Event $event, Dispatcher $dispatcher) {
		if($dispatcher->getControllerName() != 'main' && $dispatcher->getControllerName() != 'login' && $dispatcher->getControllerName() != 'index'){

			if (!is_file(__DIR__.'/acl.data')) {

			    $acl = new Memory();

			    $acl->setDefaultAction(Acl::DENY);

			    $resources = AuthRule::find('status = 1');

			    foreach($resources as $value){
			    	$resource[$value->controller][] = $value->action;
			    }

			    foreach($resource as $k=>$v){
			    	
			    	$acl->addResource(new Resource($k), $v);
			    }

			    $auth = AuthGroup::find('status = 1');

			    foreach($auth as $v){
			    	$acl->addRole(new Role($v->id));
			    	$rules = $v->getRules();
			    	foreach($rules as $vo){
			    		$acl->allow($v->id,$vo->controller,$vo->action);
			    	}

			    }

			    // 保存实例化的数据到文本文件中
			    file_put_contents(__DIR__.'/acl.data', serialize($acl));
			} else {

			     // 返序列化
			     $acl = unserialize(file_get_contents(__DIR__.'/acl.data'));
			}	  

			if(!$acl->isAllowed($this->session->get('user')['auth'] , ucfirst($dispatcher->getControllerName()) , $dispatcher->getActionName())){
		    	/*$dispatcher->forward(
		            array(
		                'controller' => 'main',
		                'action' => 'right'
		            )
		        );*/
				echo '权限拒绝';
		        return false;
		    }
		}

	}

	
	
}