<?php
$this->breadcrumbs=array(
	'Tipos de Consultas'=>array('admin'),
	'Crear',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Tipos de Consulta','url'=>array('admin')),
);
?>

<h1>Nuevo Tipo de Consulta</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>