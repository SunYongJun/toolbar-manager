<?php

namespace Engine;

use Phalcon\DI;
use Phalcon\Events\Manager as EventsManager;
use Phalcon\Mvc\Application as PhalconApplication;
use Phalcon\Registry;
use Phalcon\Config;

use Plugins\Security;
use Phalcon\Mvc\Dispatcher;

class Application extends PhalconApplication{
    const
        /**
         * Default module.
         */
        SYSTEM_DEFAULT_MODULE = 'home';

	use ApplicationInitialization;

	/**
     * Application configuration.
     *
     * @var Config
     */
    protected $_config;

    private $_config_path = '/app/config/config.php';

    /**
     * Constructor.
     */

    private $_loaders =
        [
            'normal' => [
                'environment',
                'cache',
                'annotations',
                'database',
                'router',
                'session',
                'flash',
                'engine'
            ],
            
        ];

    public function __construct()
    {
        /**
         * Create default DI.
         */
        $di = new DI\FactoryDefault();

        /**
         * Get config.
         */
        $this->_config = require ROOT_PATH.$this->_config_path;

        
        $registry = new Registry();

        $registry->modules =  $this->_config->modules->toArray();

        $registry->directories = (object)[
            'engine' => ROOT_PATH . '/app/engine/',
            'modules' => ROOT_PATH . '/app/modules/',
            'plugins' => ROOT_PATH . '/app/plugins/',
            'widgets' => ROOT_PATH . '/app/widgets/',
            'libraries' => ROOT_PATH . '/app/libraries/'
        ];

        $di->set('registry', $registry);

        // Store config in the DI container.
        $di->setShared('config', $this->_config);
        parent::__construct($di);
    }

    /**
     * Runs the application, performing all initializations.
     *
     * @param string $mode Mode name.
     *
     * @return void
     */
    public function run($mode = 'normal'){
        if (empty($this->_loaders[$mode])) {
            $mode = 'normal';
        }

        // Set application main objects.
        $di = $this->_dependencyInjector;
        $di->setShared('app', $this);
        $config = $this->_config;
        $eventsManager = new EventsManager();
        $this->setEventsManager($eventsManager);

        // Init base systems first.
        $this->_initLogger($di, $config);
        $this->_initLoader($di, $config, $eventsManager);

        $this->_attachEngineEvents($eventsManager, $config);

        // Init services and engine system.
        foreach ($this->_loaders[$mode] as $service) {
            $serviceName = ucfirst($service);
            $eventsManager->fire('init:before' . $serviceName, null);
            $result = $this->{'_init' . $serviceName}($di, $config, $eventsManager);
            $eventsManager->fire('init:after' . $serviceName, $result);
        }

        $di->setShared('eventsManager', $eventsManager);
    }

    /**
     * Get application output.
     *
     * @return string
     */
    public function getOutput()
    {
        // return $this->handle()->getContent();
        try{
        	echo $this->handle()->getContent();
		} catch (\Exception $e) {
			echo $e->getMessage();
		}
    }


    /**
     * Init modules and register them.
     *
     * @param array $modules Modules bootstrap classes.
     * @param null  $merge   Merge with existing.
     *
     * @return $this
     */
    public function registerModules(array $modules, $merge = null)
    {
        return parent::registerModules($modules, $merge);
        
    }


}