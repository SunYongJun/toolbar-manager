<?php

	try{
	header("content-type:text/html;charset=utf-8");

	$di = new \Phalcon\DI\FactoryDefault();

	$config = include __DIR__ . "/../app/config/config.php";

	$loader = new \Phalcon\Loader();

	$eventsManager = new \Phalcon\Events\Manager();



	$connection = new \Phalcon\Db\Adapter\Pdo\Mysql(array(
	        "host" => $config->database->host,

	        "username" => $config->database->username,

	        "password" => $config->database->password,

	        "dbname" => $config->database->dbname,

	        "charset" => $config->database->charset
	));

	$logger = new \Phalcon\Logger\Adapter\File("../app/logs/db.log");

	$eventsManager->attach(
	    'db',
	    function ($event, $connection) use ($logger) {
	        if ($event->getType() == 'beforeQuery') {
	            $statement = $connection->getSQLStatement();

                $logger->log($statement);
	        }

	    }
	);

	$connection->setEventsManager($eventsManager);

	$di->set('db', $connection);



	$loader->registerDirs(
	    array(
	        $config->application->controllersDir,
	        $config->application->pluginsDir,
	        $config->application->libraryDir,
	        $config->application->modelsDir,
	    )
	);
	$loader->setEventsManager($eventsManager);
	$loader->register();



	$di->set('session', function(){

	    $session = new Phalcon\Session\Adapter\Files();

	    $session->start();

	    return $session;
	});

	$di->set('view', function () use ($config) {

		$view = new \Phalcon\Mvc\View();

		$view->setViewsDir($config->application->viewsDir);

	    $view->registerEngines(array(
	        ".volt" => 'voltService'
	    ));

		return $view;

	}, true);

	$di->set('voltService', function($view, $di) use ($config){

	    $volt = new \Phalcon\Mvc\View\Engine\Volt($view, $di);

	    $volt->setOptions(array(
	        "compiledPath" => $config->application->tmpl,
	        "compiledExtension" => ".compiled"
	    ));

	    return $volt;
	});


    //设置URL
    $di->set('url', function(){

        $url = new \Phalcon\Mvc\Url();

        $url->setBaseUri('/ToolBar/');

        return $url;
    });

     $di->set('dispatcher', function() use ($di) {

	    //Obtain the standard eventsManager from the DI
	    $eventsManager = $di->getShared('eventsManager');

	    //Instantiate the Security plugin
	    $security = new Security($di);

	    //Listen for events produced in the dispatcher using the Security plugin
	    $eventsManager->attach('dispatch', $security);

	    $dispatcher = new Phalcon\Mvc\Dispatcher();

	    //Bind the EventsManager to the Dispatcher
	    $dispatcher->setEventsManager($eventsManager);

	    return $dispatcher;
	});

     $di->set('crypt',function() {

		$crypt=new Phalcon\Crypt();

		$crypt->setKey('#$^J9s&j*d');//设置私有加密键

		return $crypt;

	});


	$application = new \Phalcon\Mvc\Application($di);
	echo $application->handle()->getContent();
} catch (\Exception $e) {
	echo $e->getMessage();
}

