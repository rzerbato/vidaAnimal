<?php
$this->breadcrumbs=array(
	'Razas'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idraza),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List Raza','url'=>array('index')),
	array('label'=>'Create Raza','url'=>array('create')),
	array('label'=>'View Raza','url'=>array('view','id'=>$model->idraza)),
	array('label'=>'Manage Raza','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Raza','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Raza','url'=>array('view','id'=>$model->idraza)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Razas','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Raza <?php #echo $model->idraza; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model, 'modeloEspecie'=>$modeloEspecie)); ?>
