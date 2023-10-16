<?php
$this->breadcrumbs=array(
	'Productos'=>array('admin'),
	'Crear',
);

$this->menu=array(
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Productos','url'=>array('admin')),
);
?>

<h1>Nuevo Producto</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model, 'idSubrubro'=>$idSubrubro, 'idMarca'=>$idMarca, 'precioConfig'=>$precioConfig)); ?>