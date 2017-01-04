<?php


namespace Engine;


use Phalcon\Annotations\Adapter\Memory as AnnotationsMemory;
use Phalcon\Cache\Frontend\Data as CacheData;
use Phalcon\Cache\Frontend\Output as CacheOutput;
use Phalcon\Db\Adapter;
use Phalcon\Db\Adapter\Pdo;
use Phalcon\Db\Profiler as DatabaseProfiler;
use Phalcon\DI;
use Phalcon\Events\Manager as EventsManager;
use Phalcon\Flash\Direct as FlashDirect;
use Phalcon\Flash\Session as FlashSession;
use Phalcon\Loader;
use Phalcon\Logger\Adapter\File;
use Phalcon\Logger;
use Phalcon\Logger\Formatter\Line as FormatterLine;
use Phalcon\Mvc\Application as PhalconApplication;
use Phalcon\Mvc\Model\Manager as ModelsManager;
use Phalcon\Mvc\Model\MetaData\Strategy\Annotations as StrategyAnnotations;
use Phalcon\Mvc\Model\Transaction\Manager as TxManager;
use Phalcon\Mvc\Router\Annotations as RouterAnnotations;
use Phalcon\Mvc\Router;
use Phalcon\Mvc\Url;
use Phalcon\Session\Adapter as SessionAdapter;
use Phalcon\Session\Adapter\Files as SessionFiles;
use Phalcon\Crypt;
use Phalcon\Mvc\View;



trait ApplicationInitialization
{
    /**
     * Init logger.
     *
     * @param DI     $di     Dependency Injection.
     * @param Config $config Config object.
     *
     * @return void
     */
    protected function _initLogger($di, $config)
    {
        if ($config->logger->enabled) {
            $di->set(
                'logger',
                function ( $format = null) use ($config) {
                    $logger = new File($config->logger->path);
                    $formatter = new FormatterLine(($format ? $format : $config->application->logger->format));
                    $logger->setFormatter($formatter);

                    return $logger;
                },
                false
            );
        }
    }

    /**
     * Init loader.
     *
     * @param DI            $di            Dependency Injection.
     * @param Config        $config        Config object.
     * @param EventsManager $eventsManager Event manager.
     *
     * @return Loader
     */
    protected function _initLoader($di, $config, $eventsManager)
    {
        // Add all required namespaces and modules.
        $registry = $di->get('registry');
        $namespaces = [];
        $view = new View();           

        foreach ($registry->modules as $module) {
            $moduleName = ucfirst($module);
            $namespaces[$moduleName] = $registry->directories->modules . $moduleName;
            $bootstraps[strtolower($module)] = [
                'className' => $moduleName.'\\Module',
                'path' => ROOT_PATH.'/app/modules/'.$moduleName.'/Module.php'
            ] ;
        }

        $namespaces['Engine'] = $registry->directories->engine;
        $namespaces['Plugin'] = $registry->directories->plugins;
        $namespaces['Widget'] = $registry->directories->widgets;
        $namespaces['Library'] = $registry->directories->libraries;

        $loader = new Loader();
        $loader->registerNamespaces($namespaces);

        $loader->setEventsManager($eventsManager);

        $loader->register();

        $this->registerModules($bootstraps);
        // $di->set('loader', $loader);

        // return $loader;
    }


    /**
     * Init environment.
     *
     * @param DI     $di     Dependency Injection.
     * @param Config $config Config object.
     *
     * @return Url
     */
    protected function _initEnvironment($di, $config)
    {

        /**
         * The URL component is used to generate all kind of urls in the
         * application
         */
        /*$url = new Url();
        
        $url->setBaseUri($config->application->baseUri);
        $di->set('url', $url);

        return $url;*/
    }

    /**
     * Attach required events.
     *
     * @param EventsManager $eventsManager Events manager object.
     * @param Config        $config        Application configuration.
     *
     * @return void
     */
    protected function _attachEngineEvents($eventsManager, $config)
    {
        $events = [];
        $cache = [];
        foreach ($events as $item) {
            list ($class, $event) = explode('=', $item);
            if (isset($cache[$class])) {
                $object = $cache[$class];
            } else {
                $object = new $class();
                $cache[$class] = $object;
            }
            $eventsManager->attach($event, $object);
        }
    }

    /**
     * Init annotations.
     *
     * @param DI     $di     Dependency Injection.
     * @param Config $config Config object.
     *
     * @return void
     */
    protected function _initAnnotations($di, $config)
    {
        $di->set(
            'annotations',
            function () use ($config) {
                if (!$config->debug && isset($config->application->annotations)) {
                    $annotationsAdapter = '\Phalcon\Annotations\Adapter\\' . $config->application->annotations->adapter;
                    $adapter = new $annotationsAdapter($config->application->annotations->toArray());
                } else {
                    $adapter = new AnnotationsMemory();
                }

                return $adapter;
            },
            true
        );
    }

    /**
     * Init router.
     *
     * @param DI     $di     Dependency Injection.
     * @param Config $config Config object.
     *
     * @return Router
     */
    protected function _initRouter($di, $config)
    {        
        $modules = $di->get('registry')->modules;

        // Use the annotations router.
        $router = new RouterAnnotations(true);


        $defaultModuleName = ucfirst(Application::SYSTEM_DEFAULT_MODULE);
        $router->setDefaultModule(Application::SYSTEM_DEFAULT_MODULE);
        $router->setDefaultNamespace($defaultModuleName . '\Controllers');
        $router->setDefaultController("Index");
        $router->setDefaultAction("index");

        foreach($this->getModules() as $moduleName => $module){

            $namespace = str_replace('Module','Controllers', $module["className"]);
            $router->add('/'.$moduleName.'/:params', array(
                'namespace' => $namespace,
                'module' => $moduleName,
                'controller' => 'Index',
                'action' => 'index',
                'params' => 1
            ));
            $router->add('/'.$moduleName.'/', array(
                'namespace' => $namespace,
                'module' => $moduleName,
                'controller' => 'Index',
                'action' => 'index'
            ));
            $router->add('/'.$moduleName.'/:controller/:params', array(
                'namespace' => $namespace,
                'module' => $moduleName,
                'controller' => 1,
                'action' => 'index',
                'params' => 2
            ));
            $router->add('/'.$moduleName.'/:controller/:action/:params', array(
                'namespace' => $namespace,
                'module' => $moduleName,
                'controller' => 1,
                'action' => 2,
                'params' => 3
            ));
        }

        $di->set('router', $router);
        return $router;

    }

    /**
     * Init database.
     *
     * @param DI            $di            Dependency Injection.
     * @param Config        $config        Config object.
     * @param EventsManager $eventsManager Event manager.
     *
     * @return Pdo
     */
    protected function _initDatabase($di, $config, $eventsManager)
    {


        /** @var Pdo $connection */
        $connection = new \Phalcon\Db\Adapter\Pdo\Mysql(
            [
                "host" => $config->database->host,
                "port" => $config->database->port,
                "username" => $config->database->username,
                "password" => $config->database->password,
                "dbname" => $config->database->dbname,
                "charset"=>$config->database->charset
            ]
        );


        $logger = new \Phalcon\Logger\Adapter\File(ROOT_PATH."/app/logs/db.log");
        $profiler = new \Phalcon\Db\Profiler();

        $eventsManager->attach(
            'db',
            function ($event, $connection) use ($logger,$profiler) {
                if ($event->getType() == 'beforeQuery') {
                    $statement = $connection->getSQLStatement();
                    if ($logger) {
                        $logger->log($statement, Logger::INFO);
                    }                    
                }

                if ($event->getType() == 'afterQuery') {
                    // Stop the active profile.
                    if ($profiler) {
                        // $profiler->stopProfile();
                    }
                }                
            }
        );

        /*if ($profiler && $di->has('profiler')) {
            $di->get('profiler')->setDbProfiler($profiler);
        }*/

        $connection->setEventsManager($eventsManager);

        $di->set('db', $connection);
       
        $di->set(
            'modelsManager',
            function () use ($config, $eventsManager) {
                $modelsManager = new ModelsManager();
                $modelsManager->setEventsManager($eventsManager);

                // Attach a listener to models-manager
                // $eventsManager->attach('modelsManager', new ModelAnnotationsInitializer());

                return $modelsManager;
            },
            true
        );

        /*$di->set(
            'modelsMetadata',
            function () use ($config) {
                if (!$config->debug && isset($config->application->metadata)) {
                    $metaDataConfig = $config->application->metadata;
                    $metadataAdapter = '\Phalcon\Mvc\Model\Metadata\\' . $metaDataConfig->adapter;
                    $metaData = new $metadataAdapter($config->application->metadata->toArray());
                } else {
                    $metaData = new \Phalcon\Mvc\Model\MetaData\Memory();
                }

                $metaData->setStrategy(new StrategyAnnotations());

                return $metaData;
            },
            true
        );*/

        return $connection;
    }

    /**
     * Init session.
     *
     * @param DI     $di     Dependency Injection.
     * @param Config $config Config object.
     *
     * @return SessionAdapter
     */
    protected function _initSession($di, $config)
    {
        if (!isset($config->application->session)) {
            $session = new SessionFiles();
        } else {
            $adapterClass = 'Phalcon\Session\Adapter\\' . $config->application->session->adapter;
            $session = new $adapterClass($config->application->session->toArray());
        }

        $session->start();
        $di->setShared('session', $session);

        $di->set('crypt',function() use ($config){

            $crypt=new Crypt();

            $crypt->setKey($config->session->crypt);//设置私有加密键

            return $crypt;

        });
        return $session;
    }

    /**
     * Init cache.
     *
     * @param DI     $di     Dependency Injection.
     * @param Config $config Config object.
     *
     * @return void
     */
    protected function _initCache($di, $config)
    {
        if($config->cache->status){
            // Get the parameters.
            $cacheAdapter = '\Phalcon\Cache\Backend\\' . $config->cache->adapter;
            $frontEndOptions = ['lifetime' => $config->cache->lifetime];
            $backEndOptions = $config->cache->toArray();
            $frontOutputCache = new CacheOutput($frontEndOptions);
            $frontDataCache = new CacheData($frontEndOptions);

            $cacheOutputAdapter = new $cacheAdapter($frontOutputCache, $backEndOptions);
            $di->set('viewCache', $cacheOutputAdapter, true);
            $di->set('cacheOutput', $cacheOutputAdapter, true);

            $cacheDataAdapter = new $cacheAdapter($frontDataCache, $backEndOptions);
            $di->set('cacheData', $cacheDataAdapter, true);
            $di->set('modelsCache', $cacheDataAdapter, true);
        }
    }

    /**
     * Init flash messages.
     *
     * @param DI $di Dependency Injection.
     *
     * @return void
     */
    protected function _initFlash($di)
    {
        $flashData = [
            'error' => 'alert alert-danger',
            'success' => 'alert alert-success',
            'notice' => 'alert alert-info',
        ];

        $di->set(
            'flash',
            function () use ($flashData) {
                $flash = new FlashDirect($flashData);

                return $flash;
            }
        );

        $di->set(
            'flashSession',
            function () use ($flashData) {
                $flash = new FlashSession($flashData);

                return $flash;
            }
        );
    }

    /**
     * Init engine.
     *
     * @param DI $di Dependency Injection.
     *
     * @return void
     */
    protected function _initEngine($di)
    {
        
        $di->setShared(
            'transactions',
            function () {
                return new TxManager();
            }
        );

    }

    
    
}