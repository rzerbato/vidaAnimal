<?php
$this->breadcrumbs=array(
	'Productos'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idproducto),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List Producto','url'=>array('index')),
	array('label'=>'Create Producto','url'=>array('create')),
	array('label'=>'View Producto','url'=>array('view','id'=>$model->idproducto)),
	array('label'=>'Manage Producto','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Producto','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Producto','url'=>array('view','id'=>$model->idproducto)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Productos','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Producto <?php echo $model->nombre; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model,'idSubrubro'=>$idSubrubro, 'idMarca'=>$idMarca, 'precioConfig'=>$precioConfig)); ?>
