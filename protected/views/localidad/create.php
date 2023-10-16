<?php
$this->breadcrumbs=array(
	'Localidades'=>array('admin'),
	'Crear',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Localidades','url'=>array('admin')),
);
?>

<h1>Nueva Localidad</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>
