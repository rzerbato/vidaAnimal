<?php
$this->breadcrumbs=array(
	'Rubros'=>array('admin'),
	'Crear',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Rubros','url'=>array('admin')),
);
?>

<h1>Nuevo Rubro</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>
