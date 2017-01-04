<?php

namespace Admin;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\View;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Mvc\ModuleDefinitionInterface;
use Phalcon\Mvc\View\Engine\Volt;
use Phalcon\Mvc\Dispatcher;
use Plugins\Security;


class Module implements ModuleDefinitionInterface
{
    /**
     * Registers an autoloader related to the module
     *
     * @param DiInterface $di
     */
    public function registerAutoloaders(DiInterface $di = null)
    {

        $loader = new Loader();

        $loader->registerNamespaces(array(
            'Admin\Controllers' => __DIR__ . '/Controllers/',
            'Admin\Models' => __DIR__ . '/Models/',
        ));

        $loader->register();
    }

    /**
     * Registers services related to the module
     *
     * @param DiInterface $di
     */
    public function registerServices(DiInterface $di)
    {
        /**
         * Read configuration
         */
        $config = include ROOT_PATH . "/app/config/config.php";

        $di['view'] = function () use ($config) {

            $view = new View();

            $view->setViewsDir($config->admin->viewsDir);

            $view->registerEngines(array(
                ".volt" => 'voltService'
            ));

            return $view;

        };

        $di['voltService'] = function($view, $di) use ($config){

            $volt = new Volt($view, $di);

            $volt->setOptions(array(
                "compiledPath" => $config->admin->tmplDir,
                "compiledExtension" => ".compiled"
            ));

            return $volt;
        };


        $di->set('url', function(){

            $url = new \Phalcon\Mvc\Url();

            $url->setBaseUri('/admin/');

            return $url;
        });

        $di->set('dispatcher', function() use ($di) {

            //Obtain the standard eventsManager from the DI
            $eventsManager = $di->getShared('eventsManager');

            //Instantiate the Security plugin
            $security = new Security($di);

            //Listen for events produced in the dispatcher using the Security plugin
            $eventsManager->attach('dispatch', $security);

            $dispatcher = new Dispatcher();

            //Bind the EventsManager to the Dispatcher
            $dispatcher->setEventsManager($eventsManager);

            return $dispatcher;
        });

        

    }
}
