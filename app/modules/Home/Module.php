<?php

namespace Home;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\View;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Mvc\ModuleDefinitionInterface;


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
            'Home\Controllers' => __DIR__ . '/controllers/',
            'Home\Models' => __DIR__ . '/models/',
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

        /**
         * Setting up the view component
         */
       /* $di['view'] = function () {
            $view = new View();
            $view->setViewsDir(__DIR__ . '/views/');

            return $view;
        };*/
       

        $di['view'] = function () use ($config) {

            $view = new View();

            $view->setViewsDir($config->home->viewsDir);

            $view->registerEngines(array(
                ".volt" => 'voltService'
            ));

            return $view;

        };

        $di['voltService'] = function($view, $di) use ($config){

            $volt = new Volt($view, $di);

            $volt->setOptions(array(
                "compiledPath" => $config->home->tmplDir,
                "compiledExtension" => ".compiled"
            ));

            return $volt;
        };

        /**
         * Database connection is created based in the parameters defined in the configuration file
         */
        $di['db'] = function () use ($config) {
            return new DbAdapter($config->database->toArray());
        };
    }
}
