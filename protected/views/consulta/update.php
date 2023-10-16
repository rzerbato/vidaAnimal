<?php
/* @var $this ConsultaController */
/* @var $model Consulta */

$this->breadcrumbs=array(
	'Consultas'=>array('index'),
	$model->idconsulta=>array('view','id'=>$model->idconsulta),
	'Update',
);

$this->menu=array(
	array('label'=>'List Consulta', 'url'=>array('index')),
	array('label'=>'Create Consulta', 'url'=>array('create')),
	array('label'=>'View Consulta', 'url'=>array('view', 'id'=>$model->idconsulta)),
	array('label'=>'Manage Consulta', 'url'=>array('admin')),
);
?>

<h1>Update Consulta <?php echo $model->idconsulta; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>