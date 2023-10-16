<?php
/* @var $this DiagnosticocomplementarioController */
/* @var $model Diagnosticocomplementario */

$this->breadcrumbs=array(
	'Consultas'=>array('consulta/update','id'=>$_GET['id']),
	'Crear Diagnostico Complementario',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-close fa-fw"></i> Cancelar','url'=>array('consulta/update','id'=>$_GET['id'])),
	
);
?>

<h1>Crear Diagnostico Complementario</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>