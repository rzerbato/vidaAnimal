<?php
$this->breadcrumbs=array(
	'Marcas'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idmarca),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List Marca','url'=>array('index')),
	array('label'=>'Create Marca','url'=>array('create')),
	array('label'=>'View Marca','url'=>array('view','id'=>$model->idmarca)),
	array('label'=>'Manage Marca','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Marca','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Marca','url'=>array('view','id'=>$model->idmarca)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Marcas','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Marca <?php #echo $model->idmarca; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>
