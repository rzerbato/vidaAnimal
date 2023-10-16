<?php
$this->breadcrumbs=array(
	'Clientes'=>array('admin'),
	'Crear',
);

$this->menu=array(
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Clientes','url'=>array('admin')),
);
?>

<h1>Nuevo Cliente</h1>


<?php echo $this->renderPartial('_form', array('model'=>$model, 'idLocalidad'=>$idLocalidad,)); ?>
