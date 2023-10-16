<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="language" content="es" />
  <?php #echo CHtml::encode(isset($this->parametros['titulo'])?$this->parametros['titulo']:$this->pageTitle); ?>
  <title><?php echo CHtml::encode($this->pageTitle); ?></title>
  <link id="favicon" rel="shortcut icon" href="<?php echo Yii::app()->baseUrl."/images/logo_icono.png"; ?>" type="image/png" />
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css"> -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/dist/css/font-awesome-4.7.0/css/font-awesome.min.css">
  <!-- Ionicons
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">-->
  <!-- Theme style -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/dist/css/AdminLTE.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/dist/css/skins/_all-skins.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/iCheck/flat/purple.css">
  <!-- Morris chart -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/morris/morris.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <!-- Date Picker -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/datepicker/datepicker3.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/daterangepicker/daterangepicker.css">
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
  <!-- fullCalendar 2.2.5-->
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/fullcalendar/fullcalendar.min.css">
  <link rel="stylesheet" href="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/fullcalendar/fullcalendar.print.css" media="print">
  <link rel="stylesheet" href="<?php echo Yii::app()->baseUrl; ?>/css/estilo.css">





  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  <?php Yii::app()->clientScript->registerCoreScript('jquery'); ?>
</head>
<body class="hold-transition skin-purple sidebar-mini">

<?php if (Yii::app()->user->isGuest){ ?>
    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row">

         <?php echo $content; ?>
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
<?php }
else
{ ?>
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="<?php echo Yii::app()->getBaseUrl(); ?>" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b><?php echo Yii::app()->params['siglas']; ?></b></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b><?php echo Yii::app()->name; ?></b></span>
    </a>
    <?php // MENU NOTIFICACIONES ?>

    <?php
        //array_push($this->menu, array('label'=>'<i class="fa fa-user fa-fw"></i>'.Yii::app()->user->name,'url'=>array('')));

        $this->widget('adminLTE.widgets.CMenuTopNotificaciones',array(
                   'encodeLabel'=>false,
                   'items'=>$this->menu,
                ));


            ?>

  </header>
 <?php // MENU PRINCIPAL ?>

<?php
    $itemsAdminUser = array();
    if(Yii::app()->user->checkAccess('admin')){
        array_push($itemsAdminUser, array('label'=>'<i class="fa fa-users"></i> <span>Admin. Usuarios</span>', 'url'=>Yii::app()->user->ui->userManagementAdminUrl));
    }
    array_push($itemsAdminUser, array('label'=>'<i class="fa fa-ban fa-fw"></i><span>Cerrar Sesión</span>', 'url'=>Yii::app()->user->ui->logoutUrl, 'visible'=>!Yii::app()->user->isGuest));
?>
                <?php $this->widget('adminLTE.widgets.CMenuVertical',array(
                   'encodeLabel'=>false,
                   'activateParents'=>true,
                   'items'=>array(


                            array('label'=>'<i class="fa fa-book fa-fw"></i><span>Libro de Direcciones</span>', 'url'=>'#',

                            		'itemOptions'=>array('class'=>'treeview'),
                                     'submenuOptions'=>array('class'=>'treeview-menu'),
                                     'items'=>array(
                                        array('label'=>'<i class="glyphicon glyphicon-user"></i> <span>Clientes</span>', 'url'=>array('/cliente/admin')),
                                        array('label'=>'<i class="fa fa-map"></i> <span>Localidad</span>', 'url'=>array('/localidad/admin')),
                                        array('label'=>'<i class="fa fa-shield"></i> <span>Especie</span>','url'=>array('/especie/admin/')),
                                        array('label'=>'<i class="fa fa-podcast"></i> <span>Raza</span>','url'=>array('/raza/admin/')),

                                 )),
                            //array('label'=>'<i class="fa fa-th-large fa-fw"></i> Campos', 'url'=>array('/campo/index'), 'icons'=>'fa fa-dashboard fa-fw'),

                            array('label'=>'<i class="fa fa-newspaper-o"></i><span>Artículos</span> ', 'url'=>'#',
                            		'itemOptions'=>array('class'=>'treeview'),
                                     'submenuOptions'=>array('class'=>'treeview-menu'),
                                     'items'=>array(
                                        array('label'=>'<i class="glyphicon glyphicon-barcode"></i> <span>Productos</span>', 'url'=>array('/producto/admin')),
                                        array('label'=>'<i class="fa fa-print fa-fw"></i> <span>Imprimir Lista de Precios</span>', 'url'=>array('/producto/print')),
                                        array('label'=>'<i class="fa fa-tag"></i><span>Rubros</span>', 'url'=>array('/rubro/admin')),
                                        array('label'=>'<i class="fa fa-tags"></i><span>Sub-Rubros</span>', 'url'=>array('/subRubro/admin')),
                                        array('label'=>'<i class="fa fa-address-card"></i><span>Marca</span>', 'url'=>array('/marca/admin')),

                             )),

                             array('label'=>'<i class="fa fa-calculator"></i><span>Actualiza Precios</span> ', 'url'=>'#',
                             		'itemOptions'=>array('class'=>'treeview'),
                                      'submenuOptions'=>array('class'=>'treeview-menu'),
                                      'items'=>array(
                                         array('label'=>'<i class="fa fa-tag"></i><span>Actualiza por Rubro</span>', 'url'=>array('/producto/actualizaPreciosRubro')),
                                         array('label'=>'<i class="fa fa-tags"></i><span>Actualiza por Sub-Rubro</span>', 'url'=>array('/producto/actualizaPreciosSubRubro')),
                                         array('label'=>'<i class="fa fa-database"></i><span>Actualización Masiva</span>', 'url'=>array('/producto/actualizaPreciosMasivo')),

                              )),

                             array('label'=>'<i class="fa fa-plus"></i><span>Clínica</span> ', 'url'=>'#',
                             		'itemOptions'=>array('class'=>'treeview'),
                                      'submenuOptions'=>array('class'=>'treeview-menu'),
                                      'items'=>array(
                                         array('label'=>'<i class="fa fa fa-check-square-o"></i> <span>Consulta</span>', 'url'=>array('/consulta/create')),
                                         array('label'=>'<i class="fa fa-paw"></i> <span>Paciente</span>','url'=>array('/paciente/admin/')),


                              )),


                            array('label'=>'<i class="fa fa-user fa-fw"></i><span>Usuarios</span>', 'url'=>'#',
                                    'itemOptions'=>array('class'=>'treeview'),
                                     'submenuOptions'=>array('class'=>'treeview-menu'),
                                     'items'=>$itemsAdminUser
                                 ),

                            /*array('label'=>'Registrarse', 'url'=>array('/site/registro'), 'visible'=>Yii::app()->user->isGuest),
                            array('label'=>'Login', 'url'=>array('/site/login'), 'visible'=>Yii::app()->user->isGuest),
                            array('label'=>'Logout ('.Yii::app()->user->name.')', 'url'=>array('/site/logout'), 'visible'=>!Yii::app()->user->isGuest),
                            array('label'=>'<i class="fa fa-bar-chart-o fa-fw"></i> Reportes', 'url'=>'#', 'visible'=>Yii::app()->user->isGuest,
                                'submenuOptions'=>array('class'=>'nav nav-second-level'),
                                'items'=>array(
                                    array('label'=>'<i class="fa fa-print fa-fw"></i> Lista de Ventas','url'=>array('/equipo/')),
                                    array('label'=>'<i class="fa fa-refresh fa-fw"></i> Movimientos de Cereal', 'url'=>array('/torneo/')),
                            )),*/

                    ),

                )); ?>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1><?php #echo isset($this->parametros['titulo'])?$this->parametros['titulo']:'';  ?></h1>
      <?php if(isset($this->breadcrumbs)):?>
		<?php $this->widget('zii.widgets.CBreadcrumbs', array(
			'links'=>$this->breadcrumbs,
		)); ?><!-- breadcrumbs -->
	  <?php endif?>

    <?php // Muestro si ocurrio un error
                    if(($msgs=Yii::app()->user->getFlashes())!=null):?>
                            <?php foreach ($msgs as $type => $message):?>
                            <div class="alert alert-<?php echo $type;?> alert-dismissible">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    $pila                        <?php endforeach;?>
                    <?php endif;?>
    </section>
    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row">

         <?php echo $content; ?>
      </div>
      <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.0 <br />
    </div>
    <strong>Desarrollado por <a href="http://rzerbato.com.ar">Ricardo Zerbato</a></strong>
  </footer>

<?php } ?>

<!-- ./wrapper -->

<!-- jQuery 2.2.3 -->
<!--<script src="<?php #echo Yii::app()->theme->baseUrl; ?>/plugins/jQuery/jquery-2.2.3.min.js"></script>-->
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  //$.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.6 -->
<!--  Esto es lo que pincha los dialogs MODAL!!!
<script src="<?php # echo Yii::app()->theme->baseUrl; ?>/bootstrap/js/bootstrap.min.js"></script>
-->
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/morris/morris.js"></script>
<!-- Sparkline -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/dist/js/app.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<!--<script src="<?php# echo Yii::app()->theme->baseUrl; ?>/dist/js/pages/dashboard.js"></script>-->
<!-- AdminLTE for demo purposes -->
<script src="<?php echo Yii::app()->theme->baseUrl; ?>/dist/js/demo.js"></script>
<script src="<?php echo Yii::app()->baseUrl; ?>/js/jquery.backstretch.min.js"></script>
<?php
            $baseUrl = Yii::app()->baseUrl;
            $cs = Yii::app()->getClientScript();
            #$cs->registerScriptFile($baseUrl.'/js/AJAX-JQueryPhpJSON.js');
            $cs->registerScriptFile($baseUrl.'/js/jquery.blockUI.js');
        ?>
<script type="text/javascript">
  $('body').ready(function() {
  //console.log(sessionStorage.ocultarMenu);
    if(sessionStorage.ocultarMenu==='true'){
      $("[data-toggle='offcanvas']").click();
    }
  });
</script>
<?php
if (Yii::app()->user->isGuest){
    echo '<script> $.backstretch("'.Yii::app()->baseUrl.'/images/1.jpg");</script>';
}
?>
</body>
</html>
