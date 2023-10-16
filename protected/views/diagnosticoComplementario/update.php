<?php
/* @var $this DiagnosticocomplementarioController */
/* @var $model Diagnosticocomplementario */

$this->breadcrumbs=array(
	'Diagnosticocomplementarios'=>array('index'),
	$model->iddiagnosticoComplementario=>array('view','id'=>$model->iddiagnosticoComplementario),
	'Update',
);

$this->menu=array(
	array('label'=>'List Diagnosticocomplementario', 'url'=>array('index')),
	array('label'=>'Create Diagnosticocomplementario', 'url'=>array('create')),
	array('label'=>'View Diagnosticocomplementario', 'url'=>array('view', 'id'=>$model->iddiagnosticoComplementario)),
	array('label'=>'Manage Diagnosticocomplementario', 'url'=>array('admin')),
);
?>

<h1>Update Diagnosticocomplementario <?php echo $model->iddiagnosticoComplementario; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>