<?php

// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');
Yii::setPathOfAlias('adminLTE', dirname(__FILE__).'/../../themes/adminLTE');
// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'Vida Animal',
	'theme'=>'adminLTE',
	'language'=>'es',
  	'sourceLanguage'=>'en',
	// preloading 'log' component
	//'preload'=>array('log'),
	'preload'=>array('log', 'yiibooster'),

	// autoloading model and component classes
	'import'=>array(
		'application.models.*',
		'application.components.*',
		'application.modules.cruge.components.*',
		'application.modules.cruge.extensions.crugemailer.*',
	),

	'modules'=>array(
		// uncomment the following to enable the Gii tool

		'gii'=>array(
			'generatorPaths' => array('booster.gii'),
			'class'=>'system.gii.GiiModule',
			'password'=>'arc1030q',
			// If removed, Gii defaults to localhost only. Edit carefully to taste.
			'ipFilters'=>array('127.0.0.1','::1'),
		),

		'backup',

		'cruge'=>array(
				'tableprefix'=>'cruge_',

				// para que utilice a protected.modules.cruge.models.auth.CrugeAuthDefault.php
				//
				// en vez de 'default' pon 'authdemo' para que utilice el demo de autenticacion alterna
				// para saber mas lee documentacion de la clase modules/cruge/models/auth/AlternateAuthDemo.php
				//
				'availableAuthMethods'=>array('default'),

				//'availableAuthModes'=>array('username','email'),
				'availableAuthModes'=>array('username'),
                                // url base para los links de activacion de cuenta de usuario
				'baseUrl'=>'http://coco.com/',

				 // NO OLVIDES PONER EN FALSE TRAS INSTALAR
				 'debug'=>false,
				 'rbacSetupEnabled'=>false,
				 'allowUserAlways'=>false,

				// MIENTRAS INSTALAS..PONLO EN: false
				// lee mas abajo respecto a 'Encriptando las claves'
				//
				'useEncryptedPassword' => false,

				// Algoritmo de la función hash que deseas usar
				// Los valores admitidos están en: http://www.php.net/manual/en/function.hash-algos.php
				'hash' => 'md5',

				// Estos tres atributos controlan la redirección del usuario. Solo serán son usados si no
				// hay un filtro de sesion definido (el componente MiSesionCruge), es mejor usar un filtro.
				//  lee en la wiki acerca de:
                                //   "CONTROL AVANZADO DE SESIONES Y EVENTOS DE AUTENTICACION Y SESION"
                                //
				// ejemplo:
				//		'afterLoginUrl'=>array('/site/welcome'),  ( !!! no olvidar el slash inicial / )
				//		'afterLogoutUrl'=>array('/site/page','view'=>'about'),
				//
				'afterLoginUrl'=>null,
				'afterLogoutUrl'=>null,
				'afterSessionExpiredUrl'=>null,

				// manejo del layout con cruge.
				//
				'loginLayout'=>'//layouts/column2',
				'registrationLayout'=>'//layouts/column2',
				'activateAccountLayout'=>'//layouts/column2',
				'editProfileLayout'=>'//layouts/column2',
				// en la siguiente puedes especificar el valor "ui" o "column2" para que use el layout
				// de fabrica, es basico pero funcional.  si pones otro valor considera que cruge
				// requerirá de un portlet para desplegar un menu con las opciones de administrador.
				//
				'generalUserManagementLayout'=>'ui',

				// permite indicar un array con los nombres de campos personalizados,
				// incluyendo username y/o email para personalizar la respuesta de una consulta a:
				// $usuario->getUserDescription();
				'userDescriptionFieldsArray'=>array('email'),

			),

	),

	// application components
	'components'=>array(

		'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>true,
		),

		'yiibooster' => array(
			'class' => 'ext.yiibooster.components.Booster',
			'responsiveCss' => true,
		),

		//  IMPORTANTE:  asegurate de que la entrada 'user' (y format) que por defecto trae Yii
		//               sea sustituida por estas a continuación:
		//
		'user'=>array(
			'allowAutoLogin'=>true,
			'class' => 'application.modules.cruge.components.CrugeWebUser',
			'loginUrl' => array('/cruge/ui/login'),
		),
		'authManager' => array(
			'class' => 'application.modules.cruge.components.CrugeAuthManager',
		),
		'crugemailer'=>array(
			'class' => 'application.modules.cruge.components.CrugeMailer',
			'mailfrom' => 'email-desde-donde-quieres-enviar-los-mensajes@xxxx.com',
			'subjectprefix' => 'Tu Encabezado del asunto - ',
			'debug' => true,
		),


		'session' => array(

			'class' => 'CDbHttpSession',

			'timeout' => 216000,

		),




		'format' => array(
			'datetimeFormat'=>'d-M-Y',
		),
		// uncomment the following to enable URLs in path-format

		'urlManager'=>array(
			'urlFormat'=>'path',
			'rules'=>array(
				'<controller:\w+>/<id:\d+>'=>'<controller>/view',
				'<controller:\w+>/<action:\w+>/<id:\d+>'=>'<controller>/<action>',
				'<controller:\w+>/<action:\w+>'=>'<controller>/<action>',
			),
		),

		'ePdf' => array(
			'class'			=> 'ext.yii-pdf.EYiiPdf',
		 'params'		=> array(
			 'mpdf'	   => array(
				 'librarySourcePath' => 'application.vendors.mpdf.*',
				 'constants'			=> array(
					 '_MPDF_TEMP_PATH' => Yii::getPathOfAlias('application.runtime'),
				 ),
				 'class'=>'mpdf', // the literal class filename to be loaded from the vendors folder.
				 /*'defaultParams'	  => array( // More info: http://mpdf1.com/manual/index.php?tid=184
					 'mode'				=> '', //  This parameter specifies the mode of the new document.
					 'format'			=> 'A4', // format A4, A5, ...
					 'default_font_size' => 0, // Sets the default document font size in points (pt)
					 'default_font'		=> '', // Sets the default font-family for the new document.
					 'mgl'				=> 15, // margin_left. Sets the page margins for the new document.
					 'mgr'				=> 15, // margin_right
					 'mgt'				=> 16, // margin_top
					 'mgb'				=> 16, // margin_bottom
					 'mgh'				=> 9, // margin_header
					 'mgf'				=> 9, // margin_footer
					 'orientation'		=> 'P', // landscape or portrait orientation
				 )*/
			 ),
			 'HTML2PDF' => array(
				 'librarySourcePath' => 'application.vendors.html2pdf.*',
				 'classFile'			=> 'html2pdf.class.php', // For adding to Yii::$classMap
				 /*'defaultParams'	  => array( // More info: http://wiki.spipu.net/doku.php?id=html2pdf:en:v4:accueil
					 'orientation' => 'P', // landscape or portrait orientation
					 'format'	  => 'A4', // format A4, A5, ...
					 'language'	  => 'en', // language: fr, en, it ...
					 'unicode'	  => true, // TRUE means clustering the input text IS unicode (default = true)
					 'encoding'	  => 'UTF-8', // charset encoding; Default is UTF-8
					 'marges'	  => array(5, 5, 5, 8), // margins by default, in order (left, top, right, bottom)
				 )*/
			 )
		 ),
 ),




		// database settings are configured in database.php
		'db'=>require(dirname(__FILE__).'/database.php'),

		'errorHandler'=>array(
			// use 'site/error' action to display errors
			'errorAction'=>YII_DEBUG ? null : 'site/error',
		),

		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error, warning',
				),
				// uncomment the following to show log messages on web pages
/*
				array(
					'class'=>'CWebLogRoute',
				),
*/
			),
		),

	),

	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']
	'params'=>array(
		// this is used in contact page
		'adminEmail'=>'webmaster@example.com',
		'siglas'=>'VA',
		'titutlo'=>'Vida Animal',
	),
);
