<?php
$this->breadcrumbs=array(
	'Tipos de Consulta'=>array('admin'),
	$model->nombre=>array('view','id'=>$model->idtipoConsulta),
	'Actualizar',
);

	$this->menu=array(
	/*array('label'=>'List TipoConsulta','url'=>array('index')),
	array('label'=>'Create TipoConsulta','url'=>array('create')),
	array('label'=>'View TipoConsulta','url'=>array('view','id'=>$model->idtipoConsulta)),
	array('label'=>'Manage TipoConsulta','url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Tipo de Consulta','url'=>array('create')),
	array('label'=>'<i class="fa fa-eye fa-fw"></i> Ver Tipo de Consulta','url'=>array('view','id'=>$model->idtipoConsulta)),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Tipos de Consulta','url'=>array('admin')),
	);
	?>

	<h1>Actualizar Tipo de Consulta</h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>