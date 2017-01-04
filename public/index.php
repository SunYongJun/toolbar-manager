<?php

header('Content-type:text/html;charset=utf-8');
date_default_timezone_set("PRC");

if (!defined('ROOT_PATH')) {
    define('ROOT_PATH', dirname(dirname(__FILE__)));
}
if (!defined('PUBLIC_PATH')) {
    define('PUBLIC_PATH', dirname(__FILE__));
}

require_once ROOT_PATH . "/app/config/config.php";
require_once ROOT_PATH . "/app/engine/ApplicationInitialization.php";
require_once ROOT_PATH . "/app/engine/Application.php";

$application = new Engine\Application();

$application->run();
echo $application->getOutput();