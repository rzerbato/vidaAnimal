<?php
$this->breadcrumbs=array(
	'Subrubros'=>array('admin'),
	'Crear',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Subrubros','url'=>array('admin')),
);
?>

<h1>Nuevo Subrubro</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>
