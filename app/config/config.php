<?php

return new \Phalcon\Config(array(
    'debug' => true,
    'database' => array(
        'host'        => '121.40.95.240',
        'username'    => 'uniskad',
        'password'    => 'usk@2014!@#',
        'dbname'      => 'ssp',
        'port'        => 3306,
        'charset'   => 'utf8'
    ),
    'application' => array(
        'pluginsDir'     => __DIR__.'/../plugins/',
        'libraryDir'     => __DIR__.'/../library/', 
        'aclDir'         => __DIR__.'/../plugins/acl.data',
        'baseUri'        => '/'
    ),
    'metadata' =>
    array (
        'adapter' => 'Files',
        'metaDataDir' => ROOT_PATH . '/app/var/cache/metadata/',
    ),
    'logger' =>
        array (
            'enabled' => true,
            'path' => ROOT_PATH.'/app/logs/stage.log',  
            'format' => '[%date%][%type%] %message%',
        ),
    'admin' => array(
        'viewsDir'          => ROOT_PATH.'/app/modules/Admin/views/',
        'tmplDir'           => ROOT_PATH.'/app/modules/Admin/tmpl/'
        ),
    'home' => array(
        'viewsDir'          => ROOT_PATH.'/app/modules/Home/views/',
        'tmplDir'           => ROOT_PATH.'/app/modules/Home/tmpl/'
        ),
    'modules' => array(
        'Admin',
        'Home'
    ),
    'session' =>
        array (
           'adapter' => 'Files',
           'uniqueId' => 'PhalconEye_',
           'crypt' => '#$^J9s&j*d'
        ),
    'cache' =>
        array (
            'status'=>true,
            'lifetime' => '86400',
            'prefix' => 'pe_',
            'adapter' => 'File',
            'cacheDir' => ROOT_PATH . '/app/var/cache/data/',
        ),
    'metadata' =>
        array (
            'adapter' => 'Files',
            'metaDataDir' => ROOT_PATH . '/app/var/cache/metadata/',
        ),
));
