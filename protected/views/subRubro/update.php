<?php
$this->breadcrumbs=array(
	'Subrubros'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idSubRubro),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List SubRubro','url'=>array('index')),
	array('label'=>'Create SubRubro','url'=>array('create')),
	array('label'=>'View SubRubro','url'=>array('view','id'=>$model->idSubRubro)),
	array('label'=>'Manage SubRubro','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Subrubro','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Subrubro','url'=>array('view','id'=>$model->idSubRubro)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Subrubros','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Subrubro <?php #echo $model->idSubRubro; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>
