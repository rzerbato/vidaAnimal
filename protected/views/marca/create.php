<?php
$this->breadcrumbs=array(
	'Marcas'=>array('index'),
	'Crear',
);

$this->menu=array(
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Marcas','url'=>array('admin')),
);
?>

<h1>Nueva Marca</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>
