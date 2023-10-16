<?php
$this->breadcrumbs=array(
	'Especies'=>array('admin'),
	'Crear',
);

$this->menu=array(
		array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Especies','url'=>array('admin')),
);
?>

<h1>Nueva Especie</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>
