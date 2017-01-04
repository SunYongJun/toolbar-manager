<?php

/**
    * 登录登出
    * @author 孙永军
*/

namespace Admin\Controllers;

use Admin\Models\User;


class loginController extends ControllerBase{

    public function initialize(){

    }

	private function _registerSession($user)
    {
        $this->session->set('user', array(
            'id'            => $user->id,
            'email'         => $user->email,
            'provinceid'    => $user->provinceid,
            'auth'          => $user->auth,
            'mtime'         => $user->mtime
        ));
    }

	public function indexAction(){
        if($this->cookies->has('remember_me')){
            $cookies = $this->cookies->get('remember_me')->getValue();
            $cookies = json_decode(preg_replace("/{(.*?)}(.*)/", '{\\1}', $cookies));
            $this->view->setVar('user',$cookies);
        }
	}

	public function checkAction(){

		if ($this->request->isPost()) {		

			$email = $this->request->getPost('email', 'email');
            $password = $this->request->getPost('password');
 
            $password = sha1(trim($password));

            //Find for the user in the database
            $user = User::findFirst("email='$email' AND password='$password'");
            if ($user != false) {

                $this->_registerSession($user);

                if($this->request->getPost('remember_me')){
                    $this->cookies->set(
                        'remember_me',
                        json_encode(array(
                            'email'=>$this->request->getPost('email', 'email'),
                            'password'=>$this->request->getPost('password')
                            )),
                        time() + 10 * 3600 * 24 
                        )->send();
                }

                $user->mtime = time();
                $user->save();

                $this->flashSession->success('Welcome '.$user->email);

                //Forward to the invoices controller if the user is valid
                $this->redirect('main/index');
            }
        }

        $this->flashSession->error('用户名或密码错误！');
        return $this->redirect('login/index');
	}

    public function logoutAction(){
        $this->session->destroy();
        $this->redirect('login/index');
    }


}