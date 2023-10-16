<?php
$this->breadcrumbs=array(
	'Rubros'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idRubro),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List Rubro','url'=>array('index')),
	array('label'=>'Create Rubro','url'=>array('create')),
	array('label'=>'View Rubro','url'=>array('view','id'=>$model->idRubro)),
	array('label'=>'Manage Rubro','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Rubro','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Rubro','url'=>array('view','id'=>$model->idRubro)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Rubros','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Rubro <?php #echo $model->idRubro; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>
