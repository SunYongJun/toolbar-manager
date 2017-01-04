<?php

namespace Home\Models;

use Home\Models\Base as Base;
/**
	* User 
*/

class User extends Base
{	
	/**
		*@Primary interger  primaryKey
	*/
	public $id;

	/**
		* @Column varchar  
	*/
	public $email;

	/**
		* @Column varchar  
	*/
	public $name;

	/**
		* @Column varchar  
	*/
	public $pwd;


}