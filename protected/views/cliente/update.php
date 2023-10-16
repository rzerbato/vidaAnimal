<?php
$this->breadcrumbs=array(
	'Clientes'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idcliente),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List Cliente','url'=>array('index')),
	array('label'=>'Create Cliente','url'=>array('create')),
	array('label'=>'View Cliente','url'=>array('view','id'=>$model->idcliente)),
	array('label'=>'Manage Cliente','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Cliente','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Cliente','url'=>array('view','id'=>$model->idcliente)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Clientes','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Cliente <?php #echo $model->idcliente; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model, 'idLocalidad' => $idLocalidad)); ?>
