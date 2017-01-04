<?php

namespace Home\Models;

use Phalcon\Mvc\Model;
/**
	* User 
*/

class Base extends Model
{	

	public function getSource(){
		return 'phc_'.strtolower(str_replace('Home\Models\\','',get_class($this)));		
	}
}