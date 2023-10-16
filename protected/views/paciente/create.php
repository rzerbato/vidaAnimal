<?php
$this->breadcrumbs=array(
	'Pacientes'=>array('admin'),
	'Crear',
);

$this->menu=array(
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Pacientes','url'=>array('admin')),
);
?>

<h1>Nuevo Paciente</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model, 'idRaza'=>$idRaza, 'modelCliente'=>$modelCliente)); ?>
