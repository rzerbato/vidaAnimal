<?php
$this->breadcrumbs=array(
	'Localidades'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idlocalidad),
	'Actualizar',
);

	$this->menu=array(
	//array('label'=>'List Localidad','url'=>array('index')),
	//array('label'=>'Create Localidad','url'=>array('create')),
	//array('label'=>'View Localidad','url'=>array('view','id'=>$model->idlocalidad)),
	//array('label'=>'Manage Localidad','url'=>array('admin')),
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Localidad','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Localidad','url'=>array('view','id'=>$model->idlocalidad)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Localidades','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Localidad <?php # echo $model->idlocalidad; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>
