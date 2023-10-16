<?php
$this->breadcrumbs=array(
	'Razas'=>array('admin'),
	'Crear',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Razas','url'=>array('admin')),
);
?>

<h1>Nueva Raza</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model, 'modeloEspecie'=>$modeloEspecie)); ?>
