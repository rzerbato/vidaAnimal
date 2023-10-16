<?php

$this->breadcrumbs=array(
	'Especies'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idespecie),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List Especie','url'=>array('index')),
	array('label'=>'Create Especie','url'=>array('create')),
	array('label'=>'View Especie','url'=>array('view','id'=>$model->idespecie)),
	array('label'=>'Manage Especie','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Especie','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Especie','url'=>array('view','id'=>$model->idespecie)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Especies','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Especie <?php #echo $model->idespecie; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>
