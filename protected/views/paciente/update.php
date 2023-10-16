<?php
$this->breadcrumbs=array(
	'Pacientes'=>array('index'),
	$model->nombre=>array('view','id'=>$model->idpaciente),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List Paciente','url'=>array('index')),
	array('label'=>'Create Paciente','url'=>array('create')),
	array('label'=>'View Paciente','url'=>array('view','id'=>$model->idpaciente)),
	array('label'=>'Manage Paciente','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Paciente','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Paciente','url'=>array('view','id'=>$model->idpaciente)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Pacientes','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Paciente <?php echo $model->nombre; ?></h1>

<?php #echo $this->renderPartial('_form',array('model'=>$model)); ?>
<?php echo $this->renderPartial('_form', array('model'=>$model, 'idRaza'=>$idRaza, 'modelCliente'=>$modelCliente,)); ?>
